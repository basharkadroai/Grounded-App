import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var sessions: [GroundingSession]
    @State private var showingGroundingExercise = false
    @State private var showingPaywall = false
    @StateObject private var superwallManager = SuperwallManager.shared
    @State private var animateButton = false
    
    var todaySessions: Int {
        sessions.filter { Calendar.current.isDateInToday($0.startTime) }.count
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Premium Background
                PremiumDesign.Gradients.backgroundMesh
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 28) {
                        // Greeting
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Hello")
                                    .font(.system(.title3, design: .rounded))
                                    .foregroundStyle(.secondary)
                                Text("How are you feeling?")
                                    .font(.system(.largeTitle, design: .rounded))
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            
                            // Profile mini-avatar or status could go here
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 32))
                                .foregroundStyle(Color("PrimaryColor").gradient)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Main Action Button
                        Button {
                            if superwallManager.canAccessFeature(.unlimitedGrounding) {
                                showingGroundingExercise = true
                                superwallManager.incrementSessionCount()
                            } else {
                                showingPaywall = true
                            }
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "leaf.fill")
                                    .font(.title2)
                                    .symbolEffect(.bounce, value: animateButton)
                                Text("I need to ground")
                                    .font(.system(.headline, design: .rounded))
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.premium(color: Color("PrimaryColor")))
                        .padding(.horizontal)
                        .shadow(color: Color("PrimaryColor").opacity(0.3), radius: 15, y: 8)
                        .onAppear { animateButton.toggle() }
                        
                        // Quick Stats
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Your Progress")
                                .font(.system(.headline, design: .rounded))
                                .padding(.horizontal)
                            
                            HStack(spacing: 16) {
                                StatCard(title: "Today", value: "\(todaySessions)", icon: "checkmark.circle.fill")
                                StatCard(title: "This Week", value: "\(sessions.filter { isThisWeek($0.startTime) }.count)", icon: "calendar")
                            }
                            .padding(.horizontal)
                        }
                        
                        // Featured Resource
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Featured Resource")
                                .font(.system(.headline, design: .rounded))
                                .padding(.horizontal)
                            
                            ResourceCard(
                                title: "Understanding DPDR",
                                category: "Getting Started",
                                readTime: 5
                            )
                            .padding(.horizontal)
                        }
                        
                        Spacer(minLength: 50)
                    }
                }
            }
            .navigationTitle("Grounded")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingGroundingExercise) {
                GroundingExerciseSelectionView()
            }
            .sheet(isPresented: $showingPaywall) {
                PaywallView(trigger: .groundingLimitReached)
            }
        }
    }
    
    private func isThisWeek(_ date: Date) -> Bool {
        Calendar.current.isDate(date, equalTo: Date(), toGranularity: .weekOfYear)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color("AccentColor").gradient)
                .symbolEffect(.pulse)
            
            VStack(spacing: 2) {
                Text(value)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                
                Text(title)
                    .font(.system(.caption, design: .rounded))
                    .foregroundStyle(.secondary)
                    .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .premiumGlassCard()
    }
}

struct ResourceCard: View {
    let title: String
    let category: String
    let readTime: Int
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon/Image Placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("PrimaryColor").opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "book.closed.fill")
                    .foregroundStyle(Color("PrimaryColor"))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(category.uppercased())
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundStyle(Color("PrimaryColor"))
                    .letterSpacing(1)
                
                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text("\(readTime) min read")
                }
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .premiumGlassCard()
    }
}

