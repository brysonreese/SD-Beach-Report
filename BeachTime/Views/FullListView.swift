//
//  FullListView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct FullListView: View {
    @EnvironmentObject var repository: BeachReportRepository
    
    var body: some View {
        NavigationStack {
            Group {
                if repository.isLoading {
                    ProgressView("Loading...")
                } else if let error = repository.error {
                    Text("Error: \(error.localizedDescription)")
                } else {
                    BeachList(beaches: repository.sortedReports)
                }
            }
            .navigationTitle("Beach Reports")
        }
    }
}
