//
//  BeachMapPin.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI
import MapKit

struct BeachMapPin: View {
    let report: BeachReport
    
    var body: some View {
        if report.favorite {
            Image(systemName: "star.fill")
                .foregroundColor(report.statusIcon.color)
                .frame(width: 24, height: 24)
                .overlay(Image(systemName: "star").foregroundColor(.white))
        } else {
            Circle()
                .fill(report.statusIcon.color)
                .frame(width: 16, height: 16)
                .overlay(Circle().stroke(.white, lineWidth: 2))
        }
    }
}
