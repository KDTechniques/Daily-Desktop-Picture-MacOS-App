//
//  APIKeyWindowOpenButtonView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-20.
//

import SwiftUI

struct APIKeyWindowOpenButtonView: View {
    // MARK: - BODY
    var body: some View {
        Button("API Key Configuration") {
            Utilities.openWindow(.apiKey)
        }
    }
}

// MARK: - PREVIEWS
#Preview("APIKeyWindowOpenButtonView") {
    APIKeyWindowOpenButtonView()
        .padding()
}
