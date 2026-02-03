# SwiftUI Design System Demo

A comprehensive demonstration of design system architecture patterns in SwiftUI. This project showcases how to build scalable, multi-brand, theme-aware UI components using modern SwiftUI practices.

![iOS 17+](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5-green)

## Features

- 🎨 **Design Tokens** - Semantic, reusable styling values
- 🏢 **Multi-Brand Support** - Switch between brands at runtime
- 🌓 **Dark Mode** - Full light/dark appearance support
- ♿ **Accessibility** - Built-in accessibility traits
- 🧩 **Reusable Components** - Chip, Button, Card components
- 🔧 **Environment-Based Theming** - No prop drilling

## 🏛️ Architecture & Leadership Principles

 This system is built on the Strategy Pattern and Dependency Injection via Environment, ensuring the UI layer remains decoupled from brand-specific logic.Scalability via Protocols: Every design token (Color, Spacing, Typography) is governed by a protocol, allowing for $O(1)$ brand expansion without modifying core component logic.Performance Optimization: By leveraging the SwiftUI Environment for theme distribution, we eliminate "prop drilling" and ensure that only affected view branches re-render during theme switches.Atomic Design Methodology: Components are categorized from "Tokens" (Atoms) to "UI Components" (Molecules), ensuring a consistent source of truth across large-scale mobile teams.Safety & Predictability: Swift’s type system is utilized to make "illegal states unrepresentable," such as ensuring a component cannot be rendered without a valid semantic color mapping.

```
DesignSystemDemo/
├── Tokens/
│   ├── ColorTokens.swift      # Color definitions per brand
│   ├── SpacingTokens.swift    # Consistent spacing scale
│   ├── ShapeTokens.swift      # Corner radii, borders
│   └── TypographyTokens.swift # Font styles
├── Themes/
│   ├── Theme.swift            # Brand + Appearance → Tokens
│   └── ThemeEnvironment.swift # SwiftUI Environment setup
├── Components/
│   ├── DSChip.swift           # Selection/filter chip
│   ├── DSButton.swift         # Primary/secondary/ghost buttons
│   └── DSCard.swift           # Container card
├── Extensions/
│   └── Color+Extensions.swift # Hex colors, adaptive colors
└── Demo/
    └── DemoView.swift         # Interactive showcase
```

## Key Concepts

### Design Tokens

Design tokens are named variables storing visual design decisions:

```swift
// Instead of hardcoding...
Text("Hello")
    .foregroundColor(Color(hex: "#1A1A1A"))
    .padding(16)

// Use semantic tokens
Text("Hello")
    .foregroundColor(theme.colors.textPrimary)
    .padding(theme.spacing.md)
```

### Environment-Based Theming

Set theme once at the root, read it anywhere:

```swift
// Root view sets the theme
ContentView()
    .environment(\.theme, Theme(brand: .sunrise, appearance: .light))

// Any descendant reads it automatically
struct MyComponent: View {
    @Environment(\.theme) private var theme
    
    var body: some View {
        Text("Styled!")
            .foregroundColor(theme.colors.textPrimary)
    }
}
```

### Multi-Brand Support

Same component, different brand appearance:

```swift
// Sunrise brand (warm, orange)
DSButton("Book Now") { }
    .themed(.sunrise())

// Ocean brand (cool, blue)
DSButton("Book Now") { }
    .themed(.ocean())
```

### Dark Mode

Themes automatically handle appearance:

```swift
struct RootView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ContentView()
            .environment(\.theme, Theme(
                brand: .sunrise,
                appearance: Appearance(from: colorScheme)
            ))
    }
}
```

Or use the convenience modifier:

```swift
ContentView()
    .branded(.sunrise)  // Auto-syncs with system appearance
```

## Components

### DSChip

A chip for tags, filters, or selections:

```swift
DSChip("SwiftUI")
    .selected(isSelected)

DSChip("Featured", icon: Image(systemName: "star.fill"))
    .selected(true)
```

### DSButton

Button with multiple style variants:

```swift
DSButton("Primary") { }

DSButton("Secondary", style: .secondary) { }

DSButton("Ghost", style: .ghost) { }

DSButton("Loading") { }
    .loading(true)

DSButton("Disabled") { }
    .disabled(true)
```

### DSCard

Container for grouping content:

```swift
DSCard(style: .outlined) {
    VStack {
        Text("Card Title")
        Text("Card content goes here")
    }
}

// Styles: .flat, .outlined, .elevated
```

## Adding a New Brand

1. Add color tokens:

```swift
struct ForestLightColors: ColorTokens {
    var backgroundPrimary: Color { Color(hex: "#FFFFFF") }
    var actionPrimary: Color { Color(hex: "#2D5A27") }
    // ... other colors
}

struct ForestDarkColors: ColorTokens { ... }
```

2. Add shape and typography tokens:

```swift
struct ForestShapes: ShapeTokens { ... }
struct ForestTypography: TypographyTokens { ... }
```

3. Register in the `Brand` enum:

```swift
enum Brand {
    case sunrise, ocean, forest  // Add new case
    
    func colors(for appearance: Appearance) -> ColorTokens {
        switch (self, appearance) {
        // ... existing cases
        case (.forest, .light): return ForestLightColors()
        case (.forest, .dark): return ForestDarkColors()
        }
    }
}
```

## Adding a New Component

1. Create the component file in `Components/`:

```swift
struct DSTextField: View {
    @Environment(\.theme) private var theme
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(theme.spacing.md)
            .background(theme.colors.backgroundSecondary)
            .cornerRadius(theme.shapes.cornerRadiusMedium)
    }
}
```

2. Add previews for different brands/modes:

```swift
#Preview("Light") {
    DSTextField(placeholder: "Email", text: .constant(""))
        .themed(.sunrise())
}

#Preview("Dark") {
    DSTextField(placeholder: "Email", text: .constant(""))
        .themed(.sunrise(appearance: .dark))
}
```

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository
2. Open `DesignSystemDemo.xcodeproj` in Xcode
3. Build and run

## License

MIT License - feel free to use this as a starting point for your own design system.

## Contributing

Contributions welcome! Areas for expansion:

- [ ] Additional components (TextField, Toggle, SegmentedControl)
- [ ] Animation tokens
- [ ] Shadow/elevation tokens
- [ ] Component documentation generator
- [ ] Snapshot testing setup

---

Built with ❤️ using SwiftUI
