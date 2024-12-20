//
//  SelectedTagView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct SelectedTagView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text("Selected Tag:")
            
            if !vm.tagSelection.isEmpty {
                Text(vm.tagSelection)
                    .lineLimit(1)
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.accentColor.opacity(0.2))
                    .clipShape(.rect(cornerRadius: 5))
            } else {
                Text("Not Avaialble")
                    .foregroundStyle(.separator)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("SelectedTagView") {
    SelectedTagView()
        .padding()
        .environment(DailyDesktopPictureViewModel())
}
