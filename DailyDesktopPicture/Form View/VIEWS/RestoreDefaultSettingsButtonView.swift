//
//  RestoreDefaultSettingsButtonView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct RestoreDefaultSettingsButtonView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Button("Restore default settings") {
            vm.restoreDefaultSettings()
        }
    }
}

// MARK: - PREVIEWS
#Preview("RestoreDefaultSettingsButtonView") {
    RestoreDefaultSettingsButtonView()
}
