//
//  BeachTimeApp.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

@main
struct BeachTimeApp: App {
    @StateObject var repository = BeachReportRepository()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(repository)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(BeachReportRepository())
}
