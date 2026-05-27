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
    
    var pinColor: Color {
        switch report.indicatorID {
        case 1: return .red
        case 2: return .green
        case 3: return .yellow
        default: return .gray
        }
    }
    
    var body: some View {
        Circle()
            .fill(pinColor)
            .frame(width: 16, height: 16)
            .overlay(Circle().stroke(.white, lineWidth: 2))
    }
}
