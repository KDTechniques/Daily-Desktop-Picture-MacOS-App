//
//  DailyDesktopPictureViewModel.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI
import LaunchAtLogin

struct DefaultValues {
    static let launchAtLogin: Bool = true
    static let endpointSelection: EndpointTypes = .random
    static let tagSelection: String = ""
    static let customTagsSet: Set<String> = ["Dog", "Car", "Bird", "Nature", "Beach", "Mountain", "Cat", "Forest", "Apple", "Banana", "Cherry"] // set to empty [] later...
}

@MainActor
@Observable
final class DailyDesktopPictureViewModel {
    // MARK: - PROPERTIES
    let defaults: UserDefaults = .standard
    let defaultKeys = UserDefaultKeys.self
    let defaultValues = DefaultValues.self
    let utilities = Utilities.self
    
    var launchAtLogin: Bool = DefaultValues.launchAtLogin {
        didSet {
            defaults.set(launchAtLogin, forKey: defaultKeys.launchAtLoginKey.rawValue)
            LaunchAtLogin.isEnabled = launchAtLogin
        }
    }
    var endpointSelection: EndpointTypes = DefaultValues.endpointSelection {
        didSet {
            do {
                try utilities.saveDataToUserDefaults(endpointSelection, key: .endpointSelection)
            } catch {
                print(error.localizedDescription)
                // show an alert here.
            }
        }
    }
    var tagSelection: String = DefaultValues.tagSelection {
        didSet {
            defaults.set(tagSelection, forKey: defaultKeys.tagSelection.rawValue)
        }
    }
    var customTagsSet: Set<String> = DefaultValues.customTagsSet {
        didSet {
            defaults.set(Array(customTagsSet), forKey: defaultKeys.customTagsSet.rawValue)
        }
    }
    
    var cutomTagTextFieldText: String = ""
    
    
    @ObservationIgnored var downloadManager: DownloadManager = .init()
    @ObservationIgnored var wallpaperManager: WallpaperManager = .shared
    @ObservationIgnored var fileStorageManager: FileStorageManager = .init()
    @ObservationIgnored var imageAPIService: UnsplashAPIService = .init()
    
    // MARK: - INITIALIZER
    init() {
        initializeUserDefaults()
    }
    
    // MARK: FUNCTIONS
    
#if DEBUG
    // MARK: - removeAllUserDefaults
    // Note: Debug Purposes Only
    /// this removes all the saved user defaults
    private func removeAllUserDefaults() {
        let dictionary = UserDefaults.standard.dictionaryRepresentation()
        
        for key in dictionary.keys {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
#endif
    
    // MARK: - initializeUserDefaults
    /// this takes care of initial user defaults related logics
    private func initializeUserDefaults() {
        if defaults.bool(forKey: defaultKeys.hasFirstLaunchKey.rawValue) {
            getNSetFromUserDefaults()
        } else {
            setInitialDefaultValuesToUserDefaults()
        }
        
        /// once the first initializations are over due to first app launch, we set the `hasFirstLaunch` to true.
        /// and then on it always get set as true.
        defaults.setValue(true, forKey: defaultKeys.hasFirstLaunchKey.rawValue)
    }
    
    // MARK: - setInitialDefaultValuesToUserDefaults
    // this sets initial default values assigned to properties to their respected user defaults
    private func setInitialDefaultValuesToUserDefaults() {
        defaults.set(defaultValues.launchAtLogin, forKey: defaultKeys.launchAtLoginKey.rawValue)
        try? utilities.saveDataToUserDefaults(defaultValues.endpointSelection, key: .endpointSelection)
        defaults.set(defaultValues.tagSelection, forKey: defaultKeys.tagSelection.rawValue)
        defaults.set(Array(defaultValues.customTagsSet), forKey: defaultKeys.customTagsSet.rawValue)
    }
    
    // MARK: - getNSetFromUserDefaults
    /// this sets values to releveny variables after first app launch
    private func getNSetFromUserDefaults() {
        launchAtLogin = defaults.bool(forKey: defaultKeys.launchAtLoginKey.rawValue)
        endpointSelection = utilities.retrieveDataFromUserDefaults(key: .endpointSelection, type: EndpointTypes.self) ?? .random
        tagSelection = defaults.string(forKey: defaultKeys.tagSelection.rawValue) ?? ""
        customTagsSet = Set(defaults.stringArray(forKey: defaultKeys.customTagsSet.rawValue) ?? [])
    }
    
    // MARK: - Set Access Key
    func setAccessKey(_ key: String) {
        Task {
            await imageAPIService.saveAccessKeyToUserDefaults(key)
        }
    }
    
    // MARK: - createCustomTag
    func createCustomTag() {
        let modifiedTextCase: String = cutomTagTextFieldText.capitalized
        customTagsSet.insert(modifiedTextCase)
        resetCustomTagTextFieldText()
    }
    
    func resetCustomTagTextFieldText() {
        cutomTagTextFieldText = ""
    }
    
    // MARK: - setCustomTag
    func setCustomTag(_ tag: String) {
        tagSelection = tag
    }
    
    // MARK: - removeCustomTag
    func removeCustomTag(_ tag: String) {
        customTagsSet.remove(tag)
    }
    
    // MARK: - removeAllCustomTags
    func removeAllCustomTags() {
        customTagsSet.removeAll()
        resetTagSelection()
        updateEndpointSelection(.random)
    }
    
    // MARK: - resetTagSelection
    private func resetTagSelection() {
        tagSelection = ""
    }
    
    // MARK: - updateEndpointSelection
    private func updateEndpointSelection(_ endpoint: EndpointTypes) {
        endpointSelection = endpoint
    }
    
    // MARK: - restoreDefaultSettings
    func restoreDefaultSettings() {
        setInitialDefaultValuesToUserDefaults()
        getNSetFromUserDefaults()
    }
    
    // MARK: - forceChangeDesktopPicture
    func forceChangeDesktopPicture() async throws {
        switch endpointSelection {
        case .random:
            guard let randomImageURL: URL = try await imageAPIService.fetchRandomImageURLString() else {
                print("Error occured while fetching a random image url!")
                return
            }
            
            let imageFileURL: URL = try await downloadManager.downloadImage(randomImageURL)
            await wallpaperManager.setDesktopPicture(imageFileURL)
            
        case .customTags:
            guard !tagSelection.isEmpty else {
                print("No Tag is selected!, Please select or create a tag!")
                return
            }
            
            guard let imageURLString: String = try await imageAPIService.fetchQueryImageURLString(tagSelection),
                  let imageURL: URL = .init(string: imageURLString) else {
                print("Error occured while fetching a query image url!")
                return
            }
            
            let imageFileURL: URL = try await downloadManager.downloadImage(imageURL)
            await wallpaperManager.setDesktopPicture(imageFileURL)
        }
    }
}
