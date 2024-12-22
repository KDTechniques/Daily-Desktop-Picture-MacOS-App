//
//  Utilities.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct Utilities {
    // MARK: - Save Data to User Defa
    /// Saves a `Codable` object to `UserDefaults` under a specified key.
    /// - Parameters:
    ///   - object: The `Codable` object to save.
    ///   - key: The `UserDefaultKeys` enum case representing the storage key.
    /// - Throws: A `UtilityErrorModel` if the object fails to encode or save.
    static func saveDataToUserDefaults<T: Codable>(_ object: T, key: UserDefaultKeys) throws {
        // Create a JSONEncoder instance to encode the object into JSON format
        let encoder = JSONEncoder()
        do {
            // Try to encode the provided object into Data
            let data = try encoder.encode(object)
            
            // Save the encoded data to UserDefaults with the specified key
            UserDefaults.standard.set(data, forKey: key.rawValue)
            
            // Log success (optional for debugging)
            print("Successfully saved object (\(type(of: object))) to UserDefaults with key (\(key.rawValue)).")
        } catch {
            // Throw a custom error if encoding fails
            throw UtilityErrorModel.userDefaultsEncodingFailed(
                object: String(describing: object),
                key: key.rawValue,
                error: error
            )
        }
    }
    
    // MARK: - Retrieve Data from User Defaults
    // Generic function to retrieve a Codable object from UserDefaults
    static func retrieveDataFromUserDefaults<T: Codable>(key: UserDefaultKeys, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(T.self, from: data)
                return object
            } catch {
                print("Failed to decode object from UserDefaults: \(error)")
            }
        }
        return nil
    }
    
    // MARK: - Get Alert
    static func getAlert(_ object: AlertsModel) -> Alert {
        let title: Text = .init(object.title)
        let message: Text? = object.message.map(Text.init)
        
        if let secondaryButton: Alert.Button = object.secondaryButton {
            return .init(
                title: title,
                message: message,
                primaryButton: object.primaryButton,
                secondaryButton: secondaryButton
            )
        } else {
            return .init(
                title: title,
                message: message,
                dismissButton: object.primaryButton
            )
        }
    }
    
    // MARK: - Open Window
    static func openWindow(_ window: WindowValues) {
        if let window = NSApplication.shared.windows.first(where: { $0.title == window.title }) {
            if !window.isVisible {
                NSApp.activate(ignoringOtherApps: true)
                window.orderFrontRegardless()
            }
        } else {
            if let url: URL = window.url {
                NSWorkspace.shared.open(url)
            }
        }
    }
    
    // MARK: - Close Window
    static func closeWindow(_ window: WindowValues) {
        guard let window = NSApplication.shared.windows.first(where: { $0.title == window.title }),
        !window.isVisible else { return }
        
        NSApp.activate(ignoringOtherApps: true)
        window.orderFrontRegardless()
    }
}
