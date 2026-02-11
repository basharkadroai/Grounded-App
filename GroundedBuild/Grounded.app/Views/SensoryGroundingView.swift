import SwiftUI
import SwiftData

struct SensoryGroundingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var currentSense = 0
    @State private var startTime = Date()
    @State private var preMoodRating: Int?
    @State private var postMoodRating: Int?
    @State private var userInput = ""
    
    let senses = [
        (name: "Sight", prompt: "Look around and describe something you see in detail. Notice its color, shape, and texture.", icon: "👁️", placeholder: "I see..."),
        (name: "Touch", prompt: "Touch something near you. Describe how it feels. Is it smooth, rough, warm, cold?", icon: "✋", placeholder: "It feels..."),
        (name: "Hearing", prompt: "Close your eyes and listen. What sounds can you hear? Describe them in detail.", icon: "👂", placeholder: "I hear..."),
        (name: "Smell", prompt: "What can you smell right now? If nothing, describe a scent you enjoy.", icon: "👃", placeholder: "I smell..."),
        (name: "Taste", prompt: "What taste is in your mouth? Or describe your favorite taste.", icon: "👅", placeholder: "I taste...")
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
                } else if currentSense < senses.count {
                    sensoryStepView
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
    
    var sensoryStepView: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Progress
                HStack(spacing: 8) {
                    ForEach(0..<senses.count, id: \.self) { index in
                        Circle()
                            .fill(index <= currentSense ? Color("AccentColor") : Color.gray.opacity(0.3))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 40)
                
                // Icon
                Text(senses[currentSense].icon)
                    .font(.system(size: 80))
                
                // Sense name
                Text(senses[currentSense].name)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Prompt
                Text(senses[currentSense].prompt)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                // Text input
                VStack(alignment: .leading, spacing: 10) {
                    Text("Describe what you notice:")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    TextEditor(text: $userInput)
                        .frame(height: 120)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("PrimaryColor").opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 30)
                
                // Next button
                Button {
                    nextSense()
                } label: {
                    Text(currentSense < senses.count - 1 ? "Next Sense" : "Complete")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
    
    var postMoodView: some View {
        VStack(spacing: 30) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(Color("AccentColor"))
            
            Text("Sensory Grounding Complete")
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
            
            Text("You've reconnected with your senses")
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
    
    private func nextSense() {
        userInput = ""
        withAnimation {
            currentSense += 1
        }
    }
    
    private func saveSession() {
        let session = GroundingSession(
            exerciseType: .sensoryGrounding,
            startTime: startTime,
            endTime: Date(),
            duration: Date().timeIntervalSince(startTime),
            preMoodRating: preMoodRating,
            postMoodRating: postMoodRating
        )
        modelContext.insert(session)
    }
}
