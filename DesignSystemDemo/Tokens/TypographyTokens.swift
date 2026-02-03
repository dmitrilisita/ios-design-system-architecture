//
//  TypographyTokens.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

// MARK: - Protocol

protocol TypographyTokens {
    var displayLarge: Font { get }
    var displayMedium: Font { get }
    
    var headingLarge: Font { get }
    var headingMedium: Font { get }
    var headingSmall: Font { get }
    
    var bodyLarge: Font { get }
    var bodyMedium: Font { get }
    var bodySmall: Font { get }
    
    var labelLarge: Font { get }
    var labelMedium: Font { get }
    var labelSmall: Font { get }
    
    var caption: Font { get }
}

// MARK: - Sunrise Typography (Bold, modern)

struct SunriseTypography: TypographyTokens {
    var displayLarge: Font { .system(size: 48, weight: .bold, design: .rounded) }
    var displayMedium: Font { .system(size: 36, weight: .bold, design: .rounded) }
    
    var headingLarge: Font { .system(size: 28, weight: .bold) }
    var headingMedium: Font { .system(size: 22, weight: .semibold) }
    var headingSmall: Font { .system(size: 18, weight: .semibold) }
    
    var bodyLarge: Font { .system(size: 18, weight: .regular) }
    var bodyMedium: Font { .system(size: 16, weight: .regular) }
    var bodySmall: Font { .system(size: 14, weight: .regular) }
    
    var labelLarge: Font { .system(size: 16, weight: .medium) }
    var labelMedium: Font { .system(size: 14, weight: .medium) }
    var labelSmall: Font { .system(size: 12, weight: .medium) }
    
    var caption: Font { .system(size: 12, weight: .regular) }
}

// MARK: - Ocean Typography (Clean, professional)

struct OceanTypography: TypographyTokens {
    var displayLarge: Font { .system(size: 44, weight: .light) }
    var displayMedium: Font { .system(size: 32, weight: .light) }
    
    var headingLarge: Font { .system(size: 26, weight: .semibold) }
    var headingMedium: Font { .system(size: 20, weight: .semibold) }
    var headingSmall: Font { .system(size: 17, weight: .semibold) }
    
    var bodyLarge: Font { .system(size: 17, weight: .regular) }
    var bodyMedium: Font { .system(size: 15, weight: .regular) }
    var bodySmall: Font { .system(size: 13, weight: .regular) }
    
    var labelLarge: Font { .system(size: 15, weight: .medium) }
    var labelMedium: Font { .system(size: 13, weight: .medium) }
    var labelSmall: Font { .system(size: 11, weight: .medium) }
    
    var caption: Font { .system(size: 11, weight: .regular) }
}
