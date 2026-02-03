//
//  ShapeTokens.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

// MARK: - Protocol

protocol ShapeTokens {
    var cornerRadiusSmall: CGFloat { get }
    var cornerRadiusMedium: CGFloat { get }
    var cornerRadiusLarge: CGFloat { get }
    var cornerRadiusPill: CGFloat { get }
    
    var borderWidthThin: CGFloat { get }
    var borderWidthMedium: CGFloat { get }
    var borderWidthThick: CGFloat { get }
}

// MARK: - Sunrise Shapes (Modern, subtle rounding)

struct SunriseShapes: ShapeTokens {
    var cornerRadiusSmall: CGFloat { 4 }
    var cornerRadiusMedium: CGFloat { 8 }
    var cornerRadiusLarge: CGFloat { 12 }
    var cornerRadiusPill: CGFloat { 9999 }  // Large enough to create pill
    
    var borderWidthThin: CGFloat { 1 }
    var borderWidthMedium: CGFloat { 1.5 }
    var borderWidthThick: CGFloat { 2 }
}

// MARK: - Ocean Shapes (Softer, more rounded)

struct OceanShapes: ShapeTokens {
    var cornerRadiusSmall: CGFloat { 8 }
    var cornerRadiusMedium: CGFloat { 16 }
    var cornerRadiusLarge: CGFloat { 24 }
    var cornerRadiusPill: CGFloat { 9999 }
    
    var borderWidthThin: CGFloat { 1 }
    var borderWidthMedium: CGFloat { 2 }
    var borderWidthThick: CGFloat { 3 }
}
