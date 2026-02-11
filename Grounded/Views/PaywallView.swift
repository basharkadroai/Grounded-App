import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var superwallManager = SuperwallManager.shared
    
    let trigger: PaywallEvent
    
    var body: some View {
        NavigationStack {
            ZStack {
                PremiumDesign.Gradients.backgroundMesh
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Header
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color("AccentColor").opacity(0.1))
                                    .frame(width: 100, height: 100)
                                    .blur(radius: 10)
                                
                                Image(systemName: "crown.fill")
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color("AccentColor").gradient)
                                    .shadow(color: Color("AccentColor").opacity(0.5), radius: 10, y: 5)
                            }
                            
                            VStack(spacing: 8) {
                                Text("Unlock Full Peace")
                                    .font(.system(.largeTitle, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                
                                Text("Get unlimited access to grounding tools, advanced insights, and personalized habits.")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Features
                        VStack(spacing: 16) {
                            FeatureRow(icon: "infinity", title: "Unlimited Grounding", description: "Access all exercises anytime")
                            FeatureRow(icon: "checklist", title: "Unlimited Habits", description: "Track your entire routine")
                            FeatureRow(icon: "chart.xyaxis.line", title: "Advanced Insights", description: "Discover your triggers & patterns")
                            FeatureRow(icon: "icloud.fill", title: "Cloud Sync", description: "Seamlessly sync across devices")
                        }
                        .padding(.horizontal)
                        
                        // Pricing
                        VStack(spacing: 16) {
                            PricingCard(
                                title: "Annual",
                                price: "$39.99",
                                period: "year",
                                savings: "Save 33%",
                                isRecommended: true,
                                action: { purchasePremium() }
                            )
                            
                            PricingCard(
                                title: "Monthly",
                                price: "$4.99",
                                period: "month",
                                savings: nil,
                                isRecommended: false,
                                action: { purchasePremium() }
                            )
                        }
                        .padding(.horizontal)
                        
                        // Footer
                        VStack(spacing: 16) {
                            Button {
                                restorePurchases()
                            } label: {
                                Text("Restore Purchases")
                                    .font(.system(.subheadline, design: .rounded))
                                    .foregroundStyle(.secondary)
                                    .underline()
                            }
                            
                            Text("7-day free trial, then $39.99/year. Cancel anytime.")
                                .font(.system(.caption, design: .rounded))
                                .foregroundStyle(.tertiary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(.secondary.opacity(0.8))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func purchasePremium() {
        // Demo implementation
        superwallManager.purchasePremium()
        dismiss()
    }
    
    private func restorePurchases() {
        superwallManager.restorePurchases()
        if superwallManager.isPremium {
            dismiss()
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color("PrimaryColor").opacity(0.1))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(Color("PrimaryColor"))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "checkmark")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color("PrimaryColor"))
        }
        .padding(12)
        .premiumGlassCard(cornerRadius: 16)
    }
}

struct PricingCard: View {
    let title: String
    let price: String
    let period: String
    let savings: String?
    let isRecommended: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if isRecommended {
                        Text("BEST VALUE")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color("AccentColor"))
                            .cornerRadius(8)
                            .padding(.bottom, 4)
                    }
                    
                    Text(title)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundStyle(.secondary)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(price)
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        
                        Text("/ \(period)")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                if let savings = savings {
                    Text(savings)
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("PrimaryColor"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(12)
                }
                
                Image(systemName: isRecommended ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isRecommended ? Color("AccentColor") : .secondary.opacity(0.3))
            }
            .padding(20)
            .background(
                ZStack {
                    if isRecommended {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("AccentColor"), lineWidth: 2)
                    }
                }
            )
            .premiumGlassCard(cornerRadius: 20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

