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
        menu.addItem(NSMenuItem(title: "Show Main UI", action: #selector(showMainUI), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Force Change the Desktop Picture", action: #selector(changeDesktopPicture), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: ""))
        statusItem?.menu = menu
    }
    
    // MARK: - forceChangeDesktopPicture
    @objc func changeDesktopPicture() {
        Task {
            do {
                try await dailyDesktopPictureVM?.forceChangeDesktopPicture()
            } catch {
                print("An error occured while changing desktop picture: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - showMainUI
    @objc func showMainUI() {
        Utilities.openWindow(.main)
    }
    
    // MARK: - closeMainAppOnLaunch
    func closeMainAppOnLaunch() {
        Utilities.closeWindow(.main)
    }
    
    // MARK: - quitApp
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
