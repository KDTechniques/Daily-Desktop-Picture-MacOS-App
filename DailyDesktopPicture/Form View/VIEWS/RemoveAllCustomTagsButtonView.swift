//
//  RemoveAllCustomTagsButtonView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct RemoveAllCustomTagsButtonView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Button("Remove All Tags") {
            vm.removeAllCustomTags()
        }
        .foregroundStyle(.red)
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("RemoveAllCustomTagsButtonView") {
    RemoveAllCustomTagsButtonView()
        .padding()
        .environment(DailyDesktopPictureViewModel())
}
