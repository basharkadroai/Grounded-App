import SwiftUI
import SwiftData
import Charts

struct InsightsView: View {
    @Query private var sessions: [GroundingSession]
    @Query private var habits: [Habit]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Premium Feature Banner
                    NavigationLink(destination: AdvancedInsightsView()) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow)
                                    Text("Advanced Insights")
                                        .font(.headline)
                                }
                                Text("View trends, patterns, and correlations")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color("PrimaryColor").opacity(0.1), Color("AccentColor").opacity(0.1)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    // Grounding Sessions Chart
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Grounding Sessions")
                            .font(.headline)
                        
                        if sessions.isEmpty {
                            emptyChartView(message: "No sessions yet")
                        } else {
                            sessionsChart
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Mood Improvement
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Mood Improvement")
                            .font(.headline)
                        
                        if let avgImprovement = averageMoodImprovement {
                            HStack {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(Color("AccentColor"))
                                
                                VStack(alignment: .leading) {
                                    Text(String(format: "+%.1f", avgImprovement))
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text("Average improvement")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        } else {
                            emptyChartView(message: "Complete sessions to see insights")
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Habit Completion Rate
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Habit Completion")
                            .font(.headline)
                        
                        if habits.isEmpty {
                            emptyChartView(message: "No habits tracked yet")
                        } else {
                            habitCompletionView
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Insights")
        }
    }
    
    var sessionsChart: some View {
        let last7Days = getLast7Days()
        let sessionCounts = last7Days.map { date in
            (date: date, count: sessions.filter { Calendar.current.isDate($0.startTime, inSameDayAs: date) }.count)
        }
        
        return Chart(sessionCounts, id: \.date) { item in
            BarMark(
                x: .value("Day", item.date, unit: .day),
                y: .value("Sessions", item.count)
            )
            .foregroundStyle(Color("PrimaryColor"))
        }
        .frame(height: 200)
    }
    
    var habitCompletionView: some View {
        VStack(spacing: 10) {
            ForEach(habits) { habit in
                HStack {
                    Text(habit.name)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("\(completionRate(for: habit))%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("AccentColor"))
                }
            }
        }
    }
    
    var averageMoodImprovement: Double? {
        let improvements = sessions.compactMap { session -> Double? in
            guard let pre = session.preMoodRating, let post = session.postMoodRating else { return nil }
            return Double(post - pre)
        }
        
        guard !improvements.isEmpty else { return nil }
        return improvements.reduce(0, +) / Double(improvements.count)
    }
    
    func emptyChartView(message: String) -> some View {
        VStack {
            Image(systemName: "chart.bar.xaxis")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(height: 150)
    }
    
    func getLast7Days() -> [Date] {
        (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }.reversed()
    }
    
    func completionRate(for habit: Habit) -> Int {
        let last7Days = getLast7Days()
        let completedDays = last7Days.filter { date in
            habit.completions.contains { Calendar.current.isDate($0.date, inSameDayAs: date) && $0.completed }
        }.count
        
        return Int((Double(completedDays) / 7.0) * 100)
    }
}
