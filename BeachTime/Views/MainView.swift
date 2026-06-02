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
            VStack{
                HStack {
                    NavigationLink(destination: FullListView()) {
                        Label("Reports", systemImage: "list.clipboard")
                    }.buttonStyle(.glass)
                        .buttonSizing(.flexible)
                    NavigationLink(destination: BeachMapView()) {
                        Label("Map", systemImage: "map")
                    }.buttonStyle(.glass)
                        .buttonSizing(.flexible)
                }.padding(.top, 8)
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
                        Section(header: Text("Favorites")) {
                            BeachList(beaches: repository.favorites)
                        }
                    }
                    
                }.listStyle(.plain)
                Text("Tip: Long press and drag to reorder your favorites!")
                    .font(.caption)
            }.navigationTitle(Text("SD Beach Report"))
                .navigationSubtitle(Text("Welcome!"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AboutInfoView()) {
                            Image(systemName: "info.circle")
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
