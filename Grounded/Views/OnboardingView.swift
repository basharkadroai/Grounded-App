import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var userName = ""
    @State private var selectedGoals: Set<String> = []
    
    let goals = ["Manage episodes", "Build habits", "Learn more", "Track progress"]
    
    var body: some View {
        ZStack {
            PremiumDesign.Gradients.backgroundMesh
                .ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                WelcomeScreen()
                    .tag(0)
                
                WhatIsDPDRScreen()
                    .tag(1)
                
                HowGroundingWorksScreen()
                    .tag(2)
                
                PersonalizationScreen(userName: $userName, selectedGoals: $selectedGoals, goals: goals)
                    .tag(3)
                
                CompletionScreen(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct WelcomeScreen: View {
    @State private var animateIcon = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "leaf.fill")
                .font(.system(size: 100))
                .foregroundStyle(Color("PrimaryColor").gradient)
                .symbolEffect(.bounce, value: animateIcon)
                .onAppear { animateIcon.toggle() }
            
            VStack(spacing: 12) {
                Text("Welcome to Grounded")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Your companion for managing DPDR")
                    .font(.system(.title3, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Text("Swipe to continue")
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
                .fontWeight(.bold)
                .padding(.bottom, 40)
        }
    }
}

struct WhatIsDPDRScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                Text("What is DPDR?")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                
                Text("Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder characterized by:")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.secondary)
                
                VStack(alignment: .leading, spacing: 20) {
                    InfoRow(icon: "person.fill.questionmark", text: "Feeling disconnected from yourself")
                    InfoRow(icon: "eye.slash.fill", text: "Perceiving the world as foggy or dreamlike")
                    InfoRow(icon: "brain.head.profile", text: "Awareness that these perceptions are distorted")
                }
                .padding(24)
                .premiumGlassCard()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("You're not alone")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                    
                    Text("Many people experience DPDR, and grounding techniques can help manage symptoms.")
                        .font(.system(.body, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(32)
        }
    }
}

struct HowGroundingWorksScreen: View {
    @State private var animateIcon = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Image(systemName: "tree.fill")
                .font(.system(size: 100))
                .foregroundStyle(Color("PrimaryColor").gradient)
                .symbolEffect(.bounce, value: animateIcon)
                .onAppear { animateIcon.toggle() }
            
            VStack(spacing: 20) {
                Text("How Grounding Works")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Grounding techniques engage your five senses to help you reconnect with the present moment.")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Like roots anchoring a tree, these exercises help you feel stable and present.")
                    .font(.system(.body, design: .rounded).italic())
                    .foregroundStyle(Color("PrimaryColor"))
                    .multilineTextAlignment(.center)
                    .padding(24)
                    .premiumGlassCard()
                    .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

struct PersonalizationScreen: View {
    @Binding var userName: String
    @Binding var selectedGoals: Set<String>
    let goals: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                Text("Personalize")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("What name would you like to use?")
                        .font(.system(.headline, design: .rounded))
                    
                    TextField("Name (optional)", text: $userName)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white.opacity(0.2), lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("What are your goals?")
                        .font(.system(.headline, design: .rounded))
                    
                    ForEach(goals, id: \.self) { goal in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                if selectedGoals.contains(goal) {
                                    selectedGoals.remove(goal)
                                } else {
                                    selectedGoals.insert(goal)
                                }
                            }
                        } label: {
                            HStack {
                                Image(systemName: selectedGoals.contains(goal) ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selectedGoals.contains(goal) ? Color("AccentColor") : .secondary)
                                    .font(.title3)
                                Text(goal)
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.medium)
                                    .foregroundStyle(selectedGoals.contains(goal) ? .primary : .secondary)
                                Spacer()
                            }
                            .padding()
                            .background(selectedGoals.contains(goal) ? Color("AccentColor").opacity(0.1) : .ultraThinMaterial)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(selectedGoals.contains(goal) ? Color("AccentColor").opacity(0.3) : .white.opacity(0.1), lineWidth: 1)
                            )
                        }
                    }
                }
                
                Spacer()
            }
            .padding(32)
        }
    }
}

struct CompletionScreen: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var animateIcon = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(Color("AccentColor").gradient)
                .symbolEffect(.bounce, value: animateIcon)
                .onAppear { animateIcon.toggle() }
            
            VStack(spacing: 16) {
                Text("You're All Set!")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                
                Text("Let's begin your journey to feeling more grounded.")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Button {
                withAnimation {
                    hasCompletedOnboarding = true
                }
            } label: {
                Text("Get Started")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.premium(color: Color("AccentColor")))
            .padding(.horizontal, 32)
            
            Spacer()
        }
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color("PrimaryColor").gradient)
                .frame(width: 32)
            
            Text(text)
                .font(.system(.body, design: .rounded))
                .fontWeight(.medium)
        }
    }
}

