//
//  SDBeachReportApp.swift
//  SD Beach Report
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

@main
struct SDBeachReportApp: App {
    @StateObject var repository = BeachReportRepository()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(repository)
        }
    }
}

#Preview {
    @Previewable @StateObject var repository = BeachReportRepository()
    MainView()
        .environmentObject(repository)
}
