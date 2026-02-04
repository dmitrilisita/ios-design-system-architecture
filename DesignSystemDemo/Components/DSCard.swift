//
//  DSCard.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

/// A card container component for grouping related content
///
/// Usage:
/// ```swift
/// DSCard {
///     Text("Card Content")
/// }
///
/// DSCard(style: .elevated) {
///     VStack { ... }
/// }
/// ```
struct DSCard<Content: View>: View {
    
    // MARK: - Style Variants
    
    enum Style {
        case flat
        case outlined
        case elevated
    }
    
    // MARK: - Properties
    
    let style: Style
    let content: Content
    
    @Environment(\.theme) private var theme
    
    // MARK: - Initializer
    
    init(
        style: Style = .outlined,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.content = content()
    }
    
    // MARK: - Body
    
    var body: some View {
        content
            .padding(theme.spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.colors.backgroundPrimary)
            .clipShape(RoundedRectangle(cornerRadius: theme.shapes.cornerRadiusLarge))
            .overlay(
                RoundedRectangle(cornerRadius: theme.shapes.cornerRadiusLarge)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .shadow(color: shadowColor, radius: shadowRadius, y: shadowY)
            .accessibilityElement(children: .contain)
    }
    
    // MARK: - Computed Styles
    
    private var borderColor: Color {
        switch style {
        case .flat, .elevated:
            return .clear
        case .outlined:
            return theme.colors.border
        }
    }
    
    private var borderWidth: CGFloat {
        style == .outlined ? theme.shapes.borderWidthThin : 0
    }
    
    private var shadowColor: Color {
        style == .elevated ? .black.opacity(0.1) : .clear
    }
    
    private var shadowRadius: CGFloat {
        style == .elevated ? 8 : 0
    }
    
    private var shadowY: CGFloat {
        style == .elevated ? 4 : 0
    }
}

// MARK: - Previews

#Preview("Card Styles") {
    ScrollView {
        VStack(spacing: 24) {
            DSCard(style: .flat) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Flat Card")
                        .font(.headline)
                    Text("No border, no shadow")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            DSCard(style: .outlined) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Outlined Card")
                        .font(.headline)
                    Text("Border, no shadow")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            DSCard(style: .elevated) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Elevated Card")
                        .font(.headline)
                    Text("Shadow, no border")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
    }
    .background(Color.gray.opacity(0.1))
    .themed(.sunrise())
}

#Preview("Card with Components") {
    DSCard {
        VStack(alignment: .leading, spacing: 16) {
            Text("Premium Plan")
                .font(.title2.bold())
            
            Text("Get access to all features including priority support and advanced analytics.")
                .font(.body)
                .foregroundStyle(.secondary)
            
            HStack {
                DSChip("Popular")
                    .selected(true)
                DSChip("Best Value")
            }
            
            DSButton("Subscribe Now") { }
        }
    }
    .padding()
    .themed(.ocean())
}
