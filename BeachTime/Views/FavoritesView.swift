//
//  FavoritesView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var repository: BeachReportRepository
    
    var body: some View {
        NavigationStack {
            Group {
                if let error = repository.error {
                    ScrollView{
                        ContentUnavailableView {
                            Label("Error", systemImage: "exclamationmark.triangle.fill")
                            Text(error.localizedDescription)
                        }
                    }
                } else if repository.isLoading {
                    ProgressView("Loading...")
                } else if repository.favorites.isEmpty {
                    ContentUnavailableView {
                        Label("No Favorites", systemImage: "star.square.on.square")
                        Text("Add favorites to see them here!")
                    }
                } else {
                    BeachList(beaches: repository.favorites)
                }
            }.navigationTitle("Favorites")
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
