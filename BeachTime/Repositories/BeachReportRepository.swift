//
//  BeachReport.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import Foundation
internal import Combine
internal import System

@MainActor
class BeachReportRepository: ObservableObject {
    @Published var reports: [BeachReport] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    var favorites: [BeachReport] {
        reports.filter { $0.favorite }
    }
    
    var sortedReports: [BeachReport] {
        let order = [1, 3, 2]
        return reports.sorted {
            (order.firstIndex(of: $0.indicatorID) ?? 999) <
            (order.firstIndex(of: $1.indicatorID) ?? 999)
        }
    }
    
    private let url = URL(string: "https://www.sdbeachinfo.com/Home/GetTargetByID")!
    
    init() {
        Task {
            try await fetchReports()
        }
    }
    
    func fetchReports() async throws {
        isLoading = true
        error = nil
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            reports = try JSONDecoder().decode([BeachReport].self, from: data).filter { $0.indicatorID != 4 }
            await loadFavorites()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func toggleFavorite(for report: BeachReport) {
        if let index = reports.firstIndex(where: { $0.dehID == report.dehID }) {
            reports[index].favorite.toggle()
            saveFavorites()
        }
    }
    
    private let favoritesKey = "favoriteDehIDs"

    func saveFavorites() {
        let ids = reports.filter { $0.favorite }.map { $0.dehID }
        UserDefaults.standard.set(ids, forKey: favoritesKey)
    }

    func loadFavorites() async {
        let savedIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        for index in reports.indices {
            reports[index].favorite = savedIDs.contains(reports[index].dehID)
        }
    }
}
