//
//  DetailsView.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import SwiftUI

struct DetailsView: View {
    let report: BeachReport
    
    var body: some View {
        Text(report.name)
    }
}
