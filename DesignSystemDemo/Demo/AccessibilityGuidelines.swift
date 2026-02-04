//
//  AccessibilityGuidelines.swift
//
//  Created by Dmitri Lisita on 2/4/26.
//

import SwiftUI

// MARK: - Accessibility Standards

/// Guidelines for implementing accessibility across the design system
///
/// ## Core Principles
/// 1. **Perceivable**: Information must be presentable to users in ways they can perceive
/// 2. **Operable**: Interface components must be operable by all users
/// 3. **Understandable**: Information and operation must be understandable
/// 4. **Robust**: Content must be robust enough to work with assistive technologies
///
/// ## Implementation Checklist
/// - [ ] All interactive elements have accessibility labels
/// - [ ] Color contrast meets WCAG AA standards (4.5:1 for normal text, 3:1 for large text)
/// - [ ] Dynamic Type is supported and tested
/// - [ ] VoiceOver navigation is logical and complete
/// - [ ] All states (loading, disabled, selected) are announced
/// - [ ] Meaningful elements are grouped using `.accessibilityElement(children: .combine)`
/// - [ ] Non-meaningful decorative elements are hidden with `.accessibilityHidden(true)`
enum AccessibilityGuidelines {
    
    // MARK: - Color Contrast Requirements
    
    /// Minimum contrast ratios per WCAG 2.1 Level AA
    enum ContrastRatio {
        /// 4.5:1 - Required for normal text (< 18pt or < 14pt bold)
        static let normalText: Double = 4.5
        
        /// 3.0:1 - Required for large text (≥ 18pt or ≥ 14pt bold)
        static let largeText: Double = 3.0
        
        /// 3.0:1 - Required for UI components and graphical objects
        static let uiComponents: Double = 3.0
    }
    
    // MARK: - Touch Target Sizes
    
    /// Minimum touch target sizes per Apple HIG
    enum TouchTarget {
        /// 44x44 points - Minimum recommended size
        static let minimum: CGFloat = 44
        
        /// 48x48 points - Preferred size for primary actions
        static let preferred: CGFloat = 48
    }
    
    // MARK: - Dynamic Type Support
    
    /// Categories that should support Dynamic Type
    static let supportedDynamicTypeCategories: [UIContentSizeCategory] = [
        .extraSmall,
        .small,
        .medium,
        .large,
        .extraLarge,
        .extraExtraLarge,
        .extraExtraExtraLarge,
        .accessibilityMedium,
        .accessibilityLarge,
        .accessibilityExtraLarge,
        .accessibilityExtraExtraLarge,
        .accessibilityExtraExtraExtraLarge
    ]
}

// MARK: - Accessibility Helpers

extension View {
    
    /// Configures a view as an interactive button with proper accessibility
    /// - Parameters:
    ///   - label: The accessibility label describing the button
    ///   - hint: Optional hint describing the result of performing the action
    ///   - isEnabled: Whether the button is currently enabled
    func accessibleButton(label: String, hint: String? = nil, isEnabled: Bool = true) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityAddTraits(.isButton)
            .accessibilityHint(hint ?? "")
            .accessibilityRemoveTraits(isEnabled ? [] : .isButton)
            .accessibilityAddTraits(isEnabled ? [] : [.isStaticText])
    }
    
    /// Configures a view as a selectable/toggle element
    /// - Parameters:
    ///   - label: The accessibility label
    ///   - isSelected: Whether the element is currently selected
    ///   - hint: Optional hint about the action
    func accessibleToggle(label: String, isSelected: Bool, hint: String? = nil) -> some View {
        self
            .accessibilityLabel(label)
            .accessibilityAddTraits(.isButton)
            .accessibilityAddTraits(isSelected ? .isSelected : [])
            .accessibilityHint(hint ?? (isSelected ? "Double tap to deselect" : "Double tap to select"))
    }
    
    /// Ensures minimum touch target size for accessibility
    /// - Parameter size: Minimum size (default: 44 points)
    func minimumTouchTarget(size: CGFloat = AccessibilityGuidelines.TouchTarget.minimum) -> some View {
        self
            .frame(minWidth: size, minHeight: size)
    }
    
    /// Groups child elements for better VoiceOver navigation
    /// - Parameter combineChildren: Whether to combine children into single element
    func accessibleGroup(combineChildren: Bool = true) -> some View {
        self
            .accessibilityElement(children: combineChildren ? .combine : .contain)
    }
}

