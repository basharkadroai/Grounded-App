import Foundation
import SwiftData

enum Weekday: String, Codable, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

enum HabitFrequency: Codable {
    case daily
    case specificDays([Weekday])
    case timesPerWeek(Int)
}

struct HabitCompletion: Codable {
    var date: Date
    var completed: Bool
}

@Model
class Habit {
    var id: UUID
    var name: String
    var icon: String
    var frequencyData: Data?
    var reminderTime: Date?
    var createdAt: Date
    var completionsData: Data?
    
    init(id: UUID = UUID(), name: String, icon: String, frequency: HabitFrequency = .daily, reminderTime: Date? = nil, createdAt: Date = Date(), completions: [HabitCompletion] = []) {
        self.id = id
        self.name = name
        self.icon = icon
        self.frequencyData = try? JSONEncoder().encode(frequency)
        self.reminderTime = reminderTime
        self.createdAt = createdAt
        self.completionsData = try? JSONEncoder().encode(completions)
    }
    
    var frequency: HabitFrequency {
        get {
            guard let data = frequencyData,
                  let frequency = try? JSONDecoder().decode(HabitFrequency.self, from: data) else {
                return .daily
            }
            return frequency
        }
        set {
            frequencyData = try? JSONEncoder().encode(newValue)
        }
    }
    
    var completions: [HabitCompletion] {
        get {
            guard let data = completionsData,
                  let completions = try? JSONDecoder().decode([HabitCompletion].self, from: data) else {
                return []
            }
            return completions
        }
        set {
            completionsData = try? JSONEncoder().encode(newValue)
        }
    }
}
