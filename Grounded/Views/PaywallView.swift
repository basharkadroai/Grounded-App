import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var superwallManager = SuperwallManager.shared
    
    let trigger: PaywallEvent
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.yellow, .orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("Upgrade to Premium")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Unlock all features and support your mental health journey")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 40)
                    
                    // Features
                    VStack(spacing: 20) {
                        FeatureRow(
                            icon: "infinity",
                            title: "Unlimited Grounding",
                            description: "Access all exercises anytime"
                        )
                        
                        FeatureRow(
                            icon: "checklist",
                            title: "Unlimited Habits",
                            description: "Track as many habits as you need"
                        )
                        
                        FeatureRow(
                            icon: "chart.line.uptrend.xyaxis",
                            title: "Advanced Insights",
                            description: "Detailed analytics and patterns"
                        )
                        
                        FeatureRow(
                            icon: "icloud.fill",
                            title: "Cloud Sync",
                            description: "Access your data on all devices"
                        )
                        
                        FeatureRow(
                            icon: "speaker.wave.3.fill",
                            title: "Audio Guides",
                            description: "Guided meditation and exercises"
                        )
                        
                        FeatureRow(
                            icon: "square.and.arrow.up",
                            title: "Data Export",
                            description: "Export your progress anytime"
                        )
                    }
                    .padding(.horizontal)
                    
                    // Pricing
                    VStack(spacing: 15) {
                        PricingCard(
                            title: "Annual",
                            price: "$39.99",
                            period: "per year",
                            savings: "Save 33%",
                            isRecommended: true
                        )
                        
                        PricingCard(
                            title: "Monthly",
                            price: "$4.99",
                            period: "per month",
                            savings: nil,
                            isRecommended: false
                        )
                    }
                    .padding(.horizontal)
                    
                    // CTA Buttons
                    VStack(spacing: 15) {
                        Button {
                            purchasePremium()
                        } label: {
                            Text("Start Free Trial")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("AccentColor"))
                                .cornerRadius(12)
                        }
                        
                        Button {
                            restorePurchases()
                        } label: {
                            Text("Restore Purchases")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Continue with Free")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Legal
                    Text("7-day free trial, then $39.99/year. Cancel anytime.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.secondary)
                    }
                }
            }
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
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color("PrimaryColor"))
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct PricingCard: View {
    let title: String
    let price: String
    let period: String
    let savings: String?
    let isRecommended: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            if isRecommended {
                Text("RECOMMENDED")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color("AccentColor"))
                    .cornerRadius(8)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.headline)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(price)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(period)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                if let savings = savings {
                    Text(savings)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("PrimaryColor"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("PrimaryColor").opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isRecommended ? Color("AccentColor") : Color.clear, lineWidth: 2)
        )
    }
}
