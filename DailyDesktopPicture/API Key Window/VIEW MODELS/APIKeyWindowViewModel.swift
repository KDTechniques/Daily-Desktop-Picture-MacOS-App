//
//  APIKeyWindowViewModel.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-20.
//

import SwiftUI

@MainActor
@Observable final class APIKeyWindowViewModel {
    // MARK: - PROPERTIES
    let dailyDesktopPictureViewModel: DailyDesktopPictureViewModel
    
    // MARK: - PRIVATE PROPERTIES
    var apiKeyTextFieldText: String = ""

    // MARK: - INITIALIZER
    init(dailyDesktopPictureViewModel: DailyDesktopPictureViewModel) {
        self.dailyDesktopPictureViewModel = dailyDesktopPictureViewModel
    }
    
    // MARK: FUNCTIONS
    
    // MARK: - Connect API Key
    func connectAPIKey() {
        let accessKey: String = apiKeyTextFieldText
        clearTextFieldText()
        saveAPIKeyToUserDefaults(accessKey)
        setAPIKey(accessKey)
    }
    
    func clearTextFieldText() {
        apiKeyTextFieldText = ""
    }
    
    func saveAPIKeyToUserDefaults(_ key: String) {
        let defaults: UserDefaults = .standard
        defaults.set(key, forKey: UserDefaultKeys.apiAccessKey.rawValue)
    }
    
    private func setAPIKey(_ key: String) {
        dailyDesktopPictureViewModel.setAccessKey(key)
    }
}
