import SwiftUI
import SwiftData

struct BreathWorkView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var currentPhase = 0
    @State private var cycleCount = 0
    @State private var startTime = Date()
    @State private var preMoodRating: Int?
    @State private var postMoodRating: Int?
    @State private var isBreathing = false
    @State private var breathScale: CGFloat = 1.0
    
    let totalCycles = 5
    let breathPhases = ["Breathe In", "Hold", "Breathe Out", "Hold"]
    let phaseDurations = [4.0, 7.0, 8.0, 0.0] // 4-7-8 breathing technique
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color("BackgroundColor"), Color("PrimaryColor").opacity(0.1)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if preMoodRating == nil {
                    preMoodView
                } else if cycleCount < totalCycles {
                    breathingView
                } else if postMoodRating == nil {
                    postMoodView
                } else {
                    completionView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Exit") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var preMoodView: some View {
        VStack(spacing: 30) {
            Text("Before we begin")
                .font(.title)
                .fontWeight(.bold)
            
            Text("How are you feeling right now?")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 15) {
                ForEach(1...5, id: \.self) { rating in
                    Button {
                        preMoodRating = rating
                        startBreathing()
                    } label: {
                        Text("\(rating)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .background(Color("AccentColor").opacity(0.7))
                            .cornerRadius(25)
                    }
                }
            }
            
            Text("1 = Very Disconnected, 5 = Grounded")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
    
    var breathingView: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Cycle counter
            Text("Cycle \(cycleCount + 1) of \(totalCycles)")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            // Breathing circle
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color("PrimaryColor"), Color("PrimaryColor").opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 200, height: 200)
                    .scaleEffect(breathScale)
                    .animation(.easeInOut(duration: phaseDurations[currentPhase]), value: breathScale)
                
                VStack(spacing: 10) {
                    Image(systemName: getPhaseIcon())
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                    
                    Text(breathPhases[currentPhase])
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            
            // Instructions
            Text(getPhaseInstruction())
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // Skip button
            Button {
                skipToEnd()
            } label: {
                Text("Skip to End")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom)
        }
    }
    
    var postMoodView: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(Color("AccentColor"))
            
            Text("Breathing Complete")
                .font(.title)
                .fontWeight(.bold)
            
            Text("How are you feeling now?")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 15) {
                ForEach(1...5, id: \.self) { rating in
                    Button {
                        postMoodRating = rating
                        saveSession()
                    } label: {
                        Text("\(rating)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .background(Color("AccentColor").opacity(0.7))
                            .cornerRadius(25)
                    }
                }
            }
            
            Text("1 = Very Disconnected, 5 = Grounded")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
    
    var completionView: some View {
        VStack(spacing: 30) {
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundStyle(Color("AccentColor"))
            
            Text("Well Done!")
                .font(.title)
                .fontWeight(.bold)
            
            if let pre = preMoodRating, let post = postMoodRating, post > pre {
                Text("Your mood improved by \(post - pre) point\(post - pre > 1 ? "s" : "")")
                    .font(.headline)
                    .foregroundStyle(Color("PrimaryColor"))
            }
            
            Text("Your breath is your anchor")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding()
    }
    
    private func startBreathing() {
        isBreathing = true
        performBreathCycle()
    }
    
    private func performBreathCycle() {
        guard isBreathing && cycleCount < totalCycles else { return }
        
        let duration = phaseDurations[currentPhase]
        
        // Animate breath
        if currentPhase == 0 { // Breathe in
            breathScale = 1.5
        } else if currentPhase == 2 { // Breathe out
            breathScale = 1.0
        }
        
        // Move to next phase
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            currentPhase += 1
            
            if currentPhase >= breathPhases.count {
                currentPhase = 0
                cycleCount += 1
            }
            
            performBreathCycle()
        }
    }
    
    private func skipToEnd() {
        isBreathing = false
        cycleCount = totalCycles
    }
    
    private func getPhaseIcon() -> String {
        switch currentPhase {
        case 0: return "arrow.up.circle.fill"
        case 1: return "pause.circle.fill"
        case 2: return "arrow.down.circle.fill"
        case 3: return "pause.circle.fill"
        default: return "circle.fill"
        }
    }
    
    private func getPhaseInstruction() -> String {
        switch currentPhase {
        case 0: return "Breathe in slowly through your nose"
        case 1: return "Hold your breath gently"
        case 2: return "Breathe out slowly through your mouth"
        case 3: return "Pause before the next breath"
        default: return ""
        }
    }
    
    private func saveSession() {
        let session = GroundingSession(
            exerciseType: .breathWork,
            startTime: startTime,
            endTime: Date(),
            duration: Date().timeIntervalSince(startTime),
            preMoodRating: preMoodRating,
            postMoodRating: postMoodRating
        )
        modelContext.insert(session)
    }
}
