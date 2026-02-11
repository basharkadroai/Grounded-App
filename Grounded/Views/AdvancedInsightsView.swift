import SwiftUI
import SwiftData
import Charts

struct AdvancedInsightsView: View {
    @Query private var sessions: [GroundingSession]
    @Query private var habits: [Habit]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Mood Trend Chart
                VStack(alignment: .leading, spacing: 15) {
                    Text("Mood Trends (30 Days)")
                        .font(.headline)
                    
                    if #available(iOS 16.0, *) {
                        moodTrendChart
                            .frame(height: 200)
                    } else {
                        Text("Charts require iOS 16+")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Exercise Frequency
                VStack(alignment: .leading, spacing: 15) {
                    Text("Exercise Frequency")
                        .font(.headline)
                    
                    if #available(iOS 16.0, *) {
                        exerciseFrequencyChart
                            .frame(height: 200)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Correlations
                VStack(alignment: .leading, spacing: 15) {
                    Text("Insights & Patterns")
                        .font(.headline)
                    
                    ForEach(generateInsights(), id: \.self) { insight in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "lightbulb.fill")
                                .foregroundStyle(Color("AccentColor"))
                            
                            Text(insight)
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color(.systemGray6).opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Best Times
                VStack(alignment: .leading, spacing: 15) {
                    Text("Your Best Times")
                        .font(.headline)
                    
                    bestTimesView
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Advanced Insights")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @available(iOS 16.0, *)
    var moodTrendChart: some View {
        let last30Days = getLast30Days()
        let moodData = last30Days.map { date -> (date: Date, avgMood: Double) in
            let daySessions = sessions.filter { Calendar.current.isDate($0.startTime, inSameDayAs: date) }
            let avgPost = daySessions.compactMap { $0.postMoodRating }.reduce(0, +)
            let count = daySessions.compactMap { $0.postMoodRating }.count
            return (date: date, avgMood: count > 0 ? Double(avgPost) / Double(count) : 0)
        }.filter { $0.avgMood > 0 }
        
        return Chart(moodData, id: \.date) { item in
            LineMark(
                x: .value("Date", item.date, unit: .day),
                y: .value("Mood", item.avgMood)
            )
            .foregroundStyle(Color("PrimaryColor"))
            .interpolationMethod(.catmullRom)
            
            AreaMark(
                x: .value("Date", item.date, unit: .day),
                y: .value("Mood", item.avgMood)
            )
            .foregroundStyle(Color("PrimaryColor").opacity(0.2))
            .interpolationMethod(.catmullRom)
        }
        .chartYScale(domain: 1...5)
    }
    
    @available(iOS 16.0, *)
    var exerciseFrequencyChart: some View {
        let exerciseCounts = Dictionary(grouping: sessions, by: { $0.exerciseType })
            .mapValues { $0.count }
            .sorted { $0.value > $1.value }
        
        return Chart(exerciseCounts, id: \.key) { item in
            BarMark(
                x: .value("Count", item.value),
                y: .value("Exercise", item.key)
            )
            .foregroundStyle(Color("AccentColor"))
        }
    }
    
    var bestTimesView: some View {
        VStack(spacing: 12) {
            let bestTime = findBestTimeOfDay()
            let bestDay = findBestDayOfWeek()
            
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundStyle(Color("PrimaryColor"))
                Text("Best time of day:")
                Spacer()
                Text(bestTime)
                    .fontWeight(.semibold)
            }
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(Color("PrimaryColor"))
                Text("Most active day:")
                Spacer()
                Text(bestDay)
                    .fontWeight(.semibold)
            }
        }
    }
    
    private func generateInsights() -> [String] {
        var insights: [String] = []
        
        // Mood improvement insight
        if let avgImprovement = calculateAverageMoodImprovement(), avgImprovement > 0 {
            insights.append("Your mood improves by an average of \(String(format: "%.1f", avgImprovement)) points after grounding exercises.")
        }
        
        // Consistency insight
        let last7Days = getLast7Days()
        let activeDays = last7Days.filter { date in
            sessions.contains { Calendar.current.isDate($0.startTime, inSameDayAs: date) }
        }.count
        
        if activeDays >= 5 {
            insights.append("Great consistency! You've practiced grounding on \(activeDays) of the last 7 days.")
        } else if activeDays >= 3 {
            insights.append("You're building a good routine with \(activeDays) days of practice this week.")
        }
        
        // Habit correlation
        let habitCompletionDays = habits.flatMap { habit in
            habit.completions.filter { $0.completed }.map { $0.date }
        }
        
        let sessionDays = sessions.map { Calendar.current.startOfDay(for: $0.startTime) }
        let overlap = Set(habitCompletionDays.map { Calendar.current.startOfDay(for: $0) })
            .intersection(Set(sessionDays))
        
        if !habitCompletionDays.isEmpty && !sessionDays.isEmpty {
            let correlation = Double(overlap.count) / Double(min(habitCompletionDays.count, sessionDays.count))
            if correlation > 0.5 {
                insights.append("You're \(Int(correlation * 100))% more likely to complete habits on days you practice grounding.")
            }
        }
        
        // Favorite exercise
        let exerciseCounts = Dictionary(grouping: sessions, by: { $0.exerciseType })
        if let favorite = exerciseCounts.max(by: { $0.value.count < $1.value.count }) {
            insights.append("Your most-used exercise is \(favorite.key), which you've completed \(favorite.value.count) times.")
        }
        
        return insights
    }
    
    private func findBestTimeOfDay() -> String {
        let hourCounts = Dictionary(grouping: sessions, by: { Calendar.current.component(.hour, from: $0.startTime) })
        guard let bestHour = hourCounts.max(by: { $0.value.count < $1.value.count })?.key else {
            return "Not enough data"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        let date = Calendar.current.date(bySettingHour: bestHour, minute: 0, second: 0, of: Date()) ?? Date()
        return formatter.string(from: date)
    }
    
    private func findBestDayOfWeek() -> String {
        let dayCounts = Dictionary(grouping: sessions, by: { Calendar.current.component(.weekday, from: $0.startTime) })
        guard let bestDay = dayCounts.max(by: { $0.value.count < $1.value.count })?.key else {
            return "Not enough data"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let date = Calendar.current.date(bySetting: .weekday, value: bestDay, of: Date()) ?? Date()
        return formatter.string(from: date)
    }
    
    private func calculateAverageMoodImprovement() -> Double? {
        let improvements = sessions.compactMap { session -> Double? in
            guard let pre = session.preMoodRating, let post = session.postMoodRating else { return nil }
            return Double(post - pre)
        }
        
        guard !improvements.isEmpty else { return nil }
        return improvements.reduce(0, +) / Double(improvements.count)
    }
    
    private func getLast7Days() -> [Date] {
        (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }
    }
    
    private func getLast30Days() -> [Date] {
        (0..<30).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }.reversed()
    }
}
