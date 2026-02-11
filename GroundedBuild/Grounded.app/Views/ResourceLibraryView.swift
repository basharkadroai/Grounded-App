import SwiftUI

struct ResourceLibraryView: View {
    @State private var searchText = ""
    @State private var selectedCategory: ResourceCategory?
    @State private var resources: [Resource] = ResourceData.allResources
    
    var filteredResources: [Resource] {
        var filtered = resources
        
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                        TextField("Search resources", text: $searchText)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Category Filter
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            CategoryChip(title: "All", isSelected: selectedCategory == nil) {
                                selectedCategory = nil
                            }
                            
                            ForEach([ResourceCategory.understandingDPDR, .copingStrategies, .treatment, .community, .crisis], id: \.self) { category in
                                CategoryChip(title: category.rawValue, isSelected: selectedCategory == category) {
                                    selectedCategory = category
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Resources List
                    LazyVStack(spacing: 15) {
                        ForEach(filteredResources) { resource in
                            NavigationLink(destination: ResourceDetailView(resource: resource)) {
                                ResourceListCard(resource: resource)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Resources")
        }
    }
}

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color("AccentColor") : Color(.systemGray6))
                .cornerRadius(20)
        }
    }
}

struct ResourceListCard: View {
    let resource: Resource
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(resource.category.rawValue)
                        .font(.caption)
                        .foregroundStyle(Color("PrimaryColor"))
                        .fontWeight(.semibold)
                    
                    if resource.isPremium {
                        Image(systemName: "crown.fill")
                            .font(.caption)
                            .foregroundStyle(.yellow)
                    }
                }
                
                Text(resource.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                    Text("\(resource.readTime) min read")
                        .font(.caption)
                }
                .foregroundStyle(.secondary)
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

struct ResourceDetailView: View {
    let resource: Resource
    @State private var isBookmarked = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text(resource.category.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(Color("PrimaryColor"))
                        .fontWeight(.semibold)
                    
                    Text(resource.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text("\(resource.readTime) min read")
                            .font(.caption)
                    }
                    .foregroundStyle(.secondary)
                }
                
                Divider()
                
                // Content
                Text(resource.content)
                    .font(.body)
                    .lineSpacing(8)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isBookmarked.toggle()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                }
            }
        }
    }
}

