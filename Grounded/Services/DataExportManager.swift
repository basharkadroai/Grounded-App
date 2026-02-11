import Foundation
import SwiftData
import PDFKit

class DataExportManager {
    static let shared = DataExportManager()
    
    private init() {}
    
    // MARK: - CSV Export
    
    func exportToCSV(sessions: [GroundingSession], habits: [Habit]) -> URL? {
        var csvText = "Export Type,Date,Details\n"
        
        // Export sessions
        for session in sessions.sorted(by: { $0.startTime > $1.startTime }) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            
            let date = dateFormatter.string(from: session.startTime)
            let duration = Int(session.duration / 60)
            let preMood = session.preMoodRating.map { String($0) } ?? "N/A"
            let postMood = session.postMoodRating.map { String($0) } ?? "N/A"
            
            csvText += "Grounding Session,\(date),\"\(session.exerciseType) - \(duration)min - Mood: \(preMood)→\(postMood)\"\n"
        }
        
        // Export habits
        for habit in habits {
            let completionRate = calculateCompletionRate(for: habit)
            csvText += "Habit,\(habit.name),\"Completion Rate: \(completionRate)%\"\n"
        }
        
        // Save to file
        let fileName = "Grounded_Export_\(Date().timeIntervalSince1970).csv"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try csvText.write(to: path, atomically: true, encoding: .utf8)
            return path
        } catch {
            print("Error writing CSV: \(error)")
            return nil
        }
    }
    
    // MARK: - PDF Export
    
    func exportToPDF(sessions: [GroundingSession], habits: [Habit], userName: String?) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "Grounded App",
            kCGPDFContextAuthor: userName ?? "User",
            kCGPDFContextTitle: "Grounded Progress Report"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792) // US Letter size
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let fileName = "Grounded_Report_\(Date().timeIntervalSince1970).pdf"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try renderer.writePDF(to: path) { context in
                context.beginPage()
                
                var yPosition: CGFloat = 50
                
                // Title
                let titleAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 24),
                    .foregroundColor: UIColor.black
                ]
                let title = "Grounded Progress Report"
                title.draw(at: CGPoint(x: 50, y: yPosition), withAttributes: titleAttributes)
                yPosition += 40
                
                // Date
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                let dateText = "Generated: \(dateFormatter.string(from: Date()))"
                let dateAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.gray
                ]
                dateText.draw(at: CGPoint(x: 50, y: yPosition), withAttributes: dateAttributes)
                yPosition += 40
                
                // Summary Statistics
                let headerAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 18),
                    .foregroundColor: UIColor.black
                ]
                "Summary Statistics".draw(at: CGPoint(x: 50, y: yPosition), withAttributes: headerAttributes)
                yPosition += 30
                
                let bodyAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.black
                ]
                
                let totalSessions = sessions.count
                let avgImprovement = calculateAverageMoodImprovement(sessions: sessions)
                
                "Total Grounding Sessions: \(totalSessions)".draw(at: CGPoint(x: 50, y: yPosition), withAttributes: bodyAttributes)
                yPosition += 25
                
                if let avg = avgImprovement {
                    "Average Mood Improvement: +\(String(format: "%.1f", avg))".draw(at: CGPoint(x: 50, y: yPosition), withAttributes: bodyAttributes)
                    yPosition += 25
                }
                
                "Active Habits: \(habits.count)".draw(at: CGPoint(x: 50, y: yPosition), withAttributes: bodyAttributes)
                yPosition += 40
                
                // Recent Sessions
                "Recent Grounding Sessions".draw(at: CGPoint(x: 50, y: yPosition), withAttributes: headerAttributes)
                yPosition += 30
                
                let recentSessions = sessions.sorted(by: { $0.startTime > $1.startTime }).prefix(10)
                for session in recentSessions {
                    if yPosition > 700 {
                        context.beginPage()
                        yPosition = 50
                    }
                    
                    let sessionText = "\(dateFormatter.string(from: session.startTime)) - \(session.exerciseType)"
                    sessionText.draw(at: CGPoint(x: 50, y: yPosition), withAttributes: bodyAttributes)
                    yPosition += 20
                }
                
                yPosition += 20
                
                // Habits
                if yPosition > 650 {
                    context.beginPage()
                    yPosition = 50
                }
                
                "Habit Progress".draw(at: CGPoint(x: 50, y: yPosition), withAttributes: headerAttributes)
                yPosition += 30
                
                for habit in habits {
                    if yPosition > 700 {
                        context.beginPage()
                        yPosition = 50
                    }
                    
                    let completionRate = calculateCompletionRate(for: habit)
                    let habitText = "\(habit.icon) \(habit.name): \(completionRate)% completion"
                    habitText.draw(at: CGPoint(x: 50, y: yPosition), withAttributes: bodyAttributes)
                    yPosition += 20
                }
            }
            
            return path
        } catch {
            print("Error creating PDF: \(error)")
            return nil
        }
    }
    
    // MARK: - JSON Export
    
    func exportToJSON(sessions: [GroundingSession], habits: [Habit], user: User?) -> URL? {
        let exportData: [String: Any] = [
            "exportDate": ISO8601DateFormatter().string(from: Date()),
            "user": [
                "name": user?.name ?? "Unknown",
                "isPremium": user?.isPremium ?? false,
                "goals": user?.goals ?? []
            ],
            "sessions": sessions.map { session in
                [
                    "id": session.id.uuidString,
                    "exerciseType": session.exerciseType,
                    "startTime": ISO8601DateFormatter().string(from: session.startTime),
                    "duration": session.duration,
                    "preMoodRating": session.preMoodRating as Any,
                    "postMoodRating": session.postMoodRating as Any
                ]
            },
            "habits": habits.map { habit in
                [
                    "id": habit.id.uuidString,
                    "name": habit.name,
                    "icon": habit.icon,
                    "createdAt": ISO8601DateFormatter().string(from: habit.createdAt),
                    "completions": habit.completions.map { completion in
                        [
                            "date": ISO8601DateFormatter().string(from: completion.date),
                            "completed": completion.completed
                        ]
                    }
                ]
            }
        ]
        
        let fileName = "Grounded_Data_\(Date().timeIntervalSince1970).json"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: exportData, options: .prettyPrinted)
            try jsonData.write(to: path)
            return path
        } catch {
            print("Error creating JSON: \(error)")
            return nil
        }
    }
    
    // MARK: - Helper Methods
    
    private func calculateCompletionRate(for habit: Habit) -> Int {
        let last7Days = (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }
        let completedDays = last7Days.filter { date in
            habit.completions.contains { Calendar.current.isDate($0.date, inSameDayAs: date) && $0.completed }
        }.count
        
        return Int((Double(completedDays) / 7.0) * 100)
    }
    
    private func calculateAverageMoodImprovement(sessions: [GroundingSession]) -> Double? {
        let improvements = sessions.compactMap { session -> Double? in
            guard let pre = session.preMoodRating, let post = session.postMoodRating else { return nil }
            return Double(post - pre)
        }
        
        guard !improvements.isEmpty else { return nil }
        return improvements.reduce(0, +) / Double(improvements.count)
    }
}
