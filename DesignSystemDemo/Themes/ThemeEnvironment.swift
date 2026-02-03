//
//  ThemeEnvironment.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

// MARK: - Environment Key

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .sunrise(appearance: .light)
}

// MARK: - Environment Values Extension

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

// MARK: - View Extension for Easy Theming

extension View {
    /// Applies a theme to this view and all its descendants
    func themed(_ theme: Theme) -> some View {
        self.environment(\.theme, theme)
    }
    
    /// Applies a brand with automatic appearance based on system color scheme
    func branded(_ brand: Brand) -> some View {
        BrandedView(brand: brand) {
            self
        }
    }
}

// MARK: - Branded View Wrapper

/// Automatically syncs theme appearance with system color scheme
private struct BrandedView<Content: View>: View {
    let brand: Brand
    @ViewBuilder let content: () -> Content
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        content()
            .environment(\.theme, Theme(
                brand: brand,
                appearance: Appearance(from: colorScheme)
            ))
    }
}
