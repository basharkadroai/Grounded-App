import SwiftUI
import SwiftData

struct BodyScanView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var currentStep = 0
    @State private var startTime = Date()
    @State private var preMoodRating: Int?
    @State private var postMoodRating: Int?
    
    let bodyParts = [
        (name: "Feet", instruction: "Notice your feet on the ground. Feel their weight and temperature.", icon: "👣"),
        (name: "Legs", instruction: "Bring awareness to your legs. Notice any tension or relaxation.", icon: "🦵"),
        (name: "Hips", instruction: "Focus on your hips and lower back. Breathe into this area.", icon: "🧍"),
        (name: "Stomach", instruction: "Notice your stomach rising and falling with each breath.", icon: "🫁"),
        (name: "Chest", instruction: "Feel your chest expanding and contracting. Notice your heartbeat.", icon: "❤️"),
        (name: "Arms", instruction: "Bring attention to your arms and hands. Notice any sensations.", icon: "💪"),
        (name: "Shoulders", instruction: "Notice any tension in your shoulders. Let them relax.", icon: "🤷"),
        (name: "Neck", instruction: "Gently bring awareness to your neck. Release any tightness.", icon: "🧘"),
        (name: "Face", instruction: "Notice your facial muscles. Soften your jaw and forehead.", icon: "😌"),
        (name: "Whole Body", instruction: "Feel your entire body as one. You are present and grounded.", icon: "✨")
    ]
    
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
                } else if currentStep < bodyParts.count {
                    bodyScanStepView
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
    
    var bodyScanStepView: some View {
        VStack(spacing: 40) {
            // Progress
            HStack(spacing: 4) {
                ForEach(0..<bodyParts.count, id: \.self) { index in
                    Rectangle()
                        .fill(index <= currentStep ? Color("AccentColor") : Color.gray.opacity(0.3))
                        .frame(height: 4)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            
            // Icon
            Text(bodyParts[currentStep].icon)
                .font(.system(size: 80))
            
            // Body Part
            Text(bodyParts[currentStep].name)
                .font(.title)
                .fontWeight(.bold)
            
            // Instruction
            Text(bodyParts[currentStep].instruction)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            // Breathing indicator
            Circle()
                .fill(Color("PrimaryColor").opacity(0.3))
                .frame(width: 100, height: 100)
                .overlay(
                    Circle()
                        .fill(Color("PrimaryColor"))
                        .frame(width: 60, height: 60)
                        .scaleEffect(breathingScale)
                )
            
            Spacer()
            
            // Next Button
            Button {
                withAnimation {
                    if currentStep < bodyParts.count - 1 {
                        currentStep += 1
                    } else {
                        currentStep += 1
                    }
                }
            } label: {
                Text(currentStep < bodyParts.count - 1 ? "Next" : "Complete")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    
    @State private var breathingScale: CGFloat = 1.0
    
    var postMoodView: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(Color("AccentColor"))
            
            Text("Body Scan Complete")
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
            
            Text("You've reconnected with your body")
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
    
    private func saveSession() {
        let session = GroundingSession(
            exerciseType: .bodyScan,
            startTime: startTime,
            endTime: Date(),
            duration: Date().timeIntervalSince(startTime),
            preMoodRating: preMoodRating,
            postMoodRating: postMoodRating
        )
        modelContext.insert(session)
    }
}
