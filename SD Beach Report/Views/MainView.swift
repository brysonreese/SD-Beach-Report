//
//  MainView.swift
//  SD Beach Report
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
                        VStack {
                            Image(systemName: "list.clipboard")
                            Text("Reports")
                        }.frame(maxHeight: 44)
                    }.buttonStyle(.glass)
                        .buttonSizing(.flexible)
                    NavigationLink(destination: BeachMapView()) {
                        VStack {
                            Image(systemName: "map")
                            Text("Map")
                        }.frame(maxHeight: 44)
                    }.buttonStyle(.glass)
                        .buttonSizing(.flexible)
                }.padding(.top, 8)
                    .padding(.horizontal, 8)
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
                            ForEach(repository.favorites) { report in
                                NavigationLink(destination: DetailsView(siteID: report.siteID)) {
                                    BeachReportRow(report: report)
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        repository.toggleFavorite(for: report)
                                    } label: {
                                        report.favorite ?
                                        Label("Unfavorite", systemImage: "star.slash") :
                                        Label("Favorite", systemImage: "star")
                                    }
                                }
                            }
                            .onMove { from, to in
                                repository.swapFavorites(from, to)
                            }
                        }
                    }
                    
                }.listStyle(.plain)
                    .contentMargins(0)
                Text("Tip: Long press and drag to reorder your favorites!")
                    .font(.caption)
            }.navigationTitle(Text("Welcome!"))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack{
                            Image(systemName: "water.waves").foregroundColor(.blue)
                            Text("SD Beach Report")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
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
