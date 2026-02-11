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
            ZStack {
                PremiumDesign.Gradients.backgroundMesh
                    .ignoresSafeArea()
                
                ScrollView {
                    if habits.isEmpty {
                        emptyStateView
                    } else {
                        VStack(spacing: 16) {
                            ForEach(habits) { habit in
                                HabitCard(habit: habit)
                            }
                        }
                        .padding()
                    }
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
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(Color("AccentColor"))
                            .symbolEffect(.bounce, value: showingAddHabit)
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView()
                    .presentationDetents([.medium, .large])
                    .presentationCornerRadius(24)
            }
            .sheet(isPresented: $showingPaywall) {
                PaywallView(trigger: .habitLimitReached)
            }
        }
    }
    
    var emptyStateView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color("AccentColor").opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "checklist")
                    .font(.system(size: 50))
                    .foregroundStyle(Color("AccentColor"))
            }
            .padding(.bottom, 8)
            
            VStack(spacing: 12) {
                Text("No Habits Yet")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                
                Text("Start building healthy routines to manage DPDR")
                    .font(.system(.body, design: .rounded))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Button {
                showingAddHabit = true
            } label: {
                Text("Add Your First Habit")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor").gradient)
                    .cornerRadius(16)
                    .shadow(color: Color("AccentColor").opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding(.horizontal, 40)
            .padding(.top, 16)
            
            Spacer()
        }
        .frame(minHeight: 400)
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
        HStack(spacing: 16) {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    toggleCompletion()
                }
            } label: {
                ZStack {
                    Circle()
                        .strokeBorder(isCompletedToday ? Color("AccentColor") : .secondary.opacity(0.3), lineWidth: 2)
                        .background(Circle().fill(isCompletedToday ? Color("AccentColor") : Color.clear))
                        .frame(width: 32, height: 32)
                    
                    if isCompletedToday {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.medium)
                    .strikethrough(isCompletedToday, color: .secondary)
                    .foregroundStyle(isCompletedToday ? .secondary : .primary)
                
                if currentStreak > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.caption2)
                            .foregroundStyle(.orange)
                        Text("\(currentStreak) day streak")
                            .font(.system(.caption, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
            
            Text(habit.icon)
                .font(.title2)
                .padding(8)
                .background(Color(.systemBackground).opacity(0.5))
                .clipShape(Circle())
        }
        .padding(16)
        .premiumGlassCard(cornerRadius: 20)
    }
    
    private func toggleCompletion() {
        var completions = habit.completions
        
        if let index = completions.firstIndex(where: { Calendar.current.isDateInToday($0.date) }) {
            completions.remove(at: index) // Remove completion if toggled off
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
    
    let icons = ["💧", "🏃", "🧘", "📝", "💊", "🌙", "🥗", "📱", "🌳", "📖", "🎨", "🎵"]
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
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Icon Selection
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Choose Icon")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(icons, id: \.self) { icon in
                                        Button {
                                            selectedIcon = icon
                                        } label: {
                                            Text(icon)
                                                .font(.system(size: 24))
                                                .frame(width: 50, height: 50)
                                                .background(
                                                    ZStack {
                                                        if selectedIcon == icon {
                                                            Color("AccentColor").opacity(0.2)
                                                        } else {
                                                            Color(.systemGray6)
                                                        }
                                                    }
                                                )
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(selectedIcon == icon ? Color("AccentColor") : Color.clear, lineWidth: 2)
                                                )
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Name Input
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Habit Name")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                            
                            TextField("e.g., Deep Breathing", text: $habitName)
                                .font(.system(.body, design: .rounded))
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                        
                        // Templates
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Quick Templates")
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundStyle(.secondary)
                                .padding(.leading)
                            
                            FlowLayout(spacing: 10) {
                                ForEach(templates, id: \.self) { template in
                                    Button {
                                        habitName = template
                                        // Auto-select icon logic could go here
                                    } label: {
                                        Text(template)
                                            .font(.system(.callout, design: .rounded))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color(.systemBackground))
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color(.systemGray4), lineWidth: 1)
                                            )
                                    }
                                    .foregroundStyle(.primary)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 24)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(.primary)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { addHabit() }
                        .fontWeight(.bold)
                        .foregroundStyle(habitName.isEmpty ? .secondary : Color("AccentColor"))
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

// Helper for flow layout (simple implementation)
struct FlowLayout: Layout {
    var spacing: CGFloat
    
    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        if rows.isEmpty { return .zero }
        
        var height: CGFloat = 0
        for row in rows {
            let rowHeight = row.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
            height += rowHeight + spacing
        }
        return CGSize(width: proposal.width ?? 0, height: height - spacing)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        
        var y = bounds.minY
        for row in rows {
            let rowHeight = row.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
            var x = bounds.minX
            
            for subview in row {
                subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
                x += subview.sizeThatFits(.unspecified).width + spacing
            }
            y += rowHeight + spacing
        }
    }
    
    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [[LayoutSubview]] {
        var rows: [[LayoutSubview]] = []
        var currentRow: [LayoutSubview] = []
        var currentWidth: CGFloat = 0
        let maxWidth = proposal.width ?? 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentWidth + size.width + spacing > maxWidth {
                rows.append(currentRow)
                currentRow = [subview]
                currentWidth = size.width
            } else {
                currentRow.append(subview)
                currentWidth += size.width + spacing
            }
        }
        if !currentRow.isEmpty { rows.append(currentRow) }
        return rows
    }
}

