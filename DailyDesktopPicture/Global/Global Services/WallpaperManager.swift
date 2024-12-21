//
//  WallpaperManager.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import AppKit

actor WallpaperManager {
    // MARK: - PROPERTIES
    static let shared: WallpaperManager = .init()
    let workspace = NSWorkspace.shared
    var imageFileURL: URL?
    
    // MARK: - INITIALIZER
    private init() {
        // MARK: Notification Observers
        
        // Adding observer for active space change notification
        /// when the user slides through different spaces, we set the desktop picture
        /// because there's no API to change it directly for all the spaces in one go.
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(spaceDidChange),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil
        )
        
        // Adding observer for wake notification
        /// this can be used for things like checking the time and set the desktop picture after 24 hours
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(systemDidWake),
            name: NSWorkspace.didWakeNotification,
            object: nil
        )
    }
    
    // MARK: FUNCTIONS
    
    // MARK: - Set Desktop Picture
    func setDesktopPicture(_ imageFileURL: URL) async {
        let screens: [NSScreen] = NSScreen.screens
        
        // Iterate through screens(monitors) not desktops/spaces
        for screen in screens {
            do {
                // Check if the current wallpaper is the same as the new wallpaper
                guard workspace.desktopImageURL(for: screen) != imageFileURL else {
                    print("No need to change!")
                    return
                }
                
                // Set desktop picture
                try workspace.setDesktopImageURL(imageFileURL, for: screen, options: [:])
                self.imageFileURL = imageFileURL
                print("Wallpaper successfully changed for screen: \(screen.localizedName)")
            } catch {
                print("Failed to set wallpaper for screen \(screen.localizedName): \(error)")
            }
        }
    }
    
    // MARK: - Space Did Change Observer
    // Method to handle active space change
    @MainActor
    @objc private func spaceDidChange(notification: NSNotification) {
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        // Handle the active space change by setting the wallpaper again
        Task {
            await self.updateDesktopPictureIfNeeded()
        }
    }
    
    // MARK: - Space Did Wake Observer
    // Method to handle wake notification
    @MainActor
    @objc private func systemDidWake(notification: NSNotification) {
        print("❤️❤️❤️❤️❤️❤️❤️❤️❤️")
        // Handle the wake event by setting the wallpaper again
        Task {
            await self.updateDesktopPictureIfNeeded()
        }
    }
    
    // MARK: - Update Desktop Picture If Needed
    // Method to update the wallpaper when space changes or the system wakes
    private func updateDesktopPictureIfNeeded() async {
        guard let imageFileURL = imageFileURL else {
            print("Image file url is nil.!")
            return
        }
        // Calling the function to set the wallpaper on all screens
        await setDesktopPicture(imageFileURL)
    }
    
    // Deinitializer to remove observers
    deinit {
        // Remove observers from NSWorkspace.shared.notificationCenter
        NSWorkspace.shared.notificationCenter.removeObserver(self, name: NSWorkspace.activeSpaceDidChangeNotification, object: nil)
        NSWorkspace.shared.notificationCenter.removeObserver(self, name: NSWorkspace.didWakeNotification, object: nil)
    }
}
