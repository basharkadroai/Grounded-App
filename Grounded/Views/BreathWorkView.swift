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
    @State private var breathBlur: CGFloat = 10.0
    
    let totalCycles = 5
    let breathPhases = ["Breathe In", "Hold", "Breathe Out", "Hold"]
    let phaseDurations = [4.0, 7.0, 8.0, 0.0] // 4-7-8 breathing technique
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Premium Background
                PremiumDesign.Gradients.backgroundMesh
                    .ignoresSafeArea()
                
                if preMoodRating == nil {
                    preMoodView
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                } else if cycleCount < totalCycles {
                    breathingView
                        .transition(.opacity)
                } else if postMoodRating == nil {
                    postMoodView
                        .transition(.move(edge: .top).combined(with: .opacity))
                } else {
                    completionView
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: preMoodRating)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: cycleCount)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: postMoodRating)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Exit") {
                        dismiss()
                    }
                    .font(.system(.body, design: .rounded).weight(.medium))
                }
            }
        }
    }
    
    var preMoodView: some View {
        VStack(spacing: 32) {
            VStack(spacing: 12) {
                Text("Before we begin")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                
                Text("How are you feeling right now?")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 18) {
                ForEach(1...5, id: \.self) { rating in
                    Button {
                        withAnimation {
                            preMoodRating = rating
                            startBreathing()
                        }
                    } label: {
                        Text("\(rating)")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(Color("AccentColor").gradient)
                            )
                            .premiumShadow()
                    }
                }
            }
            
            Text("1 = Very Disconnected, 5 = Grounded")
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
        }
        .padding(32)
        .premiumGlassCard()
        .padding()
    }
    
    var breathingView: some View {
        VStack(spacing: 60) {
            // Cycle counter
            VStack(spacing: 8) {
                Text("BREATHING EXERCISE")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(Color("PrimaryColor"))
                    .letterSpacing(2)
                
                Text("Cycle \(cycleCount + 1) of \(totalCycles)")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 40)
            
            // Breathing circle
            ZStack {
                // Outer Glow
                Circle()
                    .fill(Color("PrimaryColor").opacity(0.15))
                    .frame(width: 320, height: 320)
                    .scaleEffect(breathScale * 1.1)
                    .blur(radius: breathBlur)
                
                // Secondary Circle
                Circle()
                    .fill(Color("PrimaryColor").opacity(0.3))
                    .frame(width: 260, height: 260)
                    .scaleEffect(breathScale * 1.05)
                
                // Main Circle
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color("PrimaryColor"), Color("PrimaryColor").opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 220, height: 220)
                    .scaleEffect(breathScale)
                    .premiumShadow()
                
                VStack(spacing: 12) {
                    Image(systemName: getPhaseIcon())
                        .font(.system(size: 44))
                        .foregroundStyle(.white)
                        .contentTransition(.symbolEffect(.replace))
                    
                    Text(breathPhases[currentPhase])
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            .animation(.easeInOut(duration: phaseDurations[currentPhase]), value: breathScale)
            
            // Instructions
            Text(getPhaseInstruction())
                .font(.system(.body, design: .rounded))
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .frame(height: 60)
            
            Spacer()
            
            // Skip button
            Button {
                skipToEnd()
            } label: {
                Text("Skip Exercise")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary.opacity(0.6))
            }
            .padding(.bottom, 20)
        }
    }
    
    var postMoodView: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(Color("AccentColor").gradient)
                    .symbolEffect(.bounce, value: cycleCount)
                
                Text("Breathing Complete")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                
                Text("How are you feeling now?")
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 18) {
                ForEach(1...5, id: \.self) { rating in
                    Button {
                        withAnimation {
                            postMoodRating = rating
                            saveSession()
                        }
                    } label: {
                        Text("\(rating)")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(Color("AccentColor").gradient)
                            )
                            .premiumShadow()
                    }
                }
            }
            
            Text("1 = Very Disconnected, 5 = Grounded")
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
        }
        .padding(32)
        .premiumGlassCard()
        .padding()
    }
    
    var completionView: some View {
        VStack(spacing: 32) {
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(Color("AccentColor").opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 56))
                        .foregroundStyle(Color("AccentColor").gradient)
                }
                
                Text("Well Done!")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                
                if let pre = preMoodRating, let post = postMoodRating, post > pre {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.up.circle.fill")
                        Text("Mood improved by \(post - pre) point\(post - pre > 1 ? "s" : "")")
                    }
                    .font(.system(.headline, design: .rounded))
                    .foregroundStyle(Color("PrimaryColor"))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color("PrimaryColor").opacity(0.1))
                    .cornerRadius(20)
                }
                
                Text("“Inhale the future, exhale the past.”")
                    .font(.system(.body, design: .rounded).italic())
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button {
                dismiss()
            } label: {
                Text("Complete")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.premium(color: Color("AccentColor")))
        }
        .padding(32)
        .premiumGlassCard()
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
            breathScale = 1.6
            breathBlur = 20
        } else if currentPhase == 2 { // Breathe out
            breathScale = 1.0
            breathBlur = 5
        }
        
        // Move to next phase
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation {
                currentPhase += 1
                
                if currentPhase >= breathPhases.count {
                    currentPhase = 0
                    cycleCount += 1
                }
            }
            
            if isBreathing {
                performBreathCycle()
            }
        }
    }
    
    private func skipToEnd() {
        isBreathing = false
        withAnimation {
            cycleCount = totalCycles
        }
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
        case 0: return "Inhale slowly through your nose..."
        case 1: return "Hold your breath gently"
        case 2: return "Exhale slowly through your mouth"
        case 3: return "Pause and prepare..."
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

