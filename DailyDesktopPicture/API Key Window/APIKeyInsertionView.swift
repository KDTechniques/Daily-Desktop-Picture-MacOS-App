//
//  APIKeyInsertionView.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-20.
//

import SwiftUI

struct APIKeyInsertionView: View {
    // MARK: - PROPERTIES
    @State private var vm: APIKeyWindowViewModel
    @FocusState private var isTextFieldFocused: Bool
    
    init(dailyDesktopPictureVM: DailyDesktopPictureViewModel) {
        vm = .init(dailyDesktopPictureViewModel: dailyDesktopPictureVM)
    }
    
    // MARK: - BODY
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Your API Access Key",
                              text: $vm.apiKeyTextFieldText,
                              prompt: Text("Ex: 2in4w8v0oGOqdQdPsnKBF2d5-je8fyJs8YkEsfvNaY0")
                    )
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        unfocusTextField()
                        vm.connectAPIKey()
                    }
                    
                    Button("Connect") {
                        unfocusTextField()
                        vm.connectAPIKey()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("How to Get Your Unsplash API Key?")
                        .fontWeight(.semibold)
                        .underline()
                    
                    VStack(alignment: .leading) {
                        Text("1. Visit Unsplash Developers")
                        Text("• Go to the [Unsplash Developer Portal](https://unsplash.com/developers) in your web browser.")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("2. Log In or Sign Up")
                        Text("• If you already have an Unsplash account, log in with your credentials.")
                        Text("• If not, create a free Unsplash account by clicking \"Join Free\" and completing the sign-up process.")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("3. Create a New Application")
                        Text("• After logging in, click on your profile picture in the top-right corner and select \"API/Developers\".")
                        Text("• Click on the \"New Application\" button.")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("4. Fill Out Application Details")
                        Text("• Enter a name for your application (e.g., \"My Wallpaper App\").")
                        Text("• Add the following brief description of what this app does.")
                        Text("• Leave other fields blank.")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("5. Submit Your Application")
                        Text("• Click \"Create Application\" at the bottom of the form.")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("6. Get Your API Key")
                        Text("• After creating the application, you’ll see your Access Key.")
                        Text("• Copy this key and paste it into the input field above.")
                    }
                }
                .font(.footnote)
                .padding(.top)
            }
            .padding(.vertical)
        }
        .frame(width: 600, height: 350)
        .padding()
    }
}

// MARK: - PREVIEWS
#Preview("APIKeyInsertionView") {
    APIKeyInsertionView(dailyDesktopPictureVM: DailyDesktopPictureViewModel())
}

extension APIKeyInsertionView {
    // MARK: - Unfocus Text Field
    private func unfocusTextField() {
        isTextFieldFocused = false
    }
    
    
}
