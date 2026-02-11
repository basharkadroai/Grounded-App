import Foundation

enum ResourceCategory: String, Codable {
    case understandingDPDR = "Understanding DPDR"
    case copingStrategies = "Coping Strategies"
    case treatment = "Treatment"
    case community = "Community"
    case crisis = "Crisis"
}

struct Resource: Identifiable, Codable {
    var id: UUID
    var title: String
    var category: ResourceCategory
    var content: String
    var readTime: Int
    var isPremium: Bool
    var isBookmarked: Bool
    
    init(id: UUID = UUID(), title: String, category: ResourceCategory, content: String, readTime: Int, isPremium: Bool = false, isBookmarked: Bool = false) {
        self.id = id
        self.title = title
        self.category = category
        self.content = content
        self.readTime = readTime
        self.isPremium = isPremium
        self.isBookmarked = isBookmarked
    }
}
