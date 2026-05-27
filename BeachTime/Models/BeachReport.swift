//
//  BeachReport.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import Foundation

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
