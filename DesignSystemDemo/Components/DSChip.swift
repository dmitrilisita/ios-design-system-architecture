//
//  DSChip.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

/// A chip component for displaying tags, filters, or selections
///
/// Usage:
/// ```swift
/// DSChip("Filter")
///     .selected(true)
///
/// DSChip("With Icon", icon: Image(systemName: "star"))
/// ```
struct DSChip: View {
    
    // MARK: - Properties
    
    let label: String
    let icon: Image?
    
    private var isSelected: Bool = false
    
    @Environment(\.theme) private var theme
    
    // MARK: - Initializer
    
    init(_ label: String, icon: Image? = nil) {
        self.label = label
        self.icon = icon
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: theme.spacing.xs) {
            if let icon {
                icon
                    .font(theme.typography.labelSmall)
                    .accessibilityHidden(true) // Icon is decorative
            }
            
            Text(label)
                .font(theme.typography.labelMedium)
        }
        .padding(.horizontal, theme.spacing.md)
        .padding(.vertical, theme.spacing.sm)
        .foregroundStyle(foregroundColor)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: theme.shapes.cornerRadiusPill))
        .overlay(
            RoundedRectangle(cornerRadius: theme.shapes.cornerRadiusPill)
                .stroke(borderColor, lineWidth: theme.shapes.borderWidthThin)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint(accessibilityHint)
        .accessibilityAddTraits(accessibilityTraits)
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
    
    // MARK: - Accessibility
    
    private var accessibilityLabel: String {
        label
    }
    
    private var accessibilityHint: String {
        if isSelected {
            return "Selected. Double tap to deselect"
        } else {
            return "Not selected. Double tap to select"
        }
    }
    
    private var accessibilityTraits: AccessibilityTraits {
        var traits: AccessibilityTraits = [.isButton]
        
        if isSelected {
            traits.insert(.isSelected)
        }
        
        return traits
    }
    
    // MARK: - Computed Colors
    
    private var foregroundColor: Color {
        isSelected ? theme.colors.actionPrimary : theme.colors.textPrimary
    }
    
    private var backgroundColor: Color {
        isSelected ? theme.colors.backgroundSelected : theme.colors.backgroundPrimary
    }
    
    private var borderColor: Color {
        isSelected ? theme.colors.borderSelected : theme.colors.border
    }
    
    // MARK: - Modifiers
    
    func selected(_ isSelected: Bool) -> Self {
        var copy = self
        copy.isSelected = isSelected
        return copy
    }
}

// MARK: - Previews

#Preview("Chip - Default") {
    DSChip("Filter")
        .themed(.sunrise())
        .padding()
}

#Preview("Chip - Selected") {
    DSChip("Selected", icon: Image(systemName: "checkmark"))
        .selected(true)
        .themed(.sunrise())
        .padding()
}

#Preview("Chip - Ocean Brand") {
    VStack(spacing: 16) {
        DSChip("Ocean Default")
        DSChip("Ocean Selected", icon: Image(systemName: "star.fill"))
            .selected(true)
    }
    .themed(.ocean())
    .padding()
}

#Preview("Chip - Dark Mode") {
    VStack(spacing: 16) {
        DSChip("Sunrise Dark")
            .selected(true)
            .themed(.sunrise(appearance: .dark))
        
        DSChip("Ocean Dark")
            .selected(true)
            .themed(.ocean(appearance: .dark))
    }
    .padding()
    .background(Color.black)
}
