//
//  ColorTokens.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

// MARK: - Protocol

protocol ColorTokens {
    var backgroundPrimary: Color { get }
    var backgroundSecondary: Color { get }
    var backgroundSelected: Color { get }
    
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textOnAction: Color { get }
    
    var actionPrimary: Color { get }
    var actionSecondary: Color { get }
    
    var border: Color { get }
    var borderSelected: Color { get }
}

// MARK: - Sunrise Brand (Light)

struct SunriseLightColors: ColorTokens {
    var backgroundPrimary: Color { Color(hex: "#FFFFFF") }
    var backgroundSecondary: Color { Color(hex: "#F5F5F5") }
    var backgroundSelected: Color { Color(hex: "#FFF3E0") }
    
    var textPrimary: Color { Color(hex: "#1A1A1A") }
    var textSecondary: Color { Color(hex: "#666666") }
    var textOnAction: Color { Color(hex: "#FFFFFF") }
    
    var actionPrimary: Color { Color(hex: "#FF6B35") }
    var actionSecondary: Color { Color(hex: "#FF8C5A") }
    
    var border: Color { Color(hex: "#E0E0E0") }
    var borderSelected: Color { Color(hex: "#FF6B35") }
}

// MARK: - Sunrise Brand (Dark)

struct SunriseDarkColors: ColorTokens {
    var backgroundPrimary: Color { Color(hex: "#1A1A1A") }
    var backgroundSecondary: Color { Color(hex: "#2D2D2D") }
    var backgroundSelected: Color { Color(hex: "#3D2814") }
    
    var textPrimary: Color { Color(hex: "#F5F5F5") }
    var textSecondary: Color { Color(hex: "#AAAAAA") }
    var textOnAction: Color { Color(hex: "#FFFFFF") }
    
    var actionPrimary: Color { Color(hex: "#FF8C5A") }
    var actionSecondary: Color { Color(hex: "#FF6B35") }
    
    var border: Color { Color(hex: "#424242") }
    var borderSelected: Color { Color(hex: "#FF8C5A") }
}

// MARK: - Ocean Brand (Light)

struct OceanLightColors: ColorTokens {
    var backgroundPrimary: Color { Color(hex: "#FFFFFF") }
    var backgroundSecondary: Color { Color(hex: "#F0F7FA") }
    var backgroundSelected: Color { Color(hex: "#E0F2F1") }
    
    var textPrimary: Color { Color(hex: "#1A2B3C") }
    var textSecondary: Color { Color(hex: "#5A6B7C") }
    var textOnAction: Color { Color(hex: "#FFFFFF") }
    
    var actionPrimary: Color { Color(hex: "#0077B6") }
    var actionSecondary: Color { Color(hex: "#00A8E8") }
    
    var border: Color { Color(hex: "#CAE9F5") }
    var borderSelected: Color { Color(hex: "#0077B6") }
}

// MARK: - Ocean Brand (Dark)

struct OceanDarkColors: ColorTokens {
    var backgroundPrimary: Color { Color(hex: "#0D1B2A") }
    var backgroundSecondary: Color { Color(hex: "#1B2838") }
    var backgroundSelected: Color { Color(hex: "#1B3A4B") }
    
    var textPrimary: Color { Color(hex: "#E0E0E0") }
    var textSecondary: Color { Color(hex: "#8899AA") }
    var textOnAction: Color { Color(hex: "#FFFFFF") }
    
    var actionPrimary: Color { Color(hex: "#00A8E8") }
    var actionSecondary: Color { Color(hex: "#0077B6") }
    
    var border: Color { Color(hex: "#2D4A5E") }
    var borderSelected: Color { Color(hex: "#00A8E8") }
}
