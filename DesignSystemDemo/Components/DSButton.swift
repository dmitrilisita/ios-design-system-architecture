//
//  DSButton.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

/// A button component with multiple style variants
///
/// Usage:
/// ```swift
/// DSButton("Primary Action") { print("Tapped") }
///
/// DSButton("Secondary", style: .secondary) { }
///
/// DSButton("With Icon", icon: Image(systemName: "arrow.right")) { }
/// ```
struct DSButton: View {
    
    // MARK: - Style Variants
    
    enum Style {
        case primary
        case secondary
        case ghost
    }
    
    // MARK: - Properties
    
    let label: String
    let icon: Image?
    let style: Style
    let action: () -> Void
    
    private var isLoading: Bool = false
    private var isDisabled: Bool = false
    
    @Environment(\.theme) private var theme
    
    // MARK: - Initializer
    
    init(
        _ label: String,
        icon: Image? = nil,
        style: Style = .primary,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.icon = icon
        self.style = style
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: theme.spacing.sm) {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else {
                    Text(label)
                        .font(theme.typography.labelLarge)
                    
                    if let icon {
                        icon
                            .font(theme.typography.labelMedium)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.md)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: theme.shapes.cornerRadiusMedium))
            .overlay(
                RoundedRectangle(cornerRadius: theme.shapes.cornerRadiusMedium)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
        }
        .disabled(isDisabled || isLoading)
        .opacity(isDisabled ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
    
    // MARK: - Computed Styles
    
    private var foregroundColor: Color {
        switch style {
        case .primary:
            return theme.colors.textOnAction
        case .secondary:
            return theme.colors.actionPrimary
        case .ghost:
            return theme.colors.actionPrimary
        }
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return theme.colors.actionPrimary
        case .secondary:
            return theme.colors.backgroundPrimary
        case .ghost:
            return .clear
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .primary:
            return .clear
        case .secondary:
            return theme.colors.actionPrimary
        case .ghost:
            return .clear
        }
    }
    
    private var borderWidth: CGFloat {
        style == .secondary ? theme.shapes.borderWidthMedium : 0
    }
    
    // MARK: - Modifiers
    
    func loading(_ isLoading: Bool) -> Self {
        var copy = self
        copy.isLoading = isLoading
        return copy
    }
    
    func disabled(_ isDisabled: Bool) -> Self {
        var copy = self
        copy.isDisabled = isDisabled
        return copy
    }
}

// MARK: - Previews

#Preview("Button Styles") {
    VStack(spacing: 16) {
        DSButton("Primary Button") { }
        
        DSButton("Secondary Button", style: .secondary) { }
        
        DSButton("Ghost Button", style: .ghost) { }
        
        DSButton("With Icon", icon: Image(systemName: "arrow.right")) { }
        
        DSButton("Loading")  { }
            .loading(true)
        
        DSButton("Disabled") { }
            .disabled(true)
    }
    .padding()
    .themed(.sunrise())
}

#Preview("Ocean Brand") {
    VStack(spacing: 16) {
        DSButton("Ocean Primary") { }
        DSButton("Ocean Secondary", style: .secondary) { }
    }
    .padding()
    .themed(.ocean())
}

#Preview("Dark Mode") {
    VStack(spacing: 16) {
        DSButton("Dark Primary") { }
        DSButton("Dark Secondary", style: .secondary) { }
    }
    .padding()
    .background(Color.black)
    .themed(.sunrise(appearance: .dark))
}
