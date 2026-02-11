import Foundation
import SwiftData

enum ExerciseType: String, Codable {
    case fiveFourThreeTwoOne = "5-4-3-2-1"
    case bodyScan = "Body Scan"
    case breathWork = "Breath Work"
    case sensoryGrounding = "Sensory Grounding"
}

@Model
class GroundingSession {
    var id: UUID
    var exerciseType: String
    var startTime: Date
    var endTime: Date
    var duration: TimeInterval
    var preMoodRating: Int?
    var postMoodRating: Int?
    var notes: String?
    
    init(id: UUID = UUID(), exerciseType: ExerciseType, startTime: Date = Date(), endTime: Date = Date(), duration: TimeInterval = 0, preMoodRating: Int? = nil, postMoodRating: Int? = nil, notes: String? = nil) {
        self.id = id
        self.exerciseType = exerciseType.rawValue
        self.startTime = startTime
        self.endTime = endTime
        self.duration = duration
        self.preMoodRating = preMoodRating
        self.postMoodRating = postMoodRating
        self.notes = notes
    }
}
