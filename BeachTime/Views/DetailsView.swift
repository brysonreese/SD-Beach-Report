//
//  DetailsView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct DetailsView: View {
    let report: BeachReport
    
    var body: some View {
        List {
            Section("Beach Info") {
                LabeledContent("DEH ID", value: report.dehID)
                LabeledContent("Name", value: report.name)
            }
            
            Section("Description") {
                Text(report.description.htmlParsed)
                    .font(.body)
            }
            
            if report.advisory != nil && report.advisory != "" {
                Section("Advisories") {
                    if let advisory = report.advisory {
                        Text(advisory.htmlParsed)
                    }
                }
            }
            
            if report.closure != nil && report.closure != "" {
                Section("Closure") {
                    if let closure = report.closure {
                        Text(closure.htmlParsed)
                    }
                }
            }
        }
        .navigationTitle(report.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