// MARK: - Color Contrast Utilities

extension Color {
    
    /// Calculates the relative luminance of a color
    /// Based on WCAG 2.1 definition: https://www.w3.org/TR/WCAG21/#dfn-relative-luminance
    var luminance: Double {
        // Note: This is a simplified implementation
        // For production, use UIColor/NSColor with proper color space conversion
        return 0.5 // Placeholder - real implementation would extract RGB and calculate
    }
    
    /// Calculates contrast ratio between two colors
    /// - Parameter other: The color to compare against
    /// - Returns: Contrast ratio (1:1 to 21:1)
    func contrastRatio(with other: Color) -> Double {
        let l1 = max(self.luminance, other.luminance)
        let l2 = min(self.luminance, other.luminance)
        return (l1 + 0.05) / (l2 + 0.05)
    }
    
    /// Checks if this color has sufficient contrast with another
    /// - Parameters:
    ///   - background: The background color
    ///   - ratio: Required contrast ratio (default: 4.5 for normal text)
    /// - Returns: Whether the contrast is sufficient
    func meetsContrastRequirement(against background: Color, ratio: Double = AccessibilityGuidelines.ContrastRatio.normalText) -> Bool {
        return contrastRatio(with: background) >= ratio
    }
}

// MARK: - Semantic Accessibility Tokens

/// Semantic accessibility values that can be used across the design system
protocol AccessibilityTokens {
    /// Minimum touch target size for interactive elements
    var minimumTouchTarget: CGFloat { get }
    
    /// Preferred spacing for better readability with larger text
    var accessibleSpacing: CGFloat { get }
    
    /// Whether to reduce motion for animations
    var reduceMotion: Bool { get }
}

/// Standard accessibility tokens
struct StandardAccessibilityTokens: AccessibilityTokens {
    let minimumTouchTarget: CGFloat = 44
    let accessibleSpacing: CGFloat = 16
    
    @Environment(\.accessibilityReduceMotion) private var _reduceMotion
    
    var reduceMotion: Bool {
        _reduceMotion
    }
}

// MARK: - Testing Utilities

#if DEBUG
/// Utilities for testing accessibility in previews and UI tests
enum AccessibilityTestUtilities {
    
    /// Creates a test environment with specific accessibility settings
    /// - Parameters:
    ///   - sizeCategory: Dynamic Type size category
    /// - Note: Some accessibility settings like `accessibilityReduceMotion`, 
    ///   `differentiateWithoutColor`, and `increaseContrast` are read-only 
    ///   and reflect system settings, so they cannot be overridden in tests.
    static func testEnvironment(
        sizeCategory: ContentSizeCategory = .large
    ) -> some ViewModifier {
        TestAccessibilityEnvironment(
            sizeCategory: sizeCategory
        )
    }
    
    private struct TestAccessibilityEnvironment: ViewModifier {
        let sizeCategory: ContentSizeCategory
        
        func body(content: Content) -> some View {
            content
                .environment(\.sizeCategory, sizeCategory)
        }
    }
}

extension View {
    /// Applies accessibility test environment for previews
    /// - Parameters:
    ///   - sizeCategory: Dynamic Type size category to test with
    /// - Note: Some accessibility settings like `accessibilityReduceMotion`, 
    ///   `differentiateWithoutColor`, and `increaseContrast` are read-only 
    ///   and reflect system settings, so they cannot be overridden in tests.
    func testAccessibility(
        sizeCategory: ContentSizeCategory = .large
    ) -> some View {
        self
            .environment(\.sizeCategory, sizeCategory)
    }
}
#endif
