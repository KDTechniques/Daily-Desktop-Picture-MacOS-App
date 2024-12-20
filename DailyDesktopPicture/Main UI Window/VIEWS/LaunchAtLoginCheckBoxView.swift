//
//  LaunchAtLoginCheckBoxView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct LaunchAtLoginCheckBoxView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Toggle("Launch at login", isOn: Binding(get: { vm.launchAtLogin }, set: { vm.launchAtLogin = $0 }))
    }
}

// MARK: - PREVIEWS
#Preview("LaunchAtLoginCheckBoxView") {
    LaunchAtLoginCheckBoxView()
        .padding()
        .environment(DailyDesktopPictureViewModel())
}
