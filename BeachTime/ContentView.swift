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
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Reports", systemImage: "list.clipboard") {
                DetailedListView()
            }
            Tab("Settings", systemImage: "gear") {
                Text("Settings")
            }
         }
    }
}
