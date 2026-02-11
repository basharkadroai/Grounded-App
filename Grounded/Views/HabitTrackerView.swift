import SwiftUI
import SwiftData

struct HabitTrackerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    @State private var showingAddHabit = false
    @State private var showingPaywall = false
    @StateObject private var superwallManager = SuperwallManager.shared
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if habits.isEmpty {
                    emptyStateView
                } else {
                    VStack(spacing: 15) {
                        ForEach(habits) { habit in
                            HabitCard(habit: habit)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        if superwallManager.canAccessFeature(.unlimitedHabits) || habits.count < 3 {
                            showingAddHabit = true
                        } else {
                            showingPaywall = true
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView()
            }
            .sheet(isPresented: $showingPaywall) {
                PaywallView(trigger: .habitLimitReached)
            }
        }
    }
    
    var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checklist")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            Text("No Habits Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Start building healthy routines to manage DPDR")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                showingAddHabit = true
            } label: {
                Text("Add Your First Habit")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(12)
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
    }
}

struct HabitCard: View {
    @Bindable var habit: Habit
    
    var isCompletedToday: Bool {
        habit.completions.contains { completion in
            Calendar.current.isDateInToday(completion.date) && completion.completed
        }
    }
    
    var currentStreak: Int {
        var streak = 0
        var date = Date()
        
        while true {
            if habit.completions.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: date) && $0.completed }) {
                streak += 1
                date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
            } else {
                break
            }
        }
        
        return streak
    }
    
    var body: some View {
        HStack {
            Button {
                toggleCompletion()
            } label: {
                Image(systemName: isCompletedToday ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isCompletedToday ? Color("AccentColor") : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(habit.name)
                    .font(.headline)
                
                if currentStreak > 0 {
                    HStack(spacing: 5) {
                        Image(systemName: "flame.fill")
                            .font(.caption)
                            .foregroundStyle(.orange)
                        Text("\(currentStreak) day streak")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
            
            Text(habit.icon)
                .font(.title2)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private func toggleCompletion() {
        var completions = habit.completions
        
        if let index = completions.firstIndex(where: { Calendar.current.isDateInToday($0.date) }) {
            completions[index].completed.toggle()
        } else {
            completions.append(HabitCompletion(date: Date(), completed: true))
        }
        
        habit.completions = completions
    }
}

struct AddHabitView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var habitName = ""
    @State private var selectedIcon = "💧"
    
    let icons = ["💧", "🏃", "🧘", "📝", "💊", "🌙", "🥗", "📱"]
    let templates = [
        "Drink Water",
        "Exercise",
        "Meditate",
        "Journal",
        "Take Medication",
        "Sleep 8+ Hours"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Name") {
                    TextField("e.g., Drink Water", text: $habitName)
                }
                
                Section("Icon") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 15) {
                        ForEach(icons, id: \.self) { icon in
                            Button {
                                selectedIcon = icon
                            } label: {
                                Text(icon)
                                    .font(.largeTitle)
                                    .frame(width: 60, height: 60)
                                    .background(selectedIcon == icon ? Color("AccentColor").opacity(0.2) : Color(.systemGray6))
                                    .cornerRadius(12)
                            }
                        }
                    }
                }
                
                Section("Templates") {
                    ForEach(templates, id: \.self) { template in
                        Button {
                            habitName = template
                        } label: {
                            Text(template)
                                .foregroundStyle(.primary)
                        }
                    }
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addHabit()
                    }
                    .disabled(habitName.isEmpty)
                }
            }
        }
    }
    
    private func addHabit() {
        let habit = Habit(name: habitName, icon: selectedIcon)
        modelContext.insert(habit)
        dismiss()
    }
}
