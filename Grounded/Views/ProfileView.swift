import SwiftUI

struct ProfileView: View {
    @AppStorage("userName") private var userName = ""
    @AppStorage("isPremium") private var isPremium = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(Color("PrimaryColor"))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(userName.isEmpty ? "User" : userName)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(isPremium ? "Premium Member" : "Free Plan")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                Section("Subscription") {
                    if isPremium {
                        NavigationLink {
                            Text("Manage Subscription")
                        } label: {
                            Label("Manage Subscription", systemImage: "crown.fill")
                        }
                    } else {
                        Button {
                            // Show paywall
                        } label: {
                            HStack {
                                Label("Upgrade to Premium", systemImage: "crown.fill")
                                    .foregroundStyle(Color("AccentColor"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                
                Section("Settings") {
                    NavigationLink {
                        NotificationSettingsView()
                    } label: {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                    
                    NavigationLink {
                        Text("Privacy Settings")
                    } label: {
                        Label("Privacy", systemImage: "lock.fill")
                    }
                    
                    NavigationLink {
                        DataExportView()
                    } label: {
                        Label("Export Data", systemImage: "square.and.arrow.up")
                    }
                    
                    NavigationLink {
                        CloudSyncView()
                    } label: {
                        Label("Cloud Sync", systemImage: "icloud.fill")
                    }
                }
                
                Section("Support") {
                    NavigationLink {
                        Text("Help Center")
                    } label: {
                        Label("Help Center", systemImage: "questionmark.circle.fill")
                    }
                    
                    NavigationLink {
                        Text("Contact Support")
                    } label: {
                        Label("Contact Support", systemImage: "envelope.fill")
                    }
                    
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("About", systemImage: "info.circle.fill")
                    }
                }
                
                Section {
                    Button(role: .destructive) {
                        // Sign out logic
                    } label: {
                        Text("Sign Out")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct NotificationSettingsView: View {
    @StateObject private var notificationManager = NotificationManager.shared
    @State private var habitReminders = true
    @State private var dailyCheckIn = true
    @State private var weeklyInsights = false
    @State private var dailyCheckInTime = Date()
    @State private var weeklyInsightsDay = 1 // Sunday
    @State private var showingPermissionAlert = false
    
    var body: some View {
        List {
            if !notificationManager.isAuthorized {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "bell.slash.fill")
                                .foregroundStyle(.orange)
                            Text("Notifications Disabled")
                                .fontWeight(.semibold)
                        }
                        
                        Text("Enable notifications to receive habit reminders and check-ins.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        Button("Enable Notifications") {
                            requestPermission()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.vertical, 5)
                }
            }
            
            Section("Reminders") {
                Toggle("Habit Reminders", isOn: $habitReminders)
                    .onChange(of: habitReminders) { _, newValue in
                        if newValue && !notificationManager.isAuthorized {
                            showingPermissionAlert = true
                        }
                    }
                
                Toggle("Daily Check-in", isOn: $dailyCheckIn)
                    .onChange(of: dailyCheckIn) { _, newValue in
                        if newValue {
                            notificationManager.scheduleDailyCheckIn(at: dailyCheckInTime)
                        } else {
                            notificationManager.cancelDailyCheckIn()
                        }
                    }
                
                if dailyCheckIn {
                    DatePicker("Check-in Time", selection: $dailyCheckInTime, displayedComponents: .hourAndMinute)
                        .onChange(of: dailyCheckInTime) { _, newValue in
                            notificationManager.scheduleDailyCheckIn(at: newValue)
                        }
                }
                
                Toggle("Weekly Insights", isOn: $weeklyInsights)
                    .onChange(of: weeklyInsights) { _, newValue in
                        if newValue {
                            notificationManager.scheduleWeeklyInsights(dayOfWeek: weeklyInsightsDay, hour: 9)
                        } else {
                            notificationManager.cancelWeeklyInsights()
                        }
                    }
                
                if weeklyInsights {
                    Picker("Day", selection: $weeklyInsightsDay) {
                        Text("Sunday").tag(1)
                        Text("Monday").tag(2)
                        Text("Tuesday").tag(3)
                        Text("Wednesday").tag(4)
                        Text("Thursday").tag(5)
                        Text("Friday").tag(6)
                        Text("Saturday").tag(7)
                    }
                    .onChange(of: weeklyInsightsDay) { _, newValue in
                        notificationManager.scheduleWeeklyInsights(dayOfWeek: newValue, hour: 9)
                    }
                }
            }
            
            Section(footer: Text("We'll send gentle reminders to help you stay on track with your mental health goals.")) {
                EmptyView()
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Enable Notifications", isPresented: $showingPermissionAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please enable notifications in Settings to receive reminders.")
        }
    }
    
    private func requestPermission() {
        Task {
            let granted = await notificationManager.requestAuthorization()
            if granted {
                notificationManager.setupNotificationCategories()
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("About Grounded") {
                Text("Grounded is designed to help individuals manage Depersonalization-Derealization Disorder (DPDR) through evidence-based grounding techniques, habit tracking, and educational resources.")
                    .font(.body)
            }
            
            Section {
                Button("Privacy Policy") {
                    // TODO: Add privacy policy URL
                }
                Button("Terms of Service") {
                    // TODO: Add terms of service URL
                }
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}
