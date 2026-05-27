//
//  HomeView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var repository: BeachReportRepository
    
    var body: some View {
        NavigationStack {
            Group {
                if repository.isLoading {
                    ProgressView("Loading...")
                } else if let error = repository.error {
                    Text("Error: \(error.localizedDescription)")
                } else if repository.favorites.isEmpty {
                    Text("Add favorites to see them here!")
                } else {
                    beachList
                }
            }
            .navigationTitle("Home")
        }
    }
    
    private var beachList: some View {
        List(repository.favorites, id: \.siteID) { report in
            NavigationLink(destination: DetailsView(report: report)) {
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
    }

}
