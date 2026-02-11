import SwiftUI

// PASTE THIS INTO iSwift.dev TO SEE THE ACTUAL iOS DESIGN

struct HomeScreenPreview: View {
    @State private var showingExercise = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Greeting Section
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
                    .padding(.top, 20)
                    
                    // Grounding Button - Beautiful gradient
                    Button {
                        showingExercise = true
                    } label: {
                        HStack(spacing: 15) {
                            Image(systemName: "leaf.fill")
                                .font(.title2)
                                .symbolEffect(.pulse)
                            
                            Text("I need to ground")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 22)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.545, green: 0.663, blue: 0.533),
                                    Color(red: 0.475, green: 0.593, blue: 0.463)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(16)
                        .shadow(color: Color(red: 0.545, green: 0.663, blue: 0.533).opacity(0.4), radius: 12, y: 6)
                    }
                    .padding(.horizontal)
                    
                    // Stats Cards
                    HStack(spacing: 15) {
                        StatCard(
                            icon: "checkmark.circle.fill",
                            value: "3",
                            label: "Today",
                            color: Color(red: 0.910, green: 0.647, blue: 0.596)
                        )
                        
                        StatCard(
                            icon: "calendar",
                            value: "12",
                            label: "This Week",
                            color: Color(red: 0.545, green: 0.663, blue: 0.533)
                        )
                    }
                    .padding(.horizontal)
                    
                    // Featured Resource
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Featured Resource")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ResourceCard(
                            category: "Getting Started",
                            title: "Understanding DPDR",
                            readTime: 5,
                            icon: "book.fill"
                        )
                        .padding(.horizontal)
                    }
                    
                    // Recent Activity
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activity")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 10) {
                            ActivityRow(
                                icon: "figure.mind.and.body",
                                title: "5-4-3-2-1 Technique",
                                subtitle: "Mood improved by 2 points",
                                time: "2 hours ago",
                                color: Color(red: 0.545, green: 0.663, blue: 0.533)
                            )
                            
                            ActivityRow(
                                icon: "checkmark.circle.fill",
                                title: "Completed: Drink Water",
                                subtitle: "5 day streak! 🔥",
                                time: "4 hours ago",
                                color: Color(red: 0.910, green: 0.647, blue: 0.596)
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(red: 0.980, green: 0.980, blue: 0.973))
            .navigationTitle("Grounded")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showingExercise) {
            ExercisePreview()
        }
    }
}

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            
            Text(value)
                .font(.system(size: 32, weight: .bold, design: .rounded))
            
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        )
    }
}

struct ResourceCard: View {
    let category: String
    let title: String
    let readTime: Int
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title)
                .foregroundStyle(Color(red: 0.545, green: 0.663, blue: 0.533))
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(Color(red: 0.545, green: 0.663, blue: 0.533).opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(category)
                    .font(.caption)
                    .foregroundStyle(Color(red: 0.545, green: 0.663, blue: 0.533))
                    .fontWeight(.semibold)
                
                Text(title)
                    .font(.headline)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.caption2)
                    Text("\(readTime) min read")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        )
    }
}

struct ActivityRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let time: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(color.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text(time)
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
        )
    }
}

struct ExercisePreview: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.980, green: 0.980, blue: 0.973),
                        Color(red: 0.545, green: 0.663, blue: 0.533).opacity(0.1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Icon
                    Image(systemName: "hand.raised.fingers.spread.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(Color(red: 0.545, green: 0.663, blue: 0.533))
                        .symbolEffect(.pulse)
                    
                    // Count
                    Text("5")
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.910, green: 0.647, blue: 0.596))
                    
                    // Sense
                    Text("See")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    // Prompt
                    Text("Name 5 things you can see around you")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Button
                    Button {
                        dismiss()
                    } label: {
                        Text("Next")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.910, green: 0.647, blue: 0.596))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Exit") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeScreenPreview()
}
