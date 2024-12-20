//
//  DividerView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct DividerView: View {
    // MARK: - BODY
    var body: some View {
        Divider()
            .padding(.vertical, 5)
    }
}

// MARK: - PREVIEWS
#Preview("DividerView") {
    DividerView()
        .padding()
}
