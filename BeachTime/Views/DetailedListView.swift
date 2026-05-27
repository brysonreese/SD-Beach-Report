//
//  DetailedListView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct DetailedListView: View {
    @EnvironmentObject var repository: BeachReportRepository
    
    var body: some View {
        NavigationView {
            Group {
                if repository.isLoading {
                    ProgressView("Loading...")
                } else if let error = repository.error {
                    Text("Error: \(error.localizedDescription)")
                } else {
                    NavigationView {
                        List(repository.reports, id: \.siteID) { report in
                            NavigationLink(destination: DetailsView(report: report)){
                                BeachReportRow(report: report)
                            }
                        }.navigationTitle(Text("Beach Reports"))
                    }
                }
            }
        }
    }
}
