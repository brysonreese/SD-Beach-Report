//
//  OnboardingView.swift
//  SD Beach Report
//
//  Created by Bryson Reese on 6/4/26.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: "water.waves")
                .font(.system(size: 60))
                .foregroundStyle(.blue)
            
            VStack(spacing: 12) {
                Text("Welcome to SD Beach Report")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Check real-time water quality at San Diego beaches before you head out.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                OnboardingRow(icon: "checkmark.circle.fill", color: .green, title: "Live Status", description: "Search through real-time water quality data from San Diego County DEH")
                OnboardingRow(icon: "star.fill", color: .yellow, title: "Favorites", description: "Swipe right on a beach to add it to your favorites, long-press and drag to reorder")
                OnboardingRow(icon: "map.fill", color: .blue, title: "Map View", description: "Explore all beaches on an interactive map")
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            Button {
                hasSeenOnboarding = true
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
        .interactiveDismissDisabled()
    }
}

struct OnboardingRow: View {
    let icon: String
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundStyle(color)
                .frame(width: 36)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
