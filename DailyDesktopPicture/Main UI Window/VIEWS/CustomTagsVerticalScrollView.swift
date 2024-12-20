//
//  CustomTagsVerticalScrollView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct CustomTagsVerticalScrollView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - PRIVATE PROPERTIES
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(Array(vm.customTagsSet), id: \.self) { tag in
                    let color: Color = .random
                    Button {
                        vm.setCustomTag(tag)
                    } label: {
                        tagContainer(tag, color)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(10)
        }
        .frame(height: 100)
        .border(.separator, width: 0.5)
    }
}

// MARK: - PREVIEWS
#Preview("CustomTagsVerticalScrollView") {
    CustomTagsVerticalScrollView()
        .frame(maxWidth: .infinity)
        .padding()
        .environment(DailyDesktopPictureViewModel())
}

// MARK: - EXTENSIONS
extension CustomTagsVerticalScrollView {
    private func tagText(_ tag: String, _ color: Color) -> some View {
        Text(tag)
            .lineLimit(1)
            .foregroundStyle(isSelectedTagEqualstToGivenTag(tag) ? .white : color)
    }
    
    private func removeButton(_ tag: String, _ color: Color) -> some View {
        Button {
            vm.removeCustomTag(tag)
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(isSelectedTagEqualstToGivenTag(tag) ? .white : color)
        }
        .buttonStyle(.plain)
    }
    
    private func tagContainer(_ tag: String, _ color: Color) -> some View {
        HStack(alignment: .center, spacing: 4) {
            tagText(tag, color)
            removeButton(tag, color)
        }
        .padding(4)
        .background(color.opacity(isSelectedTagEqualstToGivenTag(tag) ? 1 : 0.2))
        .clipShape(.rect(cornerRadius: 5))
    }
    
    private func isSelectedTagEqualstToGivenTag(_ tag: String) -> Bool {
        vm.tagSelection.lowercased() == tag.lowercased()
    }
}

