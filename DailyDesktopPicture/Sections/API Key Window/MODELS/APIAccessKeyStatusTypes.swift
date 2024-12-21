//
//  APIAccessKeyStatusTypes.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-21.
//

import SwiftUICore

enum APIAccessKeyStatusTypes: Codable {
    case validating, error, connected
    
    var text: String {
        switch self {
        case .validating:
            return "Validating"
        case .error:
            return "Error Validating API Access Key"
        case .connected:
            return "Connected"
        }
    }
    
    var textForegroundColor: Color {
        switch self {
        case .validating:
            return .primary
        case .error:
            return .red
        case .connected:
            return .green
        }
    }
    
    @ViewBuilder
    var systemImage: some View {
        switch self {
        case .validating:
            Image(systemName: "dot.radiowaves.left.and.right")
                .symbolEffect(.variableColor.iterative)
        case .error:
            Image(systemName: "exclamationmark.triangle.fill")
                .symbolRenderingMode(.multicolor)
        case .connected:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green.gradient)
        }
    }
    
    var secondaryText: String {
        switch self {
        case .validating:
            return "Connecting to server..."
        case .error:
            return "Check your API Access Key, and internet connection."
        case .connected:
            return "Your API Access Key is valid, and working."
        }
    }
}
