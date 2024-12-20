//
//  DailyDesktopPicture.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-17.
//

import SwiftUI

@main
struct DailyDesktopPicture: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var dailyDesktopPictureVM: DailyDesktopPictureViewModel = .init()
    
    var body: some Scene {
        WindowGroup("Daily Desktop Picture") {
            ContentView()
                .environment(dailyDesktopPictureVM)
                .environment(AlertsManager.shared)
                .onAppear {
                    // Access the AppDelegate and pass the value
                    appDelegate.dailyDesktopPictureVM = dailyDesktopPictureVM
                }
                .alertViewModifier()
        }
        .defaultPosition(.center)
        .windowResizability(.contentSize)
        .handlesExternalEvents(matching: ["main"])
    }
}
