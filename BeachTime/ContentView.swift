//
//  ContentView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Reports", systemImage: "list.clipboard") {
                FullListView()
            }
            Tab("Favorites", systemImage: "star") {
                FavoritesView()
            }
            Tab("Map", systemImage: "map") {
                BeachMapView()
            }
            Tab("Settings", systemImage: "gear") {
                Text("Settings")
            }
        }
    }
}
