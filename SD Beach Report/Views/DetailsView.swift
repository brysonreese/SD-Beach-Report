//
//  DetailsView.swift
//  SDBeachReport
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var repository: BeachReportRepository
    let siteID: Int
    
    var report: BeachReport? {
        repository.reports.first(where: { $0.siteID == siteID })
    }
    @State private var parsedDescription: AttributedString?
    @State private var parsedAdvisory: AttributedString?
    @State private var parsedClosure: AttributedString?
    
    var body: some View {
        if let report = report {
            List {
                Section("Beach Info") {
                    LabeledContent("Name", value: report.cleanName)
                    LabeledContent("Status") {
                        HStack {
                            Text(report.statusIcon.description)
                            Image(systemName: report.statusIcon.iconName)
                                .foregroundColor(report.statusIcon.color)
                        }
                    }
                }
                
                Button {
                    repository.toggleFavorite(for: report)
                } label: {
                    report.favorite ?
                    Label("Remove Favorite", systemImage: "star.fill") :
                    Label("Add Favorite", systemImage: "star")
                }
                
                if report.advisory != nil && report.advisory != "" {
                    Section("Advisories") {
                        if let advisory = parsedAdvisory {
                            Text(advisory)
                        }
                    }
                }
                
                if report.closure != nil && report.closure != "" {
                    Section("Closure") {
                        if let closure = parsedClosure {
                            Text(closure)
                        }
                    }
                }
                
                Section("Description") {
                    if let parsedDescription = parsedDescription {
                        Text(parsedDescription)
                            .font(.body)
                    }
                }
            }
            .task(id: siteID) {
                parsedDescription = report.description.htmlParsed
                parsedAdvisory = report.advisory?.htmlParsed
                parsedClosure = report.closure?.htmlParsed
            }
            .navigationTitle(report.cleanName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
