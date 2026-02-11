import Foundation
import CloudKit
import SwiftData

class CloudKitManager: ObservableObject {
    static let shared = CloudKitManager()
    
    private let container: CKContainer
    private let privateDatabase: CKDatabase
    @Published var isSyncing = false
    @Published var lastSyncDate: Date?
    @Published var syncError: String?
    
    private init() {
        container = CKContainer(identifier: "iCloud.com.yourcompany.Grounded")
        privateDatabase = container.privateCloudDatabase
        loadLastSyncDate()
    }
    
    // MARK: - Sync Methods
    
    func syncAllData(modelContext: ModelContext) async {
        guard !isSyncing else { return }
        
        await MainActor.run {
            isSyncing = true
            syncError = nil
        }
        
        do {
            // Sync in order: User -> Sessions -> Habits
            try await syncUser(modelContext: modelContext)
            try await syncGroundingSessions(modelContext: modelContext)
            try await syncHabits(modelContext: modelContext)
            
            await MainActor.run {
                lastSyncDate = Date()
                saveLastSyncDate()
                isSyncing = false
            }
        } catch {
            await MainActor.run {
                syncError = error.localizedDescription
                isSyncing = false
            }
        }
    }
    
    // MARK: - User Sync
    
    private func syncUser(modelContext: ModelContext) async throws {
        let descriptor = FetchDescriptor<User>()
        let users = try modelContext.fetch(descriptor)
        
        guard let user = users.first else { return }
        
        let record = CKRecord(recordType: "User", recordID: CKRecord.ID(recordName: user.id.uuidString))
        record["name"] = user.name as? CKRecordValue
        record["onboardingCompleted"] = user.onboardingCompleted as CKRecordValue
        record["goals"] = user.goals as CKRecordValue
        record["isPremium"] = user.isPremium as CKRecordValue
        record["createdAt"] = user.createdAt as CKRecordValue
        
        try await privateDatabase.save(record)
    }
    
    // MARK: - Grounding Sessions Sync
    
    private func syncGroundingSessions(modelContext: ModelContext) async throws {
        let descriptor = FetchDescriptor<GroundingSession>()
        let sessions = try modelContext.fetch(descriptor)
        
        for session in sessions {
            let record = CKRecord(recordType: "GroundingSession", recordID: CKRecord.ID(recordName: session.id.uuidString))
            record["exerciseType"] = session.exerciseType as CKRecordValue
            record["startTime"] = session.startTime as CKRecordValue
            record["endTime"] = session.endTime as CKRecordValue
            record["duration"] = session.duration as CKRecordValue
            record["preMoodRating"] = session.preMoodRating as? CKRecordValue
            record["postMoodRating"] = session.postMoodRating as? CKRecordValue
            record["notes"] = session.notes as? CKRecordValue
            
            try await privateDatabase.save(record)
        }
    }
    
    // MARK: - Habits Sync
    
    private func syncHabits(modelContext: ModelContext) async throws {
        let descriptor = FetchDescriptor<Habit>()
        let habits = try modelContext.fetch(descriptor)
        
        for habit in habits {
            let record = CKRecord(recordType: "Habit", recordID: CKRecord.ID(recordName: habit.id.uuidString))
            record["name"] = habit.name as CKRecordValue
            record["icon"] = habit.icon as CKRecordValue
            record["frequencyData"] = habit.frequencyData as? CKRecordValue
            record["reminderTime"] = habit.reminderTime as? CKRecordValue
            record["createdAt"] = habit.createdAt as CKRecordValue
            record["completionsData"] = habit.completionsData as? CKRecordValue
            
            try await privateDatabase.save(record)
        }
    }
    
    // MARK: - Fetch from CloudKit
    
    func fetchAllData(modelContext: ModelContext) async throws {
        try await fetchUsers(modelContext: modelContext)
        try await fetchGroundingSessions(modelContext: modelContext)
        try await fetchHabits(modelContext: modelContext)
    }
    
    private func fetchUsers(modelContext: ModelContext) async throws {
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        let results = try await privateDatabase.records(matching: query)
        
        for (_, result) in results.matchResults {
            let record = try result.get()
            
            let user = User(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                name: record["name"] as? String,
                onboardingCompleted: record["onboardingCompleted"] as? Bool ?? false,
                goals: record["goals"] as? [String] ?? [],
                createdAt: record["createdAt"] as? Date ?? Date(),
                isPremium: record["isPremium"] as? Bool ?? false
            )
            
            modelContext.insert(user)
        }
    }
    
    private func fetchGroundingSessions(modelContext: ModelContext) async throws {
        let query = CKQuery(recordType: "GroundingSession", predicate: NSPredicate(value: true))
        let results = try await privateDatabase.records(matching: query)
        
        for (_, result) in results.matchResults {
            let record = try result.get()
            
            let exerciseTypeString = record["exerciseType"] as? String ?? "5-4-3-2-1"
            let exerciseType = ExerciseType(rawValue: exerciseTypeString) ?? .fiveFourThreeTwoOne
            
            let session = GroundingSession(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                exerciseType: exerciseType,
                startTime: record["startTime"] as? Date ?? Date(),
                endTime: record["endTime"] as? Date ?? Date(),
                duration: record["duration"] as? TimeInterval ?? 0,
                preMoodRating: record["preMoodRating"] as? Int,
                postMoodRating: record["postMoodRating"] as? Int,
                notes: record["notes"] as? String
            )
            
            modelContext.insert(session)
        }
    }
    
    private func fetchHabits(modelContext: ModelContext) async throws {
        let query = CKQuery(recordType: "Habit", predicate: NSPredicate(value: true))
        let results = try await privateDatabase.records(matching: query)
        
        for (_, result) in results.matchResults {
            let record = try result.get()
            
            let habit = Habit(
                id: UUID(uuidString: record.recordID.recordName) ?? UUID(),
                name: record["name"] as? String ?? "",
                icon: record["icon"] as? String ?? "💧",
                createdAt: record["createdAt"] as? Date ?? Date()
            )
            
            if let frequencyData = record["frequencyData"] as? Data {
                habit.frequencyData = frequencyData
            }
            
            if let completionsData = record["completionsData"] as? Data {
                habit.completionsData = completionsData
            }
            
            modelContext.insert(habit)
        }
    }
    
    // MARK: - Helper Methods
    
    private func loadLastSyncDate() {
        lastSyncDate = UserDefaults.standard.object(forKey: "lastCloudKitSync") as? Date
    }
    
    private func saveLastSyncDate() {
        UserDefaults.standard.set(lastSyncDate, forKey: "lastCloudKitSync")
    }
    
    func checkAccountStatus() async -> Bool {
        do {
            let status = try await container.accountStatus()
            return status == .available
        } catch {
            return false
        }
    }
}
