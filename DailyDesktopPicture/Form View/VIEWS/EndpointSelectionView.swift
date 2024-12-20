//
//  EndpointSelectionView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct EndpointSelectionView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        Picker("Endpoint Selection:", selection: Binding(get: { vm.endpointSelection }, set: { vm.endpointSelection = $0 })) {
            ForEach(EndpointTypes.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .padding(.vertical)
    }
}

// MARK: - PREVIEWS
#Preview("EndpointSelectionView") {
    EndpointSelectionView()
        .padding()
        .environment(DailyDesktopPictureViewModel())
}
