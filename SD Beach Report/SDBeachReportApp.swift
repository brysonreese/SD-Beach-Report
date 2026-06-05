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
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(repository)
                .sheet(isPresented: .constant(!hasSeenOnboarding)) {
                    OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                }
        }
    }
}

#Preview {
    @Previewable @StateObject var repository = BeachReportRepository()
    MainView()
        .environmentObject(repository)
}
