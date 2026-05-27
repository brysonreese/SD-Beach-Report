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
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
