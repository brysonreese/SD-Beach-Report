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
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var selectedDetent: PresentationDetent = .medium
    @State private var searchText: String = ""
    @State private var mapDidLoad = false
    
    var filteredReports: [BeachReport] {
        if searchText.isEmpty {
            return repository.sortedReports
        } else {
            return repository.sortedReports.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        Group {
            if let error = repository.error {
                ScrollView{
                    ContentUnavailableView {
                        Label("Error", systemImage: "exclamationmark.triangle.fill")
                        Text(error.localizedDescription)
                    }
                }
            } else if repository.isLoading {
                ProgressView("Loading...")
            } else {
                Map(position: $cameraPosition) {
                    UserAnnotation()
                    ForEach(repository.reports, id: \.siteID) { report in
                        Annotation(report.cleanName, coordinate: CLLocationCoordinate2D(
                            latitude: report.latitude,
                            longitude: report.longitude
                        )) {
                            BeachMapPin(report: report)
                                .onTapGesture {
                                    withAnimation {
                                        selectedReport = report
                                        selectedDetent = .medium
                                    }
                                }
                        }
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .onMapCameraChange {
                    guard mapDidLoad else {
                        mapDidLoad = true
                        return
                    }
                    if selectedReport == nil {
                        withAnimation {
                            selectedDetent = .fraction(0.15)
                        }
                    }
                }
                .sheet(isPresented: .constant(true)) {
                    NavigationStack {
                        if let selected = selectedReport {
                            // detail state
                            DetailsView(siteID: selected.siteID)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button {
                                            withAnimation {
                                                selectedReport = nil
                                                selectedDetent = .medium
                                            }
                                        } label: {
                                            HStack {
                                                Image(systemName: "chevron.left")
                                                Text("Beaches")
                                            }
                                        }
                                    }
                                }
                        } else {
                            List {
                                // search bar as header
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.secondary)
                                    TextField("Search beaches...", text: $searchText)
                                        .autocorrectionDisabled()
                                    Button {
                                        searchText = ""
                                    } label: {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                    }
                                }
                                .padding(8)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 4)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                
                                // list content
                                ForEach(filteredReports, id: \.siteID) { report in
                                    Button {
                                        withAnimation {
                                            selectedReport = report
                                            selectedDetent = .medium
                                            cameraPosition = .camera(MapCamera(
                                                centerCoordinate: CLLocationCoordinate2D(
                                                    latitude: report.latitude,
                                                    longitude: report.longitude
                                                ),
                                                distance: 5000
                                            ))
                                        }
                                    } label: {
                                        BeachReportRow(report: report)
                                    }
                                    .tint(.primary)
                                }
                            }.listStyle(.plain)
                        }
                    }
                    .presentationDetents([.fraction(0.15), .medium, .large], selection: $selectedDetent)
                    .presentationBackgroundInteraction(.enabled)
                    .presentationBackground(.regularMaterial)
                    .interactiveDismissDisabled()
                }
            }
        }
    }
}
