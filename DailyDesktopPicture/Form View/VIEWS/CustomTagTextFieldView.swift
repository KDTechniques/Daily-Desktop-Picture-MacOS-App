//
//  CustomTagTextFieldView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

struct CustomTagTextFieldView: View {
    // MARK: - PROPERTIES
    @Environment(DailyDesktopPictureViewModel.self) private var vm
    
    // MARK: - BODY
    var body: some View {
        HStack {
            TextField("Custom Tag",
                      text: Binding(get: { vm.cutomTagTextFieldText }, set: { vm.cutomTagTextFieldText = $0 }),
                      prompt: Text("Ex: nature")
            )
            .onSubmit {
                vm.createCustomTag()
            }
            
            Button("Create") {
                vm.createCustomTag()
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("CustomTagTextFieldView") {
    CustomTagTextFieldView()
        .padding()
        .environment(DailyDesktopPictureViewModel())
}
