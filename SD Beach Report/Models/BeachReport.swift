//
//  BeachReport.swift
//  SDBeachReport
//
//  Created by Bryson Reese on 5/27/26.
//

import Foundation
import SwiftUI

struct BeachReport: Codable, Identifiable {
    var id: Int { siteID }
    var siteID: Int
    var dehID: String
    var name: String
    var latitude: Double
    var longitude: Double
    var indicatorID: Int
    var description: String
    var advisory: String?
    var closure: String?
    var favorite: Bool = false
    
    var cleanName: String {
        name.replacingOccurrences(of: #"\s*\(.*?\)$"#, with: "", options: .regularExpression)
    }
    
    var statusIcon: (iconName: String, color: Color, description: String) {
        switch indicatorID {
        case 1: return ("xmark.circle.fill", .red, "Closed")
        case 2: return ("checkmark.square.fill", .green, "Open")
        case 3: return ("exclamationmark.triangle.fill", .yellow, "Warning")
        default: return ("questionmark.circle.fill", .gray, "Unknown")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case siteID = "SiteID"
        case dehID = "DehID"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case indicatorID = "IndicatorID"
        case description = "Description"
        case advisory = "Advisory"
        case closure = "Closure"
    }
}
