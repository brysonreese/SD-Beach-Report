//
//  String+Extensions.swift
//  BeachTime
//
//  Created by Bryson Reese on 5/27/26.
//

import Foundation
internal import UIKit

extension String {
    var htmlParsed: AttributedString {
        guard let data = self.data(using: .utf8),
              let nsAttributed = try? NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
              ) else {
            return AttributedString(self)
        }
        
        var attributed = (try? AttributedString(nsAttributed, including: \.uiKit)) ?? AttributedString(self)
        attributed.font = .preferredFont(forTextStyle: .body)
        attributed.foregroundColor = .label
        return attributed
    }
}
