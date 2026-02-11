import SwiftUI

struct GroundingExerciseSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedExercise: ExerciseType?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Choose a Grounding Exercise")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ExerciseOptionCard(
                            type: .fiveFourThreeTwoOne,
                            icon: "hand.raised.fingers.spread.fill",
                            description: "Engage all five senses",
                            duration: "5-7 min",
                            selectedExercise: $selectedExercise
                        )
                        
                        ExerciseOptionCard(
                            type: .bodyScan,
                            icon: "figure.stand",
                            description: "Focus on body awareness",
                            duration: "8-10 min",
                            selectedExercise: $selectedExercise
                        )
                        
                        ExerciseOptionCard(
                            type: .breathWork,
                            icon: "wind",
                            description: "Guided breathing patterns",
                            duration: "3-5 min",
                            selectedExercise: $selectedExercise
                        )
                        
                        ExerciseOptionCard(
                            type: .sensoryGrounding,
                            icon: "eye.fill",
                            description: "Deep sensory focus",
                            duration: "5-8 min",
                            selectedExercise: $selectedExercise
                        )
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .fullScreenCover(item: $selectedExercise) { exercise in
                switch exercise {
                case .fiveFourThreeTwoOne:
                    FiveFourThreeTwoOneView(exerciseType: exercise)
                case .bodyScan:
                    BodyScanView()
                case .breathWork:
                    BreathWorkView()
                case .sensoryGrounding:
                    SensoryGroundingView()
                }
            }
        }
    }
}

struct ExerciseOptionCard: View {
    let type: ExerciseType
    let icon: String
    let description: String
    let duration: String
    @Binding var selectedExercise: ExerciseType?
    
    var body: some View {
        Button {
            selectedExercise = type
        } label: {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundStyle(Color("PrimaryColor"))
                    .frame(width: 50)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(type.rawValue)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(duration)
                        .font(.caption)
                        .foregroundStyle(Color("AccentColor"))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}
