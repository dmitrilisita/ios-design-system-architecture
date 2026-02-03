//
//  DemoView.swift
//
//  Created by Dmitri Lisita on 2/3/26.
//


import SwiftUI

/// Interactive demo showcasing the design system
struct DemoView: View {
    
    @State private var selectedBrand: Brand = .sunrise
    @State private var selectedAppearance: Appearance = .light
    @State private var selectedChips: Set<String> = ["SwiftUI"]
    
    private var theme: Theme {
        Theme(brand: selectedBrand, appearance: selectedAppearance)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    themeSelector
                    chipSection
                    buttonSection
                    cardSection
                }
                .padding()
            }
            .background(theme.colors.backgroundSecondary)
            .navigationTitle("Design System")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(Appearance.allCases) { appearance in
                            Button {
                                selectedAppearance = appearance
                            } label: {
                                HStack {
                                    Text(appearance.rawValue)
                                    if appearance == selectedAppearance {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        Image(systemName: selectedAppearance == .dark ? "moon.fill" : "sun.max.fill")
                    }
                }
            }
        }
        .themed(theme)
        .preferredColorScheme(selectedAppearance.colorScheme)
    }
    
    // MARK: - Theme Selector
    
    private var themeSelector: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Brand")
                .font(theme.typography.headingSmall)
                .foregroundStyle(theme.colors.textPrimary)
            
            HStack(spacing: 12) {
                ForEach(Brand.allCases) { brand in
                    DSButton(
                        brand.displayName,
                        style: brand == selectedBrand ? .primary : .secondary
                    ) {
                        withAnimation {
                            selectedBrand = brand
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .themed(theme)
    }
    
    // MARK: - Chip Section
    
    private var chipSection: some View {
        DSCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Chips")
                    .font(theme.typography.headingMedium)
                    .foregroundStyle(theme.colors.textPrimary)
                
                Text("Tap to toggle selection")
                    .font(theme.typography.bodySmall)
                    .foregroundStyle(theme.colors.textSecondary)
                
                FlowLayout(spacing: 8) {
                    ForEach(chipOptions, id: \.self) { option in
                        DSChip(option, icon: chipIcon(for: option))
                            .selected(selectedChips.contains(option))
                            .onTapGesture {
                                withAnimation {
                                    if selectedChips.contains(option) {
                                        selectedChips.remove(option)
                                    } else {
                                        selectedChips.insert(option)
                                    }
                                }
                            }
                    }
                }
            }
        }
        .themed(theme)
    }
    
    private let chipOptions = ["SwiftUI", "UIKit", "Combine", "Swift", "Xcode", "iOS"]
    
    private func chipIcon(for option: String) -> Image? {
        switch option {
        case "SwiftUI": return Image(systemName: "swift")
        case "Xcode": return Image(systemName: "hammer.fill")
        case "iOS": return Image(systemName: "iphone")
        default: return nil
        }
    }
    
    // MARK: - Button Section
    
    private var buttonSection: some View {
        DSCard {
            VStack(alignment: .leading, spacing: 16) {
                Text("Buttons")
                    .font(theme.typography.headingMedium)
                    .foregroundStyle(theme.colors.textPrimary)
                
                DSButton("Primary Action", icon: Image(systemName: "arrow.right")) { }
                
                DSButton("Secondary Action", style: .secondary) { }
                
                DSButton("Ghost Action", style: .ghost) { }
                
                HStack(spacing: 12) {
                    DSButton("Loading") { }
                        .loading(true)
                    
                    DSButton("Disabled") { }
                        .disabled(true)
                }
            }
        }
        .themed(theme)
    }
    
    // MARK: - Card Section
    
    private var cardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cards")
                .font(theme.typography.headingMedium)
                .foregroundStyle(theme.colors.textPrimary)
                .padding(.horizontal, 4)
            
            DSCard(style: .flat) {
                cardContent(title: "Flat Style", subtitle: "Background only, no border")
            }
            
            DSCard(style: .outlined) {
                cardContent(title: "Outlined Style", subtitle: "Border with no shadow")
            }
            
            DSCard(style: .elevated) {
                cardContent(title: "Elevated Style", subtitle: "Shadow with no border")
            }
        }
        .themed(theme)
    }
    
    private func cardContent(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(theme.typography.headingSmall)
                .foregroundStyle(theme.colors.textPrimary)
            
            Text(subtitle)
                .font(theme.typography.bodySmall)
                .foregroundStyle(theme.colors.textSecondary)
        }
    }
}

// MARK: - Flow Layout (for wrapping chips)

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: ProposedViewSize(result.sizes[index])
            )
        }
    }
    
    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint], sizes: [CGSize]) {
        let maxWidth = proposal.width ?? .infinity
        
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            sizes.append(size)
            
            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            
            positions.append(CGPoint(x: currentX, y: currentY))
            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        
        let totalHeight = currentY + rowHeight
        let totalWidth = positions.enumerated().map { sizes[$0.offset].width + $0.element.x }.max() ?? 0
        
        return (CGSize(width: totalWidth, height: totalHeight), positions, sizes)
    }
}

// MARK: - Preview

#Preview {
    DemoView()
}
