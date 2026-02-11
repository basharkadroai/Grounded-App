import SwiftUI
import SwiftData

struct DataExportView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var sessions: [GroundingSession]
    @Query private var habits: [Habit]
    @Query private var users: [User]
    
    @State private var isExporting = false
    @State private var exportURL: URL?
    @State private var showShareSheet = false
    @State private var selectedFormat: ExportFormat = .pdf
    
    enum ExportFormat: String, CaseIterable {
        case csv = "CSV"
        case pdf = "PDF"
        case json = "JSON"
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Export Your Data")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Download your grounding sessions, habits, and progress in various formats.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 10)
            }
            
            Section("Export Format") {
                Picker("Format", selection: $selectedFormat) {
                    ForEach(ExportFormat.allCases, id: \.self) { format in
                        Text(format.rawValue).tag(format)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("What's Included") {
                HStack {
                    Image(systemName: "figure.mind.and.body")
                        .foregroundStyle(Color("PrimaryColor"))
                    Text("Grounding Sessions")
                    Spacer()
                    Text("\(sessions.count)")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Image(systemName: "checklist")
                        .foregroundStyle(Color("PrimaryColor"))
                    Text("Habits")
                    Spacer()
                    Text("\(habits.count)")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundStyle(Color("PrimaryColor"))
                    Text("Progress Statistics")
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundStyle(.green)
                }
            }
            
            Section {
                Button {
                    exportData()
                } label: {
                    HStack {
                        if isExporting {
                            ProgressView()
                                .padding(.trailing, 10)
                        }
                        Text(isExporting ? "Exporting..." : "Export Data")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(isExporting)
            }
            
            Section(footer: Text("Your data is exported locally and never shared without your permission. You can import this data later or share it with your healthcare provider.")) {
                EmptyView()
            }
        }
        .navigationTitle("Export Data")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showShareSheet) {
            if let url = exportURL {
                ShareSheet(items: [url])
            }
        }
    }
    
    private func exportData() {
        isExporting = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            let url: URL?
            
            switch selectedFormat {
            case .csv:
                url = DataExportManager.shared.exportToCSV(sessions: sessions, habits: habits)
            case .pdf:
                url = DataExportManager.shared.exportToPDF(
                    sessions: sessions,
                    habits: habits,
                    userName: users.first?.name
                )
            case .json:
                url = DataExportManager.shared.exportToJSON(
                    sessions: sessions,
                    habits: habits,
                    user: users.first
                )
            }
            
            DispatchQueue.main.async {
                isExporting = false
                if let url = url {
                    exportURL = url
                    showShareSheet = true
                }
            }
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
