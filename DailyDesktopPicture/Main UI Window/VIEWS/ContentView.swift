//
//  ContentView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-17.
//

import SwiftUI

struct ContentView: View {
    // MARK: - BODY
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                AppDescriptionTextView()
                
                DividerView()
                
                LaunchAtLoginCheckBoxView()
                
                EndpointSelectionView()
                
                VStack(alignment: .leading, spacing: 20) {
                    SelectedTagView()
                    CustomTagTextFieldView()
                    CustomTagsVerticalScrollView()
                }
                
                RemoveAllCustomTagsButtonView()
                
                DividerView()
                
                APIKeyWindowOpenButtonView()
                
                Spacer()
                
                DividerView()
                
                HStack {
                    RestoreDefaultSettingsButtonView()
                    Spacer()
                    QuitAppButtonView()
                }
            }
            .padding()
        }
        .frame(width: 400, height: 500)
    }
}

// MARK: - PREVIEWS
#Preview("Daily Desktop Picture") {
    ContentView()
        .environment(DailyDesktopPictureViewModel())
}
