import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var sessions: [GroundingSession]
    @State private var showingGroundingExercise = false
    @State private var showingPaywall = false
    @StateObject private var superwallManager = SuperwallManager.shared
    
    var todaySessions: Int {
        sessions.filter { Calendar.current.isDateInToday($0.startTime) }.count
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Greeting
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hello")
                                .font(.title2)
                                .foregroundStyle(.secondary)
                            Text("How are you feeling?")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Grounding Button
                    Button {
                        if superwallManager.canAccessFeature(.unlimitedGrounding) {
                            showingGroundingExercise = true
                            superwallManager.incrementSessionCount()
                        } else {
                            showingPaywall = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "leaf.fill")
                                .font(.title2)
                            Text("I need to ground")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            LinearGradient(
                                colors: [Color("PrimaryColor"), Color("PrimaryColor").opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                        .shadow(color: Color("PrimaryColor").opacity(0.3), radius: 10, y: 5)
                    }
                    .padding(.horizontal)
                    
                    // Quick Stats
                    HStack(spacing: 15) {
                        StatCard(title: "Today", value: "\(todaySessions)", icon: "checkmark.circle.fill")
                        StatCard(title: "This Week", value: "\(sessions.filter { isThisWeek($0.startTime) }.count)", icon: "calendar")
                    }
                    .padding(.horizontal)
                    
                    // Featured Resource
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Featured Resource")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ResourceCard(
                            title: "Understanding DPDR",
                            category: "Getting Started",
                            readTime: 5
                        )
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Grounded")
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
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(Color("AccentColor"))
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct ResourceCard: View {
    let title: String
    let category: String
    let readTime: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(category)
                    .font(.caption)
                    .foregroundStyle(Color("PrimaryColor"))
                    .fontWeight(.semibold)
                
                Text(title)
                    .font(.headline)
                
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                    Text("\(readTime) min read")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
