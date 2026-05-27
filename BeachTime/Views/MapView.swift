//
//  MapView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import MapKit
import SwiftUI

struct BeachMapView: View {
    @EnvironmentObject var repository: BeachReportRepository
    @State private var selectedReport: BeachReport?
    
    var body: some View {
        Group {
            if repository.isLoading {
                ProgressView("Loading...")
            } else if let error = repository.error {
                ContentUnavailableView {
                    Label("Error", systemImage: "exclamationmark.triangle.fill")
                    Text(error.localizedDescription)
                }
            } else {
                Map {
                    ForEach(repository.reports, id: \.siteID) { report in
                        Annotation(report.name, coordinate: CLLocationCoordinate2D(latitude: report.latitude, longitude: report.longitude)) {
                            BeachMapPin(report: report)
                                .onTapGesture {
                                    selectedReport = report
                                }
                        }
                    }
                }.sheet(item: $selectedReport) { report in
                    DetailsView(report: report)
                        .presentationDetents([.medium, .large])
                }
            }
        }
    }
}
