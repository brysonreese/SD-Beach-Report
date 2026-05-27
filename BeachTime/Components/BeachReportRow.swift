//
//  BeachReportRow.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct BeachReportRow: View {
    let report: BeachReport
    
    var statusIcon: (name: String, color: Color) {
        switch report.indicatorID {
        case 1: return ("xmark.circle.fill", .red)
        case 2: return ("checkmark.square.fill", .green)
        case 3: return ("exclamationmark.triangle.fill", .yellow)
        default: return ("questionmark.circle.fill", .gray)
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(report.cleanName)
                    .font(.headline)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: statusIcon.name)
                .foregroundStyle(statusIcon.color)
                .font(.system(size: 32))
            
        }
        .padding(.vertical, 4)
    }
}
