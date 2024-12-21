//
//  AppDescriptionTextView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct AppDescriptionTextView: View {
    // MARK: - BODY
    var body: some View {
        Text("Daily Desktop Picture is designed to enhance the MacOS desktop experience by automatically setting a new wallpaper daily. It pulls high-quality images from the API, ensuring a fresh and visually appealing backdrop each time. The app seamlessly integrates with MacOS, downloading the image once a day and updating the desktop picture without user intervention. This creates a dynamic, ever-changing desktop environment that can inspire creativity and boost productivity.")
            .font(.system(size: 8, design: .monospaced))
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - PREVIEWS
#Preview("AppDescriptionTextView") {
    VStack {
        AppDescriptionTextView()
            .padding()
        
        Spacer()
    }
}