// Sample Resources
struct SampleResources {
    static let all: [Resource] = [
        Resource(
            title: "What is DPDR?",
            category: .understandingDPDR,
            content: """
            Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder that affects how you perceive yourself and the world around you.
            
            Key Characteristics:
            
            Depersonalization involves feeling detached from yourself - like you're observing your thoughts, feelings, and body from outside. You might feel like you're in a dream or watching a movie of your life.
            
            Derealization involves feeling detached from your surroundings. The world may seem foggy, dreamlike, or unreal. Objects might appear distorted in size or color.
            
            Important to Know:
            
            You maintain awareness that these perceptions are distorted - your reality testing remains intact. This distinguishes DPDR from psychotic disorders.
            
            DPDR is more common than you might think, affecting about 2% of the population. Many people experience brief episodes during times of stress.
            
            The condition is treatable through therapy, lifestyle changes, and sometimes medication. Grounding techniques are particularly effective for managing symptoms.
            """,
            readTime: 5
        ),
        Resource(
            title: "The 5-4-3-2-1 Technique",
            category: .copingStrategies,
            content: """
            The 5-4-3-2-1 grounding technique is one of the most effective tools for managing DPDR episodes. It works by engaging all five senses to anchor you in the present moment.
            
            How It Works:
            
            5 Things You Can See: Look around and name five things you can see. Be specific - "a blue coffee mug" rather than just "a mug."
            
            4 Things You Can Touch: Notice four things you can physically feel. The texture of your clothing, the temperature of the air, your feet on the ground.
            
            3 Things You Can Hear: Identify three sounds. Traffic outside, a clock ticking, your own breathing.
            
            2 Things You Can Smell: Notice two scents. If you can't smell anything, name two scents you enjoy.
            
            1 Thing You Can Taste: Focus on one taste in your mouth, or name your favorite flavor.
            
            Why It Helps:
            
            This technique interrupts dissociative thoughts by redirecting your attention to concrete, sensory experiences. It's portable, requires no equipment, and can be done anywhere.
            """,
            readTime: 4
        ),
        Resource(
            title: "Understanding Your Triggers",
            category: .copingStrategies,
            content: """
            Identifying what triggers your DPDR episodes is crucial for managing the condition. Common triggers include stress, anxiety, lack of sleep, and certain environments.
            
            Common Triggers:
            
            Stress and Anxiety: High-pressure situations often precede episodes. Learning stress management techniques can reduce frequency.
            
            Sleep Deprivation: Poor sleep quality or insufficient sleep is a major trigger for many people with DPDR.
            
            Substance Use: Caffeine, alcohol, and recreational drugs can trigger or worsen symptoms.
            
            Sensory Overload: Crowded places, bright lights, or loud noises may trigger episodes in some people.
            
            Tracking Your Patterns:
            
            Keep a journal noting when episodes occur and what preceded them. Over time, patterns will emerge that help you anticipate and prevent episodes.
            """,
            readTime: 6
        ),
        Resource(
            title: "When to Seek Professional Help",
            category: .treatment,
            content: """
            While self-help strategies are valuable, professional treatment is often necessary for managing DPDR effectively.
            
            Signs You Should Seek Help:
            
            Episodes are frequent or persistent, lasting hours or days
            Symptoms significantly interfere with work, relationships, or daily activities
            You experience depression or anxiety alongside DPDR
            Self-help strategies aren't providing relief
            
            Treatment Options:
            
            Cognitive Behavioral Therapy (CBT): Helps identify and change thought patterns that contribute to dissociation.
            
            EMDR: Eye Movement Desensitization and Reprocessing can be effective, especially if trauma is involved.
            
            Medication: While no medication specifically treats DPDR, antidepressants or anti-anxiety medications may help with co-occurring conditions.
            
            Finding the Right Therapist:
            
            Look for therapists experienced with dissociative disorders. Don't hesitate to try different therapists until you find the right fit.
            """,
            readTime: 7
        ),
        Resource(
            title: "You're Not Alone",
            category: .community,
            content: """
            Living with DPDR can feel isolating, but you're far from alone. Millions of people worldwide experience this condition.
            
            The DPDR Community:
            
            Online forums and support groups connect people with DPDR. Sharing experiences and coping strategies can be incredibly validating.
            
            Many people with DPDR lead full, successful lives. The condition is manageable with the right tools and support.
            
            Common Experiences:
            
            Feeling like you're "going crazy" - you're not. DPDR is a recognized medical condition.
            
            Difficulty explaining the experience to others - this is normal. The sensations are hard to put into words.
            
            Fear that it will never end - most people see significant improvement with treatment and time.
            
            Moving Forward:
            
            Recovery is possible. While the journey may have ups and downs, consistent use of coping strategies and professional support lead to improvement for most people.
            """,
            readTime: 5
        ),
        Resource(
            title: "Crisis Resources",
            category: .crisis,
            content: """
            If you're in crisis or experiencing thoughts of self-harm, immediate help is available.
            
            Emergency Contacts:
            
            National Suicide Prevention Lifeline: 988
            Crisis Text Line: Text HOME to 741741
            Emergency Services: 911
            
            When to Seek Emergency Care:
            
            Thoughts of harming yourself or others
            Severe panic that won't subside
            Complete inability to function
            Psychotic symptoms (hallucinations, delusions)
            
            Immediate Coping Strategies:
            
            Call a trusted friend or family member
            Use grounding techniques
            Go to a safe, calm environment
            Practice deep breathing
            
            Remember: DPDR itself is not dangerous, but if you're experiencing a mental health crisis, professional help is essential. There's no shame in reaching out.
            """,
            readTime: 3,
            isPremium: false
        ),
        Resource(
            title: "Sleep and DPDR",
            category: .copingStrategies,
            content: """
            Sleep quality has a profound impact on DPDR symptoms. Poor sleep is one of the most common triggers for episodes.
            
            Why Sleep Matters:
            
            Sleep deprivation increases dissociation. When you're tired, your brain struggles to process reality normally, making DPDR symptoms worse.
            
            REM sleep helps process emotions and consolidate memories. Disrupted REM sleep can intensify feelings of unreality.
            
            Sleep Hygiene Tips:
            
            Consistent Schedule: Go to bed and wake up at the same time every day, even weekends.
            
            Wind-Down Routine: Create a 30-minute pre-bed routine. Dim lights, avoid screens, practice gentle stretching or meditation.
            
            Environment: Keep your bedroom cool (65-68°F), dark, and quiet. Use blackout curtains if needed.
            
            Avoid Stimulants: No caffeine after 2 PM. Limit alcohol, which disrupts sleep quality.
            
            Exercise: Regular physical activity improves sleep, but avoid intense exercise within 3 hours of bedtime.
            
            If You Can't Sleep:
            
            Don't lie awake for more than 20 minutes. Get up and do a quiet activity until you feel sleepy.
            
            Avoid checking the time repeatedly. This increases anxiety about sleep.
            
            Practice the 4-7-8 breathing technique to calm your nervous system.
            
            When to Seek Help:
            
            If sleep problems persist for more than 2 weeks, consult a healthcare provider. Chronic insomnia requires professional treatment.
            """,
            readTime: 6,
            isPremium: false
        ),
        Resource(
            title: "DPDR and Anxiety",
            category: .understandingDPDR,
            content: """
            DPDR and anxiety are closely linked. Understanding this connection helps you manage both conditions more effectively.
            
            The Connection:
            
            DPDR often develops as a response to severe anxiety or panic. Your brain essentially "shuts down" emotional processing to protect you from overwhelming feelings.
            
            Many people with DPDR also have generalized anxiety disorder, panic disorder, or social anxiety.
            
            Anxiety can trigger DPDR episodes, and DPDR can cause anxiety about the symptoms themselves - creating a vicious cycle.
            
            Breaking the Cycle:
            
            Recognize the Pattern: Notice when anxiety precedes DPDR episodes. Keep a journal to identify triggers.
            
            Treat the Anxiety: Managing underlying anxiety often reduces DPDR symptoms. CBT, medication, and lifestyle changes all help.
            
            Don't Fear the Symptoms: DPDR feels scary but isn't dangerous. Accepting the sensations rather than fighting them reduces their intensity.
            
            Anxiety Management Techniques:
            
            Progressive Muscle Relaxation: Systematically tense and relax muscle groups to release physical tension.
            
            Cognitive Restructuring: Challenge anxious thoughts. Ask yourself: "Is this thought based on facts or feelings?"
            
            Exposure Therapy: Gradually face anxiety-provoking situations with professional guidance.
            
            Mindfulness: Practice observing anxious thoughts without judgment. They're just thoughts, not facts.
            
            Remember:
            
            Both DPDR and anxiety are treatable. With proper support and coping strategies, most people see significant improvement.
            """,
            readTime: 7,
            isPremium: false
        ),
        Resource(
            title: "Lifestyle Changes for DPDR",
            category: .copingStrategies,
            content: """
            While therapy and medication are important, lifestyle changes can significantly reduce DPDR symptoms.
            
            Exercise:
            
            Regular physical activity reduces dissociation by grounding you in your body. Aim for 30 minutes of moderate exercise most days.
            
            Best types: Yoga, walking, swimming, dancing - activities that require body awareness.
            
            Avoid: Excessive high-intensity exercise, which can trigger symptoms in some people.
            
            Nutrition:
            
            Eat regular, balanced meals. Blood sugar fluctuations can worsen DPDR.
            
            Stay hydrated. Dehydration affects brain function and can increase dissociation.
            
            Limit caffeine and sugar, which can trigger anxiety and DPDR episodes.
            
            Consider omega-3 supplements. Some research suggests they support brain health.
            
            Stress Management:
            
            Identify your stressors and develop coping strategies for each one.
            
            Practice saying "no" to commitments that overwhelm you.
            
            Build in regular breaks and downtime. Constant busyness worsens DPDR.
            
            Social Connection:
            
            Maintain relationships even when you don't feel like it. Isolation worsens symptoms.
            
            Explain DPDR to trusted friends and family. Their understanding and support matter.
            
            Join support groups (online or in-person) to connect with others who understand.
            
            Screen Time:
            
            Excessive screen time, especially social media, can worsen dissociation.
            
            Take regular breaks from screens. Use the 20-20-20 rule: every 20 minutes, look at something 20 feet away for 20 seconds.
            
            Avoid screens for at least 1 hour before bed.
            
            Substance Use:
            
            Avoid recreational drugs, which can trigger or worsen DPDR.
            
            Limit alcohol consumption. While it may seem to help initially, it worsens symptoms long-term.
            
            If you smoke, consider quitting. Nicotine affects anxiety and dissociation.
            
            Small Changes, Big Impact:
            
            You don't need to change everything at once. Pick one or two areas to focus on, and build from there.
            """,
            readTime: 8,
            isPremium: false
        ),
        Resource(
            title: "Explaining DPDR to Others",
            category: .community,
            content: """
            One of the hardest parts of DPDR is explaining it to people who've never experienced it. Here's how to help others understand.
            
            Why It's Difficult:
            
            DPDR is an invisible condition. You look "fine" on the outside, making it hard for others to grasp what you're experiencing.
            
            The sensations are difficult to describe. Words like "unreal" and "disconnected" don't fully capture the experience.
            
            Many people haven't heard of DPDR, so they may be confused or skeptical.
            
            How to Explain It:
            
            Use Analogies:
            
            "It's like watching my life through a foggy window - I can see what's happening, but I feel separated from it."
            
            "Imagine feeling like you're in a dream, but you're awake and it won't stop."
            
            "It's like my brain put up a protective wall between me and reality, and now I can't take it down."
            
            Be Specific About Symptoms:
            
            Instead of "I feel weird," try: "I feel disconnected from my body" or "The world looks flat and two-dimensional."
            
            Describe how it affects you: "I have trouble concentrating" or "I feel emotionally numb."
            
            What to Tell Them:
            
            It's a real medical condition, not "just anxiety" or "in your head."
            
            It's not dangerous or a sign of psychosis. You know the feelings aren't real.
            
            It's treatable with therapy, lifestyle changes, and sometimes medication.
            
            What You Need:
            
            Be clear about what helps: "I need you to be patient when I'm having an episode" or "It helps when you remind me this is temporary."
            
            Explain what doesn't help: "Telling me to 'snap out of it' makes it worse" or "I can't just 'think positive' and make it go away."
            
            Resources to Share:
            
            Send them articles or videos about DPDR from reputable sources.
            
            Suggest they read personal accounts from others with DPDR.
            
            If appropriate, invite them to a therapy session to learn more.
            
            Remember:
            
            Not everyone will understand, and that's okay. Focus on educating those closest to you who are willing to learn.
            
            You don't owe anyone a detailed explanation. "I have a medical condition that affects how I perceive reality" is enough for casual acquaintances.
            """,
            readTime: 7,
            isPremium: false
        )
    ]
}
