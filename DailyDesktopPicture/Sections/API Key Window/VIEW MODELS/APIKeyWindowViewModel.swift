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
    let defaults: UserDefaults = .standard
    var apiKeyTextFieldText: String = ""
    var apiAccessKeyStatus: APIAccessKeyStatusTypes = .validating
    
    // MARK: - INITIALIZER
    init(dailyDesktopPictureViewModel: DailyDesktopPictureViewModel) {
        self.dailyDesktopPictureViewModel = dailyDesktopPictureViewModel
        getAPIAccessKeyFromUserDefaults()
    }
    
    // MARK: FUNCTIONS
    
    // MARK: - Get API Access Key Status from User Defaults
    private func getAPIAccessKeyFromUserDefaults() {
        let status: APIAccessKeyStatusTypes = Utilities.retrieveDataFromUserDefaults(key: .apiAccessKeyStatus, type: APIAccessKeyStatusTypes.self) ?? .error
        apiAccessKeyStatus = status
    }
    
    // MARK: - Connect API Key
    func connectAPIKey() {
        let accessKey: String = apiKeyTextFieldText
        clearTextFieldText()
        saveAPIKeyToUserDefaults(accessKey)
        setAPIKey(accessKey)
        validateAPIAccessKey()
    }
    
    // MARK: - Clear Text Field Text
    private func clearTextFieldText() {
        apiKeyTextFieldText = ""
    }
    
    // MARK: - Save API Key to User Defaults
    private func saveAPIKeyToUserDefaults(_ key: String) {
        defaults.set(key, forKey: UserDefaultKeys.apiAccessKey.rawValue)
    }
    
    // MARK: - Set API Key
    private func setAPIKey(_ key: String) {
        dailyDesktopPictureViewModel.setAccessKey(key)
    }
    
    // MARK: - Validate API Access Key
    private func validateAPIAccessKey() {
        apiAccessKeyStatus = .validating
        
        Task {
            do {
                guard let _ = try await dailyDesktopPictureViewModel.imageAPIService.fetchRandomImageURLString() else {
                    throw URLError(.badURL)
                }
                apiAccessKeyStatus = .connected
            } catch {
                apiAccessKeyStatus = .error
            }
        }
    }
}
