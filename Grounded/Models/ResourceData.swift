import Foundation

struct ResourceData {
    static let allResources: [Resource] = [
        // Existing 10 articles
        Resource(
            title: "What is DPDR?",
            category: .understandingDPDR,
            content: "Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder...",
            readTime: 5
        ),
        Resource(
            title: "The 5-4-3-2-1 Technique",
            category: .copingStrategies,
            content: "The 5-4-3-2-1 grounding technique...",
            readTime: 4
        ),
        Resource(
            title: "Understanding Your Triggers",
            category: .copingStrategies,
            content: "Identifying what triggers your DPDR episodes...",
            readTime: 6
        ),
        Resource(
            title: "When to Seek Professional Help",
            category: .treatment,
            content: "While self-help strategies are valuable...",
            readTime: 7
        ),
        Resource(
            title: "You're Not Alone",
            category: .community,
            content: "Living with DPDR can feel isolating...",
            readTime: 5
        ),
        Resource(
            title: "Crisis Resources",
            category: .crisis,
            content: "If you're in crisis...",
            readTime: 3
        ),
        Resource(
            title: "Sleep and DPDR",
            category: .copingStrategies,
            content: "Sleep quality has a profound impact...",
            readTime: 6
        ),
        Resource(
            title: "DPDR and Anxiety",
            category: .understandingDPDR,
            content: "DPDR and anxiety are closely linked...",
            readTime: 7
        ),
        Resource(
            title: "Lifestyle Changes for DPDR",
            category: .copingStrategies,
            content: "Lifestyle changes can significantly reduce...",
            readTime: 8
        ),
        Resource(
            title: "Explaining DPDR to Others",
            category: .community,
            content: "One of the hardest parts...",
            readTime: 7
        ),
        
        // Additional 20+ articles for Phase 2
        Resource(
            title: "Mindfulness for DPDR",
            category: .copingStrategies,
            content: "Mindfulness meditation can help manage DPDR symptoms by anchoring you in the present moment...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "Nutrition and Mental Health",
            category: .copingStrategies,
            content: "What you eat affects your brain chemistry and can impact DPDR symptoms...",
            readTime: 5,
            isPremium: true
        ),
        Resource(
            title: "Exercise as Medicine",
            category: .copingStrategies,
            content: "Regular physical activity is one of the most effective treatments for DPDR...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "Cognitive Behavioral Therapy for DPDR",
            category: .treatment,
            content: "CBT is the gold standard treatment for DPDR, helping you identify and change thought patterns...",
            readTime: 8,
            isPremium: true
        ),
        Resource(
            title: "Medication Options",
            category: .treatment,
            content: "While no medication specifically treats DPDR, certain medications can help with co-occurring conditions...",
            readTime: 7,
            isPremium: true
        ),
        Resource(
            title: "EMDR Therapy",
            category: .treatment,
            content: "Eye Movement Desensitization and Reprocessing can be effective for trauma-related DPDR...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "The Role of Trauma",
            category: .understandingDPDR,
            content: "Many people with DPDR have experienced trauma. Understanding this connection is crucial...",
            readTime: 7,
            isPremium: true
        ),
        Resource(
            title: "DPDR vs Other Conditions",
            category: .understandingDPDR,
            content: "DPDR can be confused with anxiety, depression, or psychosis. Here's how to tell the difference...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "The Neuroscience of DPDR",
            category: .understandingDPDR,
            content: "Research shows DPDR involves specific brain regions and neurotransmitters...",
            readTime: 8,
            isPremium: true
        ),
        Resource(
            title: "Recovery Stories",
            category: .community,
            content: "Real stories from people who have successfully managed or recovered from DPDR...",
            readTime: 10,
            isPremium: true
        ),
        Resource(
            title: "Supporting a Loved One with DPDR",
            category: .community,
            content: "If someone you care about has DPDR, here's how you can help...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "DPDR in Relationships",
            category: .community,
            content: "How DPDR affects romantic relationships and strategies for maintaining connection...",
            readTime: 7,
            isPremium: true
        ),
        Resource(
            title: "Work and DPDR",
            category: .copingStrategies,
            content: "Managing DPDR symptoms in the workplace and knowing your rights...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "Social Media and DPDR",
            category: .copingStrategies,
            content: "How social media can trigger or worsen DPDR, and strategies for healthy use...",
            readTime: 5,
            isPremium: true
        ),
        Resource(
            title: "Substance Use and DPDR",
            category: .understandingDPDR,
            content: "The complex relationship between substance use and dissociation...",
            readTime: 7,
            isPremium: true
        ),
        Resource(
            title: "Panic Attacks and DPDR",
            category: .understandingDPDR,
            content: "Understanding the connection between panic disorder and depersonalization...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "Seasonal Patterns",
            category: .copingStrategies,
            content: "How seasons and weather can affect DPDR symptoms...",
            readTime: 5,
            isPremium: true
        ),
        Resource(
            title: "Progressive Muscle Relaxation",
            category: .copingStrategies,
            content: "A step-by-step guide to this powerful relaxation technique...",
            readTime: 5,
            isPremium: true
        ),
        Resource(
            title: "Journaling for DPDR",
            category: .copingStrategies,
            content: "How to use journaling to track patterns and process emotions...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "Building a Support Network",
            category: .community,
            content: "Creating a circle of support for your mental health journey...",
            readTime: 6,
            isPremium: true
        ),
        Resource(
            title: "Long-term Management",
            category: .treatment,
            content: "Strategies for managing DPDR over the long term and preventing relapse...",
            readTime: 8,
            isPremium: true
        ),
        Resource(
            title: "Self-Compassion Practice",
            category: .copingStrategies,
            content: "Learning to be kind to yourself during difficult moments...",
            readTime: 5,
            isPremium: true
        ),
        Resource(
            title: "When DPDR Becomes Chronic",
            category: .understandingDPDR,
            content: "Understanding and coping with persistent DPDR symptoms...",
            readTime: 7,
            isPremium: true
        ),
        Resource(
            title: "Hope and Recovery",
            category: .community,
            content: "Why there is hope for recovery and what the research shows...",
            readTime: 6,
            isPremium: true
        )
    ]
}
