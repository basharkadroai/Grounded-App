import SwiftUI

struct PremiumDesign {
    // MARK: - Gradients
    struct Gradients {
        static let primary = LinearGradient(
            colors: [Color("PrimaryColor"), Color("PrimaryColor").opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let accent = LinearGradient(
            colors: [Color("AccentColor"), Color("AccentColor").opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let backgroundMesh = LinearGradient(
            colors: [
                Color("BackgroundColor"),
                Color("PrimaryColor").opacity(0.05),
                Color("AccentColor").opacity(0.05),
                Color("BackgroundColor")
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Glassmorphism
    struct GlassModifier: ViewModifier {
        var cornerRadius: CGFloat = 20
        var opacity: Double = 0.5
        
        func body(content: Content) -> some View {
            content
                .background(.ultraThinMaterial)
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        }
    }
}

extension View {
    func premiumGlassCard(cornerRadius: CGFloat = 20, opacity: Double = 0.5) -> some View {
        self.modifier(PremiumDesign.GlassModifier(cornerRadius: cornerRadius, opacity: opacity))
    }
    
    func premiumShadow() -> some View {
        self.shadow(color: .black.opacity(0.08), radius: 15, x: 0, y: 8)
    }
}

struct PremiumButtonStyle: ButtonStyle {
    var color: Color = Color("PrimaryColor")
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .foregroundStyle(.white)
            .padding(.vertical, 18)
            .padding(.horizontal, 24)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(color.gradient)
                    
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.black.opacity(0.1))
                    }
                }
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PremiumButtonStyle {
    static var premium: PremiumButtonStyle { PremiumButtonStyle() }
    static func premium(color: Color) -> PremiumButtonStyle { PremiumButtonStyle(color: color) }
}
