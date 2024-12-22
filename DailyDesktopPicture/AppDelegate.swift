//
//  AppDelegate.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: PROPERTIES
    var dailyDesktopPictureVM: DailyDesktopPictureViewModel?
    var statusItem: NSStatusItem?
    
    // MARK: - PRIVATE PROPERTIES
    let windowValues = WindowValues.self
    
    // MARK: FUNCTIONS
    
    // MARK: - applicationDidFinishLaunching
    func applicationDidFinishLaunching(_ notification: Notification) {
        closeMainAppOnLaunch()
        
        // Create Status Bar
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "bird.fill", accessibilityDescription: "Daily Desktop Picture App")
        }
        
        // Create the Menu
        let menu = NSMenu()

        // Create "Show Main UI" menu item
        let showMainUIMenuItem = NSMenuItem(title: "Show Main UI", action: #selector(showMainUI), keyEquivalent: "")
        showMainUIMenuItem.target = self // Set the target
        menu.addItem(showMainUIMenuItem)

        // Add a separator
        menu.addItem(NSMenuItem.separator())

        // Create "Force Change the Desktop Picture" menu item
        let changeDesktopPictureMenuItem = NSMenuItem(title: "Force Change the Desktop Picture", action: #selector(changeDesktopPicture), keyEquivalent: "")
        changeDesktopPictureMenuItem.target = self // Set the target
        menu.addItem(changeDesktopPictureMenuItem)

        // Add another separator
        menu.addItem(NSMenuItem.separator())

        // Create "Quit" menu item
        let quitMenuItem = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q")
        quitMenuItem.target = self // Set the target
        menu.addItem(quitMenuItem)
        
        statusItem?.menu = menu
    }
    
    // MARK: - forceChangeDesktopPicture
    @objc func changeDesktopPicture(sender: NSMenuItem) {
        Task {
            do {
                try await dailyDesktopPictureVM?.forceChangeDesktopPicture()
            } catch {
                print("An error occured while changing desktop picture: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - showMainUI
    @objc func showMainUI(sender: NSMenuItem) {
        Utilities.openWindow(.main)
    }
    
    // MARK: - closeMainAppOnLaunch
    func closeMainAppOnLaunch() {
        Utilities.closeWindow(.main)
    }
    
    // MARK: - quitApp
    @objc func quitApp(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}
