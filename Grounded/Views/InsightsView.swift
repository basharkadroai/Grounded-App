import SwiftUI
import SwiftData
import Charts

struct InsightsView: View {
    @Query private var sessions: [GroundingSession]
    @Query private var habits: [Habit]
    
    var body: some View {
        NavigationStack {
            ZStack {
                PremiumDesign.Gradients.backgroundMesh
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 28) {
                        // Premium Feature Banner
                        NavigationLink(destination: AdvancedInsightsView()) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(.white.opacity(0.2))
                                        .frame(width: 44, height: 44)
                                    
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow.gradient)
                                        .font(.title3)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Advanced Insights")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundStyle(.primary)
                                    Text("View trends, patterns, and correlations")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(16)
                            .background(
                                PremiumDesign.Gradients.primary.opacity(0.1)
                            )
                            .premiumGlassCard(cornerRadius: 18)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                        
                        // Grounding Sessions Chart
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Grounding Sessions")
                                .font(.system(.headline, design: .rounded))
                            
                            if sessions.isEmpty {
                                emptyChartView(message: "No sessions yet")
                            } else {
                                sessionsChart
                            }
                        }
                        .padding(20)
                        .premiumGlassCard(cornerRadius: 20)
                        .padding(.horizontal)
                        
                        // Mood Improvement
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Mood Improvement")
                                .font(.system(.headline, design: .rounded))
                            
                            if let avgImprovement = averageMoodImprovement {
                                HStack(spacing: 20) {
                                    ZStack {
                                        Circle()
                                            .fill(Color("AccentColor").opacity(0.1))
                                            .frame(width: 60, height: 60)
                                        
                                        Image(systemName: "arrow.up.circle.fill")
                                            .font(.system(size: 32))
                                            .foregroundStyle(Color("AccentColor").gradient)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(String(format: "+%.1f", avgImprovement))
                                            .font(.system(.title, design: .rounded))
                                            .fontWeight(.bold)
                                        Text("Average improvement per session")
                                            .font(.system(.caption, design: .rounded))
                                            .foregroundStyle(.secondary)
                                            .fontWeight(.medium)
                                    }
                                }
                            } else {
                                emptyChartView(message: "Complete sessions to see insights")
                            }
                        }
                        .padding(20)
                        .premiumGlassCard(cornerRadius: 20)
                        .padding(.horizontal)
                        
                        // Habit Completion Rate
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Habit Completion")
                                .font(.system(.headline, design: .rounded))
                            
                            if habits.isEmpty {
                                emptyChartView(message: "No habits tracked yet")
                            } else {
                                habitCompletionView
                            }
                        }
                        .padding(20)
                        .premiumGlassCard(cornerRadius: 20)
                        .padding(.horizontal)
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
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
            .foregroundStyle(Color("PrimaryColor").gradient)
            .cornerRadius(4)
        }
        .frame(height: 180)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
                    .font(.system(size: 10, design: .rounded))
            }
        }
    }
    
    var habitCompletionView: some View {
        VStack(spacing: 16) {
            ForEach(habits) { habit in
                VStack(spacing: 8) {
                    HStack {
                        Text(habit.name)
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Text("\(completionRate(for: habit))%")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(Color("AccentColor"))
                    }
                    
                    ProgressView(value: Double(completionRate(for: habit)), total: 100)
                        .tint(Color("AccentColor").gradient)
                        .scaleEffect(x: 1, y: 1.5, anchor: .center)
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
        VStack(spacing: 12) {
            Image(systemName: "chart.bar.xaxis")
                .font(.system(size: 40))
                .foregroundStyle(.secondary.opacity(0.3))
            Text(message)
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(frame: .infinity)
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

