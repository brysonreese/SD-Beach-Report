//
//  DetailsView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct DetailsView: View {
    let report: BeachReport
    @State private var parsedDescription: AttributedString?
    @State private var parsedAdvisory: AttributedString?
    @State private var parsedClosure: AttributedString?
    
    var body: some View {
        List {
            Section("Beach Info") {
                LabeledContent("DEH ID", value: report.dehID)
                LabeledContent("Name", value: report.name)
            }

            Section("Description") {
                if let parsedDescription = parsedDescription {
                    Text(parsedDescription)
                        .font(.body)
                }
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
        }.task {
            parsedDescription = report.description.htmlParsed
            parsedAdvisory = report.advisory?.htmlParsed
            parsedClosure = report.closure?.htmlParsed
        }
        .navigationTitle(report.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
