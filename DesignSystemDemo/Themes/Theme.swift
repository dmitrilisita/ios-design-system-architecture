//
//  Theme.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

// MARK: - Brand Definition

enum Brand: String, CaseIterable, Identifiable {
    case sunrise = "Sunrise"
    case ocean = "Ocean"
    
    var id: String { rawValue }
    
    var displayName: String { rawValue }
    
    var shapes: ShapeTokens {
        switch self {
        case .sunrise: return SunriseShapes()
        case .ocean: return OceanShapes()
        }
    }
    
    var typography: TypographyTokens {
        switch self {
        case .sunrise: return SunriseTypography()
        case .ocean: return OceanTypography()
        }
    }
    
    var spacing: SpacingTokens {
        StandardSpacing()  // Shared across brands
    }
    
    func colors(for appearance: Appearance) -> ColorTokens {
        switch (self, appearance) {
        case (.sunrise, .light): return SunriseLightColors()
        case (.sunrise, .dark): return SunriseDarkColors()
        case (.ocean, .light): return OceanLightColors()
        case (.ocean, .dark): return OceanDarkColors()
        }
    }
}

// MARK: - Appearance

enum Appearance: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    
    var id: String { rawValue }
    
    init(from colorScheme: ColorScheme) {
        self = colorScheme == .dark ? .dark : .light
    }
    
    var colorScheme: ColorScheme {
        self == .dark ? .dark : .light
    }
}

// MARK: - Theme

struct Theme {
    let brand: Brand
    let appearance: Appearance
    
    var colors: ColorTokens { brand.colors(for: appearance) }
    var shapes: ShapeTokens { brand.shapes }
    var spacing: SpacingTokens { brand.spacing }
    var typography: TypographyTokens { brand.typography }
    
    // Convenience initializers
    static func sunrise(appearance: Appearance = .light) -> Theme {
        Theme(brand: .sunrise, appearance: appearance)
    }
    
    static func ocean(appearance: Appearance = .light) -> Theme {
        Theme(brand: .ocean, appearance: appearance)
    }
}
