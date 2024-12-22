//
//  TabViewTemp.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-22.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab = 0
    let tabs = ["Tab 1", "Tab 2", "Tab 3"]
    
    var body: some View {
        VStack {
            // Tab Bar
            HStack(spacing: 20) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text(tabs[index])
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(selectedTab == index ? .blue : .primary)
                        .onTapGesture {
                            
                            selectedTab = index
                            
                        }
                }
            }
            .padding()
            
            // Tab Content
            ZStack {
                if selectedTab == 0 {
                    Text("Content for Tab 1")
                        .font(.title)
                        .transition(.opacity)
                } else if selectedTab == 1 {
                    Text("Content for Tab 2")
                        .font(.title)
                        .transition(.opacity)
                } else {
                    Text("Content for Tab 3")
                        .font(.title)
                        .transition(.opacity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 400, height: 300)
    }
}

#Preview {
    CustomTabView()
}


