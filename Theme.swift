import SwiftUI

// MARK: - Color Extension (hex support)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}

// MARK: - App Color Palette
extension Color {
    static let appBG     = Color(hex: "#070707")
    static let appText   = Color(hex: "#EDEAE3")
    static let appMuted  = Color(hex: "#706C65")
    static let appFaint  = Color(hex: "#343230")
    static let appAccent = Color(hex: "#C8A352")
    static let appBorder = Color.white.opacity(0.06)
    static let appSurface = Color(hex: "#111010")
    static let appSurface2 = Color(hex: "#161514")
}

// MARK: - Typography
extension Font {
    // Using system fonts that approximate Satoshi character
    static let appHero = Font.system(size: 52, weight: .black, design: .default)
    static let appTitle = Font.system(size: 28, weight: .bold, design: .default)
    static let appSection = Font.system(size: 22, weight: .semibold, design: .default)
    static let appBody = Font.system(size: 16, weight: .regular, design: .default)
    static let appMeta = Font.system(size: 12, weight: .medium, design: .default)
    static let appLabel = Font.system(size: 11, weight: .medium, design: .default)
}

// MARK: - Text Modifiers
struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appLabel)
            .kerning(1.5)
            .textCase(.uppercase)
            .foregroundColor(.appMuted)
    }
}

struct AccentLabelStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.appLabel)
            .kerning(1.5)
            .textCase(.uppercase)
            .foregroundColor(.appAccent)
    }
}

extension View {
    func labelStyle() -> some View { modifier(LabelStyle()) }
    func accentLabelStyle() -> some View { modifier(AccentLabelStyle()) }
}
