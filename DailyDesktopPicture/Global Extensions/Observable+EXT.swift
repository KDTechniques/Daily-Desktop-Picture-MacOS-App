//
//  Observable+EXT.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-20.
//

import SwiftUICore

extension Observable {
    // MARK: - Binding
    func binding<T>(_ keyPath: ReferenceWritableKeyPath<Self, T>) -> Binding<T> {
        Binding(
            get: { self[keyPath: keyPath] },
            set: { self[keyPath: keyPath] = $0 }
        )
    }
}
