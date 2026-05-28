//
//  FullListView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct FullListView: View {
    @EnvironmentObject var repository: BeachReportRepository
    @State var searchText = ""
    
    var filteredReports: [BeachReport] {
        if searchText.isEmpty {
            return repository.sortedReports
        } else {
            return repository.sortedReports.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        List {
            if let error = repository.error {
                ContentUnavailableView {
                    Label("Error", systemImage: "exclamationmark.triangle.fill")
                    Text(error.localizedDescription)
                }
            } else if repository.isLoading {
                ProgressView("Loading...")
            } else {
                Section(header: Text("All Beaches")) {
                    BeachList(beaches: filteredReports)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search beaches")
        .navigationTitle("Beach Reports")
        .refreshable {
            do {
                try await repository.fetchReports(isRefreshing: true)
            } catch {
                repository.error = error
            }
        }
    }
}
