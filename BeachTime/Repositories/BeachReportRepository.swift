//
//  BeachReport.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import Foundation
internal import Combine
internal import System
import SwiftUI

@MainActor
class BeachReportRepository: ObservableObject {
    @Published var reports: [BeachReport] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    var favorites: [BeachReport] {
        let savedIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        var reports: [BeachReport] = []
        for dehId in savedIDs {
            if let report = self.getReportByDehId(dehId) {
                reports.append(report)
            }
        }
        return reports
    }
    
    var sortedReports: [BeachReport] {
        let order = [1, 3, 2]
        return reports.sorted {
            (order.firstIndex(of: $0.indicatorID) ?? 999) <
            (order.firstIndex(of: $1.indicatorID) ?? 999)
        }
    }
    
    private let url = URL(string: "https://www.sdbeachinfo.com/Home/GetTargetByID")!
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5 // seconds to wait for a response
        config.timeoutIntervalForResource = 8 // total time for the whole request
        return URLSession(configuration: config)
    }()
    
    init() {
        Task {
            try await fetchReports()
        }
    }
    
    func getReportByDehId(_ dehId: String) -> BeachReport? {
        return reports.first(where: {$0.dehID == dehId})
    }
    
    func fetchReports(isRefreshing: Bool = false) async throws {
        if(!isRefreshing) {
            isLoading = true
        }
        reports = []
        error = nil
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            reports = try JSONDecoder().decode([BeachReport].self, from: data).filter { $0.indicatorID != 4 }
            await loadFavorites()
        } catch {
            if (error as? URLError)?.code == .cancelled {
            } else {
                self.error = error
                
            }
        }
        
        isLoading = false
    }
    
    func toggleFavorite(for report: BeachReport) {
        
        if let index = reports.firstIndex(where: { $0.dehID == report.dehID }) {
            let savedIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
            if reports[index].favorite {
                saveFavorites(favorites: savedIDs.filter({ $0 != report.dehID }))
            } else {
                saveFavorites(favorites: savedIDs + [report.dehID])
            }
            reports[index].favorite.toggle()
        }
    }
    
    private let favoritesKey = "favoriteDehIDs"

    func saveFavorites(favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
        objectWillChange.send()
    }

    func loadFavorites() async {
        let savedIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        for index in reports.indices {
            reports[index].favorite = savedIDs.contains(reports[index].dehID)
        }
    }
    
    func swapFavorites(_ from: IndexSet, _ to: Int) {
        if var savedIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) {
            savedIDs.move(fromOffsets: from, toOffset: to)
            saveFavorites(favorites: savedIDs)
        }
    }
}
