//
//  MainView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var repository: BeachReportRepository
    
    var body: some View {
        NavigationStack {
            List {
                if let error = repository.error {
                    ContentUnavailableView {
                        Label("Error", systemImage: "exclamationmark.triangle.fill")
                        Text(error.localizedDescription)
                    }
                } else if repository.isLoading {
                    ProgressView("Loading...")
                } else if repository.favorites.isEmpty {
                    ContentUnavailableView {
                        Label("No Favorites", systemImage: "star.slash")
                        Text("Browse beaches to add favorites")
                    }
                } else {
                    BeachList(beaches: repository.favorites)
                }
            }
            .navigationTitle("Beach Time")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FullListView()) {
                        Image(systemName: "list.clipboard")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: BeachMapView()) {
                        Image(systemName: "map")
                    }
                }
            }
            .refreshable{
                do {
                    try await repository.fetchReports(isRefreshing: true)
                } catch {
                    repository.error = error
                }
            }
        }
    }
}
