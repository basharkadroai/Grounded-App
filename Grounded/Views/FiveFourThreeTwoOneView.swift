import SwiftUI
import SwiftData

struct FiveFourThreeTwoOneView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let exerciseType: ExerciseType
    
    @State private var currentStep = 0
    @State private var startTime = Date()
    @State private var preMoodRating: Int?
    @State private var postMoodRating: Int?
    @State private var showingCompletion = false
    
    let steps = [
        (count: 5, sense: "See", prompt: "Name 5 things you can see around you", icon: "eye.fill"),
        (count: 4, sense: "Touch", prompt: "Name 4 things you can touch", icon: "hand.raised.fill"),
        (count: 3, sense: "Hear", prompt: "Name 3 things you can hear", icon: "ear.fill"),
        (count: 2, sense: "Smell", prompt: "Name 2 things you can smell", icon: "nose.fill"),
        (count: 1, sense: "Taste", prompt: "Name 1 thing you can taste", icon: "mouth.fill")
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
                } else if currentStep < steps.count {
                    exerciseStepView
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
    
    var exerciseStepView: some View {
        VStack(spacing: 40) {
            // Progress
            HStack(spacing: 8) {
                ForEach(0..<steps.count, id: \.self) { index in
                    Circle()
                        .fill(index <= currentStep ? Color("AccentColor") : Color.gray.opacity(0.3))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top)
            
            Spacer()
            
            // Icon
            Image(systemName: steps[currentStep].icon)
                .font(.system(size: 60))
                .foregroundStyle(Color("PrimaryColor"))
            
            // Count
            Text("\(steps[currentStep].count)")
                .font(.system(size: 80, weight: .bold))
                .foregroundStyle(Color("AccentColor"))
            
            // Sense
            Text(steps[currentStep].sense)
                .font(.title)
                .fontWeight(.semibold)
            
            // Prompt
            Text(steps[currentStep].prompt)
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            // Next Button
            Button {
                withAnimation {
                    if currentStep < steps.count - 1 {
                        currentStep += 1
                    } else {
                        currentStep += 1
                    }
                }
            } label: {
                Text(currentStep < steps.count - 1 ? "Next" : "Complete")
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
    
    var postMoodView: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(Color("AccentColor"))
            
            Text("Exercise Complete")
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
            
            Text("Remember to take care of yourself")
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
            exerciseType: exerciseType,
            startTime: startTime,
            endTime: Date(),
            duration: Date().timeIntervalSince(startTime),
            preMoodRating: preMoodRating,
            postMoodRating: postMoodRating
        )
        modelContext.insert(session)
    }
}
