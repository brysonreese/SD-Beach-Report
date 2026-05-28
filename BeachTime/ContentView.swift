//
//  ContentView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: BeachMapView()) {
                    Label("Map", systemImage: "map")
                }
                NavigationLink(destination: FullListView()) {
                    Label("Beach Reports", systemImage: "list.clipboard")
                }
                NavigationLink(destination: FavoritesView()) {
                    Label("Favorites", systemImage: "star")
                }
            }
            .navigationTitle("Beach Time")
        }
    }
}
