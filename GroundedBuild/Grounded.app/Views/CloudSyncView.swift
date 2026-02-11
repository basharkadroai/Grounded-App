import SwiftUI
import SwiftData

struct CloudSyncView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var cloudKitManager = CloudKitManager.shared
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isCheckingAccount = false
    @State private var accountAvailable = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "icloud.fill")
                            .font(.largeTitle)
                            .foregroundStyle(Color("PrimaryColor"))
                        
                        VStack(alignment: .leading) {
                            Text("iCloud Sync")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(accountAvailable ? "Connected" : "Not Connected")
                                .font(.subheadline)
                                .foregroundStyle(accountAvailable ? .green : .secondary)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            
            Section("Sync Status") {
                HStack {
                    Text("Last Sync")
                    Spacer()
                    if let lastSync = cloudKitManager.lastSyncDate {
                        Text(lastSync, style: .relative)
                            .foregroundStyle(.secondary)
                    } else {
                        Text("Never")
                            .foregroundStyle(.secondary)
                    }
                }
                
                if cloudKitManager.isSyncing {
                    HStack {
                        ProgressView()
                        Text("Syncing...")
                            .foregroundStyle(.secondary)
                    }
                }
                
                if let error = cloudKitManager.syncError {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                        Text(error)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
            }
            
            Section("What Gets Synced") {
                Label("Grounding Sessions", systemImage: "figure.mind.and.body")
                Label("Habits & Completions", systemImage: "checklist")
                Label("User Preferences", systemImage: "person.fill")
                Label("Progress Statistics", systemImage: "chart.line.uptrend.xyaxis")
            }
            
            Section {
                Button {
                    syncNow()
                } label: {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("Sync Now")
                    }
                    .frame(maxWidth: .infinity)
                }
                .disabled(cloudKitManager.isSyncing || !accountAvailable)
            }
            
            Section(footer: Text("Your data is encrypted and stored securely in your private iCloud account. Only you can access it.")) {
                EmptyView()
            }
        }
        .navigationTitle("Cloud Sync")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await checkAccount()
        }
        .alert("Sync Status", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    private func checkAccount() async {
        isCheckingAccount = true
        accountAvailable = await cloudKitManager.checkAccountStatus()
        isCheckingAccount = false
        
        if !accountAvailable {
            alertMessage = "iCloud is not available. Please sign in to iCloud in Settings."
            showingAlert = true
        }
    }
    
    private func syncNow() {
        Task {
            await cloudKitManager.syncAllData(modelContext: modelContext)
            
            if cloudKitManager.syncError == nil {
                alertMessage = "Sync completed successfully!"
            } else {
                alertMessage = "Sync failed: \(cloudKitManager.syncError ?? "Unknown error")"
            }
            showingAlert = true
        }
    }
}
