import SwiftUI
import SwiftData

@main
struct GroundedApp: App {
    init() {
        SuperwallManager.shared.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, GroundingSession.self, Habit.self])
    }
}
