//
//  WindowValues.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import Foundation

enum WindowValues: String {
    case main
    case apiKey
    
    var title: String {
        switch self {
        case .main:
            return "Daily Desktop Picture"
        case .apiKey:
            return "API Access Key"
        }
    }
    
    var url: URL? {
        return .init(string: "app://\(self.rawValue)")
    }
}
