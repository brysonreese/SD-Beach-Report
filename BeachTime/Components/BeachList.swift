//
//  BeachList.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//
import SwiftUI

struct BeachList: View {
    let beaches: [BeachReport]
    @EnvironmentObject var repository: BeachReportRepository
    
    var body: some View {
        List(beaches, id: \.siteID) { report in
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
        }.refreshable{
            do {
                try await repository.fetchReports(isRefreshing: true)
            } catch {
                repository.error = error
            }
        }
    }
}

