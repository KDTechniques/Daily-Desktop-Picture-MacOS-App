//
//  UtilityErrorModel.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-19.
//

import Foundation

enum UtilityErrorModel: Error, LocalizedError {
    case userDefaultsEncodingFailed(object: String?, key: String?, error: Error?)
    
    var errorDescription: String? {
        switch self {
        case .userDefaultsEncodingFailed(let object, let key, let error):
            return "Error: Failed to save object(\(object ?? "Unknown")) to User Defaults key(\(key ?? "Unknown")) during encoding. \(error?.localizedDescription ?? "No further details available.")"
        }
    }
}
