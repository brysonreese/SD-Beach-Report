//
//  ContentView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var repository = BeachReportRepository()
    
    var body: some View {
        NavigationView {
            Group {
                if repository.isLoading {
                    ProgressView("Loading...")
                } else if let error = repository.error {
                    Text("Error: \(error.localizedDescription)")
                } else {
                    List(repository.reports, id: \.siteID) { report in
                        VStack(alignment: .leading) {
                            Text(report.name)
                                .font(.headline)
                            Text(report.dehID)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Beach Reports")
        }
    }
}

#Preview {
    ContentView()
}
