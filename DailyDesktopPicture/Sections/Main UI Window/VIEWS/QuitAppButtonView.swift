//
//  QuitAppButtonView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct QuitAppButtonView: View {
    // MARK: - PROPERTIES
    
    
    // MARK: - BODY
    var body: some View {
        Button {
            // Quit app action called here...
        } label: {
            Image(systemName: "power.circle.fill")
                .foregroundStyle(.red)
                .font(.title2)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("QuitAppButtonView") {
    QuitAppButtonView()
}
