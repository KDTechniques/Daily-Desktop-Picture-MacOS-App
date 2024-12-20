//
//  DailyDesktopPicture.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-17.
//

import SwiftUI

@main
struct DailyDesktopPicture: App {
    // MARK: - PROPERTIES
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var dailyDesktopPictureVM: DailyDesktopPictureViewModel = .init()
    let alertManager: AlertsManager = .shared
    let windowValues = WindowValues.self
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup(windowValues.main.title) {
            ContentView()
                .environment(dailyDesktopPictureVM)
                .environment(alertManager)
                .onAppear {
                    // Access the AppDelegate and pass the value
                    appDelegate.dailyDesktopPictureVM = dailyDesktopPictureVM
                }
                .alertViewModifier()
        }
        .defaultPosition(.center)
        .windowResizability(.contentSize)
        .handlesExternalEvents(matching: [windowValues.main.rawValue])
        
        WindowGroup(windowValues.apiKey.title) {
            APIKeyInsertionView(dailyDesktopPictureVM: dailyDesktopPictureVM)
                .environment(alertManager)
        }
        .defaultPosition(.center)
        .windowResizability(.contentSize)
        .handlesExternalEvents(matching: [windowValues.apiKey.rawValue])
    }
}
