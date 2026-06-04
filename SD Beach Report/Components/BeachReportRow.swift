//
//  BeachReportRow.swift
//  SDBeachReport
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct BeachReportRow: View {
    let report: BeachReport
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: report.statusIcon.iconName)
                .foregroundStyle(report.statusIcon.color)
                .font(.system(size: 32))
            
            Text(report.cleanName)
                .font(.headline)
                .lineLimit(2)
            
            Spacer()
            
            Image(systemName: report.favorite ? "star.fill" : "star")
                .foregroundStyle(report.favorite ? .yellow : .clear)
                .font(.system(size: 14))
            
        }
        .padding(4)
    }
}
