import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            HabitTrackerView()
                .tabItem {
                    Label("Habits", systemImage: "checklist")
                }
            
            ResourceLibraryView()
                .tabItem {
                    Label("Resources", systemImage: "book.fill")
                }
            
            InsightsView()
                .tabItem {
                    Label("Insights", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .tint(Color("AccentColor"))
    }
}
