import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var userName = ""
    @State private var selectedGoals: Set<String> = []
    
    let goals = ["Manage episodes", "Build habits", "Learn more", "Track progress"]
    
    var body: some View {
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

struct WelcomeScreen: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "leaf.fill")
                .font(.system(size: 80))
                .foregroundStyle(Color("PrimaryColor"))
            
            Text("Welcome to Grounded")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Your companion for managing DPDR")
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("Swipe to continue")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, 40)
        }
        .padding()
    }
}

struct WhatIsDPDRScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("What is DPDR?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder characterized by:")
                    .font(.body)
                
                VStack(alignment: .leading, spacing: 15) {
                    InfoRow(icon: "person.fill.questionmark", text: "Feeling disconnected from yourself")
                    InfoRow(icon: "eye.slash.fill", text: "Perceiving the world as foggy or dreamlike")
                    InfoRow(icon: "brain.head.profile", text: "Awareness that these perceptions are distorted")
                }
                
                Text("You're not alone")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                Text("Many people experience DPDR, and grounding techniques can help manage symptoms.")
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct HowGroundingWorksScreen: View {
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "tree.fill")
                .font(.system(size: 80))
                .foregroundStyle(Color("PrimaryColor"))
            
            Text("How Grounding Works")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Grounding techniques engage your five senses to help you reconnect with the present moment.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Like roots anchoring a tree, these exercises help you feel stable and present.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct PersonalizationScreen: View {
    @Binding var userName: String
    @Binding var selectedGoals: Set<String>
    let goals: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                Text("Personalize Your Experience")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("What name would you like us to use?")
                        .font(.headline)
                    
                    TextField("Name (optional)", text: $userName)
                        .textFieldStyle(.roundedBorder)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("What are your goals?")
                        .font(.headline)
                    
                    ForEach(goals, id: \.self) { goal in
                        Button {
                            if selectedGoals.contains(goal) {
                                selectedGoals.remove(goal)
                            } else {
                                selectedGoals.insert(goal)
                            }
                        } label: {
                            HStack {
                                Image(systemName: selectedGoals.contains(goal) ? "checkmark.square.fill" : "square")
                                    .foregroundStyle(Color("AccentColor"))
                                Text(goal)
                                    .foregroundStyle(.primary)
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct CompletionScreen: View {
    @Binding var hasCompletedOnboarding: Bool
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(Color("AccentColor"))
            
            Text("You're All Set!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Let's begin your journey to feeling more grounded.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                hasCompletedOnboarding = true
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color("PrimaryColor"))
                .frame(width: 30)
            
            Text(text)
                .font(.body)
        }
    }
}
