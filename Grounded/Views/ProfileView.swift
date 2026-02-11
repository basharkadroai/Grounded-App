import SwiftUI

struct ProfileView: View {
    @AppStorage("userName") private var userName = ""
    @AppStorage("isPremium") private var isPremium = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                PremiumDesign.Gradients.backgroundMesh
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color("PrimaryColor").opacity(0.1))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundStyle(Color("PrimaryColor").gradient)
                                    .shadow(color: Color("PrimaryColor").opacity(0.3), radius: 10)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(userName.isEmpty ? "User" : userName)
                                    .font(.system(.title2, design: .rounded))
                                    .fontWeight(.bold)
                                
                                Text(isPremium ? "Premium Member" : "Free Plan")
                                    .font(.system(.subheadline, design: .rounded))
                                    .foregroundStyle(.secondary)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(isPremium ? Color.yellow.opacity(0.2) : Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                            }
                            
                            Spacer()
                        }
                        .padding(20)
                        
                        // Subscription Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Subscription")
                                .font(.system(.headline, design: .rounded))
                                .padding(.horizontal, 4)
                            
                            if isPremium {
                                NavigationLink {
                                    Text("Manage Subscription")
                                } label: {
                                    SettingsRow(icon: "crown.fill", title: "Manage Subscription", color: .yellow)
                                }
                            } else {
                                Button {
                                    // Show paywall
                                } label: {
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .fill(Color("AccentColor").opacity(0.1))
                                                .frame(width: 32, height: 32)
                                            Image(systemName: "crown.fill")
                                                .foregroundStyle(Color("AccentColor"))
                                        }
                                        
                                        Text("Upgrade to Premium")
                                            .font(.system(.body, design: .rounded))
                                            .fontWeight(.medium)
                                            .foregroundStyle(Color("AccentColor"))
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(.tertiary)
                                    }
                                    .padding()
                                    .background(Color("AccentColor").opacity(0.05))
                                    .cornerRadius(16)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color("AccentColor").opacity(0.2), lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        // Settings Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Settings")
                                .font(.system(.headline, design: .rounded))
                                .padding(.horizontal, 4)
                            
                            VStack(spacing: 1) {
                                NavigationLink {
                                    NotificationSettingsView()
                                } label: {
                                    SettingsRow(icon: "bell.fill", title: "Notifications", color: .blue)
                                }
                                
                                Divider().padding(.leading, 50)
                                
                                NavigationLink {
                                    Text("Privacy Settings")
                                } label: {
                                    SettingsRow(icon: "lock.fill", title: "Privacy", color: .green)
                                }
                                
                                Divider().padding(.leading, 50)
                                
                                NavigationLink {
                                    DataExportView()
                                } label: {
                                    SettingsRow(icon: "square.and.arrow.up", title: "Export Data", color: .purple)
                                }
                                
                                Divider().padding(.leading, 50)
                                
                                NavigationLink {
                                    CloudSyncView()
                                } label: {
                                    SettingsRow(icon: "icloud.fill", title: "Cloud Sync", color: .blue)
                                }
                            }
                            .premiumGlassCard(cornerRadius: 16)
                        }
                        .padding(.horizontal)
                        
                        // Support Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Support")
                                .font(.system(.headline, design: .rounded))
                                .padding(.horizontal, 4)
                            
                            VStack(spacing: 1) {
                                NavigationLink {
                                    Text("Help Center")
                                } label: {
                                    SettingsRow(icon: "questionmark.circle.fill", title: "Help Center", color: .orange)
                                }
                                
                                Divider().padding(.leading, 50)
                                
                                NavigationLink {
                                    Text("Contact Support")
                                } label: {
                                    SettingsRow(icon: "envelope.fill", title: "Contact Support", color: .blue)
                                }
                                
                                Divider().padding(.leading, 50)
                                
                                NavigationLink {
                                    AboutView()
                                } label: {
                                    SettingsRow(icon: "info.circle.fill", title: "About", color: .gray)
                                }
                            }
                            .premiumGlassCard(cornerRadius: 16)
                        }
                        .padding(.horizontal)
                        
                        // Sign Out
                        Button(role: .destructive) {
                            // Sign out logic
                        } label: {
                            Text("Sign Out")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .premiumGlassCard(cornerRadius: 16)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 32, height: 32)
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundStyle(color)
            }
            
            Text(title)
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .contentShape(Rectangle())
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
