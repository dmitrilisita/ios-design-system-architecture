//
//  SpacingTokens.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

// MARK: - Protocol

protocol SpacingTokens {
    var xxs: CGFloat { get }  // 2
    var xs: CGFloat { get }   // 4
    var sm: CGFloat { get }   // 8
    var md: CGFloat { get }   // 16
    var lg: CGFloat { get }   // 24
    var xl: CGFloat { get }   // 32
    var xxl: CGFloat { get }  // 48
}

// MARK: - Standard Spacing (Shared across brands)

struct StandardSpacing: SpacingTokens {
    var xxs: CGFloat { 2 }
    var xs: CGFloat { 4 }
    var sm: CGFloat { 8 }
    var md: CGFloat { 16 }
    var lg: CGFloat { 24 }
    var xl: CGFloat { 32 }
    var xxl: CGFloat { 48 }
}

// MARK: - Compact Spacing (For dense UIs)

struct CompactSpacing: SpacingTokens {
    var xxs: CGFloat { 1 }
    var xs: CGFloat { 2 }
    var sm: CGFloat { 4 }
    var md: CGFloat { 8 }
    var lg: CGFloat { 16 }
    var xl: CGFloat { 24 }
    var xxl: CGFloat { 32 }
}
