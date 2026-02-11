// App State
const state = {
    currentScreen: 'onboarding',
    onboardingStep: 0,
    userName: '',
    goals: [],
    currentTab: 'home',
    habits: [],
    sessions: [],
    resources: [],
    exerciseStep: 0,
    exerciseType: null,
    preMoodRating: null,
    postMoodRating: null,
    exerciseStartTime: null
};

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
    initializeData();
    const hasCompletedOnboarding = localStorage.getItem('hasCompletedOnboarding');
    
    if (hasCompletedOnboarding) {
        state.currentScreen = 'main';
        loadData();
        renderMainApp();
    } else {
        renderOnboarding();
    }
});

function initializeData() {
    state.resources = [
        {
            id: 1,
            title: 'What is DPDR?',
            category: 'Understanding DPDR',
            content: 'Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder...',
            readTime: 5
        },
        {
            id: 2,
            title: 'The 5-4-3-2-1 Technique',
            category: 'Coping Strategies',
            content: 'The 5-4-3-2-1 grounding technique is one of the most effective tools...',
            readTime: 4
        },
        {
            id: 3,
            title: 'Understanding Your Triggers',
            category: 'Coping Strategies',
            content: 'Identifying what triggers your DPDR episodes is crucial...',
            readTime: 6
        },
        {
            id: 4,
            title: 'When to Seek Professional Help',
            category: 'Treatment',
            content: 'While self-help strategies are valuable, professional treatment...',
            readTime: 7
        },
        {
            id: 5,
            title: "You're Not Alone",
            category: 'Community',
            content: 'Living with DPDR can feel isolating, but millions experience this...',
            readTime: 5
        },
        {
            id: 6,
            title: 'Crisis Resources',
            category: 'Crisis',
            content: 'If you are in crisis, immediate help is available...',
            readTime: 3
        },
        {
            id: 7,
            title: 'Sleep and DPDR',
            category: 'Coping Strategies',
            content: 'Sleep quality has a profound impact on DPDR symptoms...',
            readTime: 6
        },
        {
            id: 8,
            title: 'DPDR and Anxiety',
            category: 'Understanding DPDR',
            content: 'DPDR and anxiety are closely linked...',
            readTime: 7
        },
        {
            id: 9,
            title: 'Lifestyle Changes for DPDR',
            category: 'Coping Strategies',
            content: 'Lifestyle changes can significantly reduce DPDR symptoms...',
            readTime: 8
        },
        {
            id: 10,
            title: 'Explaining DPDR to Others',
            category: 'Community',
            content: 'One of the hardest parts is explaining DPDR to others...',
            readTime: 7
        }
    ];
}

function loadData() {
    const savedHabits = localStorage.getItem('habits');
    const savedSessions = localStorage.getItem('sessions');
    
    if (savedHabits) state.habits = JSON.parse(savedHabits);
    if (savedSessions) state.sessions = JSON.parse(savedSessions);
}

function saveData() {
    localStorage.setItem('habits', JSON.stringify(state.habits));
    localStorage.setItem('sessions', JSON.stringify(state.sessions));
}

// Onboarding
function renderOnboarding() {
    const app = document.getElementById('app');
    const steps = [
        renderWelcomeScreen,
        renderWhatIsDPDRScreen,
        renderHowGroundingWorksScreen,
        renderPersonalizationScreen,
        renderCompletionScreen
    ];
    
    app.innerHTML = '';
    steps[state.onboardingStep]();
}

function renderWelcomeScreen() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <div class="onboarding-screen">
            <div class="onboarding-content">
                <div class="onboarding-icon">🍃</div>
                <h1>Welcome to Grounded</h1>
                <p>Your companion for managing DPDR</p>
            </div>
            <button class="btn-primary" onclick="nextOnboardingStep()">Get Started</button>
            <div class="progress-dots">
                ${[0,1,2,3,4].map(i => `<div class="dot ${i === 0 ? 'active' : ''}"></div>`).join('')}
            </div>
        </div>
    `;
}

function renderWhatIsDPDRScreen() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <div class="onboarding-screen">
            <div class="onboarding-content">
                <h1>What is DPDR?</h1>
                <p>Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder characterized by:</p>
                <div class="info-row">
                    <div class="info-row-icon">👤</div>
                    <div>Feeling disconnected from yourself</div>
                </div>
                <div class="info-row">
                    <div class="info-row-icon">👁️</div>
                    <div>Perceiving the world as foggy or dreamlike</div>
                </div>
                <div class="info-row">
                    <div class="info-row-icon">🧠</div>
                    <div>Awareness that these perceptions are distorted</div>
                </div>
                <h2 style="margin-top: 30px;">You're not alone</h2>
                <p>Many people experience DPDR, and grounding techniques can help manage symptoms.</p>
            </div>
            <button class="btn-primary" onclick="nextOnboardingStep()">Continue</button>
            <div class="progress-dots">
                ${[0,1,2,3,4].map(i => `<div class="dot ${i === 1 ? 'active' : ''}"></div>`).join('')}
            </div>
        </div>
    `;
}

function renderHowGroundingWorksScreen() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <div class="onboarding-screen">
            <div class="onboarding-content">
                <div class="onboarding-icon">🌳</div>
                <h1>How Grounding Works</h1>
                <p>Grounding techniques engage your five senses to help you reconnect with the present moment.</p>
                <p style="margin-top: 20px;">Like roots anchoring a tree, these exercises help you feel stable and present.</p>
            </div>
            <button class="btn-primary" onclick="nextOnboardingStep()">Continue</button>
            <div class="progress-dots">
                ${[0,1,2,3,4].map(i => `<div class="dot ${i === 2 ? 'active' : ''}"></div>`).join('')}
            </div>
        </div>
    `;
}

function renderPersonalizationScreen() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <div class="onboarding-screen">
            <div class="onboarding-content">
                <h1>Personalize Your Experience</h1>
                <div class="input-group">
                    <label>What name would you like us to use?</label>
                    <input type="text" id="userName" placeholder="Name (optional)" value="${state.userName}">
                </div>
                <div class="input-group">
                    <label>What are your goals?</label>
                    <div class="checkbox-group">
                        ${['Manage episodes', 'Build habits', 'Learn more', 'Track progress'].map(goal => `
                            <label class="checkbox-item">
                                <input type="checkbox" value="${goal}" ${state.goals.includes(goal) ? 'checked' : ''}>
                                ${goal}
                            </label>
                        `).join('')}
                    </div>
                </div>
            </div>
            <button class="btn-primary" onclick="savePersonalization()">Continue</button>
            <div class="progress-dots">
                ${[0,1,2,3,4].map(i => `<div class="dot ${i === 3 ? 'active' : ''}"></div>`).join('')}
            </div>
        </div>
    `;
}

function savePersonalization() {
    state.userName = document.getElementById('userName').value;
    const checkboxes = document.querySelectorAll('.checkbox-item input:checked');
    state.goals = Array.from(checkboxes).map(cb => cb.value);
    nextOnboardingStep();
}

function renderCompletionScreen() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <div class="onboarding-screen">
            <div class="onboarding-content">
                <div class="onboarding-icon">✅</div>
                <h1>You're All Set!</h1>
                <p>Let's begin your journey to feeling more grounded.</p>
            </div>
            <button class="btn-primary" onclick="completeOnboarding()">Get Started</button>
            <div class="progress-dots">
                ${[0,1,2,3,4].map(i => `<div class="dot ${i === 4 ? 'active' : ''}"></div>`).join('')}
            </div>
        </div>
    `;
}

function nextOnboardingStep() {
    state.onboardingStep++;
    renderOnboarding();
}

function completeOnboarding() {
    localStorage.setItem('hasCompletedOnboarding', 'true');
    state.currentScreen = 'main';
    renderMainApp();
}

// Main App
function renderMainApp() {
    const app = document.getElementById('app');
    app.innerHTML = `
        <div class="main-app">
            <div class="nav-bar">
                <h2 id="navTitle">Grounded</h2>
            </div>
            <div class="content" id="content"></div>
            <div class="tab-bar">
                <button class="tab-item active" onclick="switchTab('home')">
                    <div class="tab-icon">🏠</div>
                    <div>Home</div>
                </button>
                <button class="tab-item" onclick="switchTab('habits')">
                    <div class="tab-icon">✓</div>
                    <div>Habits</div>
                </button>
                <button class="tab-item" onclick="switchTab('resources')">
                    <div class="tab-icon">📚</div>
                    <div>Resources</div>
                </button>
                <button class="tab-item" onclick="switchTab('insights')">
                    <div class="tab-icon">📊</div>
                    <div>Insights</div>
                </button>
                <button class="tab-item" onclick="switchTab('profile')">
                    <div class="tab-icon">👤</div>
                    <div>Profile</div>
                </button>
            </div>
        </div>
    `;
    renderHomeScreen();
}

function switchTab(tab) {
    state.currentTab = tab;
    document.querySelectorAll('.tab-item').forEach(item => item.classList.remove('active'));
    event.target.closest('.tab-item').classList.add('active');
    
    const screens = {
        home: renderHomeScreen,
        habits: renderHabitsScreen,
        resources: renderResourcesScreen,
        insights: renderInsightsScreen,
        profile: renderProfileScreen
    };
    
    screens[tab]();
}

// Home Screen
function renderHomeScreen() {
    document.getElementById('navTitle').textContent = 'Grounded';
    const todaySessions = state.sessions.filter(s => isToday(new Date(s.startTime))).length;
    const weekSessions = state.sessions.filter(s => isThisWeek(new Date(s.startTime))).length;
    
    document.getElementById('content').innerHTML = `
        <div class="greeting">
            <h3>Hello${state.userName ? ', ' + state.userName : ''}</h3>
            <h2>How are you feeling?</h2>
        </div>
        
        <button class="grounding-button" onclick="startGroundingExercise()">
            <span style="font-size: 24px;">🍃</span>
            <span>I need to ground</span>
        </button>
        
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">✓</div>
                <div class="stat-value">${todaySessions}</div>
                <div class="stat-label">Today</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-value">${weekSessions}</div>
                <div class="stat-label">This Week</div>
            </div>
        </div>
        
        <div class="section-title">Featured Resource</div>
        <div class="resource-card" onclick="viewResource(1)">
            <div class="resource-category">Getting Started</div>
            <div class="resource-title">Understanding DPDR</div>
            <div class="resource-meta">
                <span>🕐</span>
                <span>5 min read</span>
            </div>
        </div>
    `;
}

function isToday(date) {
    const today = new Date();
    return date.toDateString() === today.toDateString();
}

function isThisWeek(date) {
    const today = new Date();
    const weekAgo = new Date(today.getTime() - 7 * 24 * 60 * 60 * 1000);
    return date >= weekAgo && date <= today;
}

// Grounding Exercise
function startGroundingExercise() {
    showExerciseSelectionModal();
}

function showExerciseSelectionModal() {
    const modal = document.createElement('div');
    modal.className = 'modal active';
    modal.id = 'exerciseSelectionModal';
    modal.innerHTML = `
        <div class="modal-content">
            <div class="modal-header">
                <h2>Choose an Exercise</h2>
                <button class="close-button" onclick="closeExerciseSelectionModal()">×</button>
            </div>
            <div style="display: flex; flex-direction: column; gap: 15px; margin-top: 20px;">
                <button class="exercise-option" onclick="selectExercise('5-4-3-2-1')">
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <span style="font-size: 32px;">✋</span>
                        <div style="text-align: left;">
                            <div style="font-weight: 600; margin-bottom: 5px;">5-4-3-2-1 Technique</div>
                            <div style="font-size: 14px; color: var(--text-secondary);">Engage all five senses</div>
                            <div style="font-size: 12px; color: var(--accent-color);">5-7 min</div>
                        </div>
                    </div>
                </button>
                <button class="exercise-option" onclick="selectExercise('body-scan')">
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <span style="font-size: 32px;">🧘</span>
                        <div style="text-align: left;">
                            <div style="font-weight: 600; margin-bottom: 5px;">Body Scan</div>
                            <div style="font-size: 14px; color: var(--text-secondary);">Focus on body awareness</div>
                            <div style="font-size: 12px; color: var(--accent-color);">8-10 min</div>
                        </div>
                    </div>
                </button>
                <button class="exercise-option" onclick="selectExercise('breath-work')">
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <span style="font-size: 32px;">💨</span>
                        <div style="text-align: left;">
                            <div style="font-weight: 600; margin-bottom: 5px;">Breath Work</div>
                            <div style="font-size: 14px; color: var(--text-secondary);">Guided breathing patterns</div>
                            <div style="font-size: 12px; color: var(--accent-color);">3-5 min</div>
                        </div>
                    </div>
                </button>
                <button class="exercise-option" onclick="selectExercise('sensory')">
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <span style="font-size: 32px;">👁️</span>
                        <div style="text-align: left;">
                            <div style="font-weight: 600; margin-bottom: 5px;">Sensory Grounding</div>
                            <div style="font-size: 14px; color: var(--text-secondary);">Deep sensory focus</div>
                            <div style="font-size: 12px; color: var(--accent-color);">5-8 min</div>
                        </div>
                    </div>
                </button>
            </div>
        </div>
    `;
    document.body.appendChild(modal);
}

function closeExerciseSelectionModal() {
    const modal = document.getElementById('exerciseSelectionModal');
    if (modal) modal.remove();
}

function selectExercise(type) {
    closeExerciseSelectionModal();
    state.exerciseType = type;
    state.exerciseStep = 0;
    state.preMoodRating = null;
    state.postMoodRating = null;
    state.exerciseStartTime = new Date();
    showExerciseModal();
}

function showExerciseModal() {
    const modal = document.createElement('div');
    modal.className = 'modal active';
    modal.id = 'exerciseModal';
    modal.innerHTML = `<div class="modal-content" id="exerciseContent"></div>`;
    document.body.appendChild(modal);
    
    if (!state.preMoodRating) {
        renderPreMoodRating();
    } else {
        renderExerciseStep();
    }
}

function renderPreMoodRating() {
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <h2>Before we begin</h2>
            <p>How are you feeling right now?</p>
            <div class="mood-rating">
                ${[1,2,3,4,5].map(rating => `
                    <button class="mood-button" onclick="setPreMood(${rating})">${rating}</button>
                `).join('')}
            </div>
            <p style="font-size: 12px; color: var(--text-secondary);">1 = Very Disconnected, 5 = Grounded</p>
            <button class="btn-secondary" onclick="closeExerciseModal()">Cancel</button>
        </div>
    `;
}

function setPreMood(rating) {
    state.preMoodRating = rating;
    renderExerciseStep();
}

function renderExerciseStep() {
    if (state.exerciseType === '5-4-3-2-1') {
        render543210Exercise();
    } else if (state.exerciseType === 'body-scan') {
        renderBodyScanExercise();
    } else if (state.exerciseType === 'breath-work') {
        renderBreathWorkExercise();
    } else if (state.exerciseType === 'sensory') {
        renderSensoryExercise();
    }
}

function render543210Exercise() {
    const steps = [
        { count: 5, sense: 'See', prompt: 'Name 5 things you can see around you', icon: '👁️' },
        { count: 4, sense: 'Touch', prompt: 'Name 4 things you can touch', icon: '✋' },
        { count: 3, sense: 'Hear', prompt: 'Name 3 things you can hear', icon: '👂' },
        { count: 2, sense: 'Smell', prompt: 'Name 2 things you can smell', icon: '👃' },
        { count: 1, sense: 'Taste', prompt: 'Name 1 thing you can taste', icon: '👅' }
    ];
    
    if (state.exerciseStep >= steps.length) {
        renderPostMoodRating();
        return;
    }
    
    const step = steps[state.exerciseStep];
    
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <div class="exercise-progress">
                ${steps.map((_, i) => `<div class="progress-circle ${i <= state.exerciseStep ? 'active' : ''}"></div>`).join('')}
            </div>
            <div class="exercise-icon">${step.icon}</div>
            <div class="exercise-count">${step.count}</div>
            <div class="exercise-sense">${step.sense}</div>
            <div class="exercise-prompt">${step.prompt}</div>
            <button class="btn-primary" onclick="nextExerciseStep()">
                ${state.exerciseStep < steps.length - 1 ? 'Next' : 'Complete'}
            </button>
            <button class="btn-secondary" onclick="closeExerciseModal()">Exit</button>
        </div>
    `;
}

function renderBodyScanExercise() {
    const bodyParts = [
        { name: 'Feet', instruction: 'Notice your feet on the ground', icon: '👣' },
        { name: 'Legs', instruction: 'Bring awareness to your legs', icon: '🦵' },
        { name: 'Stomach', instruction: 'Notice your stomach rising and falling', icon: '🫁' },
        { name: 'Chest', instruction: 'Feel your chest expanding', icon: '❤️' },
        { name: 'Arms', instruction: 'Notice your arms and hands', icon: '💪' },
        { name: 'Shoulders', instruction: 'Release tension in your shoulders', icon: '🤷' },
        { name: 'Face', instruction: 'Soften your jaw and forehead', icon: '😌' }
    ];
    
    if (state.exerciseStep >= bodyParts.length) {
        renderPostMoodRating();
        return;
    }
    
    const part = bodyParts[state.exerciseStep];
    
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <div style="display: flex; gap: 4px; margin-bottom: 40px;">
                ${bodyParts.map((_, i) => `<div style="flex: 1; height: 4px; background: ${i <= state.exerciseStep ? 'var(--accent-color)' : '#ddd'}; border-radius: 2px;"></div>`).join('')}
            </div>
            <div style="font-size: 80px; margin-bottom: 20px;">${part.icon}</div>
            <div style="font-size: 32px; font-weight: bold; margin-bottom: 20px;">${part.name}</div>
            <div style="font-size: 18px; color: var(--text-secondary); margin-bottom: 60px; max-width: 300px; text-align: center;">${part.instruction}</div>
            <button class="btn-primary" onclick="nextExerciseStep()">
                ${state.exerciseStep < bodyParts.length - 1 ? 'Next' : 'Complete'}
            </button>
            <button class="btn-secondary" onclick="closeExerciseModal()">Exit</button>
        </div>
    `;
}

function renderBreathWorkExercise() {
    const phases = ['Breathe In', 'Hold', 'Breathe Out', 'Rest'];
    const totalCycles = 5;
    const currentCycle = Math.floor(state.exerciseStep / 4);
    const currentPhase = state.exerciseStep % 4;
    
    if (currentCycle >= totalCycles) {
        renderPostMoodRating();
        return;
    }
    
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <div style="font-size: 16px; color: var(--text-secondary); margin-bottom: 40px;">Cycle ${currentCycle + 1} of ${totalCycles}</div>
            <div style="width: 200px; height: 200px; border-radius: 50%; background: linear-gradient(135deg, var(--primary-color), rgba(139, 168, 136, 0.6)); display: flex; align-items: center; justify-content: center; margin-bottom: 40px; animation: breathe ${currentPhase === 0 ? '4s' : currentPhase === 2 ? '8s' : '0s'} ease-in-out;">
                <div style="color: white; text-align: center;">
                    <div style="font-size: 40px; margin-bottom: 10px;">${currentPhase === 0 ? '↑' : currentPhase === 2 ? '↓' : '⏸'}</div>
                    <div style="font-size: 24px; font-weight: 600;">${phases[currentPhase]}</div>
                </div>
            </div>
            <div style="font-size: 16px; color: var(--text-secondary); margin-bottom: 60px; max-width: 300px; text-align: center;">
                ${currentPhase === 0 ? 'Breathe in slowly through your nose' : 
                  currentPhase === 1 ? 'Hold your breath gently' :
                  currentPhase === 2 ? 'Breathe out slowly through your mouth' :
                  'Pause before the next breath'}
            </div>
            <button class="btn-primary" onclick="nextExerciseStep()">Next</button>
            <button class="btn-secondary" onclick="skipBreathWork()">Skip to End</button>
        </div>
    `;
    
    // Auto-advance after delay
    setTimeout(() => {
        if (document.getElementById('exerciseModal')) {
            nextExerciseStep();
        }
    }, currentPhase === 0 ? 4000 : currentPhase === 1 ? 7000 : currentPhase === 2 ? 8000 : 1000);
}

function skipBreathWork() {
    state.exerciseStep = 20; // Skip to end
    renderPostMoodRating();
}

function renderSensoryExercise() {
    const senses = [
        { name: 'Sight', prompt: 'Describe something you see in detail', icon: '👁️' },
        { name: 'Touch', prompt: 'Describe how something feels', icon: '✋' },
        { name: 'Hearing', prompt: 'Describe sounds you hear', icon: '👂' },
        { name: 'Smell', prompt: 'Describe a scent', icon: '👃' },
        { name: 'Taste', prompt: 'Describe a taste', icon: '👅' }
    ];
    
    if (state.exerciseStep >= senses.length) {
        renderPostMoodRating();
        return;
    }
    
    const sense = senses[state.exerciseStep];
    
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <div class="exercise-progress">
                ${senses.map((_, i) => `<div class="progress-circle ${i <= state.exerciseStep ? 'active' : ''}"></div>`).join('')}
            </div>
            <div style="font-size: 80px; margin-bottom: 20px;">${sense.icon}</div>
            <div style="font-size: 32px; font-weight: bold; margin-bottom: 20px;">${sense.name}</div>
            <div style="font-size: 18px; color: var(--text-secondary); margin-bottom: 30px; max-width: 300px; text-align: center;">${sense.prompt}</div>
            <textarea style="width: 100%; max-width: 300px; height: 100px; padding: 12px; border: 2px solid var(--card-background); border-radius: 12px; font-size: 16px; margin-bottom: 30px;" placeholder="Describe what you notice..."></textarea>
            <button class="btn-primary" onclick="nextExerciseStep()">
                ${state.exerciseStep < senses.length - 1 ? 'Next Sense' : 'Complete'}
            </button>
            <button class="btn-secondary" onclick="closeExerciseModal()">Exit</button>
        </div>
    `;
}

function nextExerciseStep() {
    state.exerciseStep++;
    renderExerciseStep();
}

function renderPostMoodRating() {
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <div style="font-size: 60px; margin-bottom: 20px;">✅</div>
            <h2>Exercise Complete</h2>
            <p>How are you feeling now?</p>
            <div class="mood-rating">
                ${[1,2,3,4,5].map(rating => `
                    <button class="mood-button" onclick="setPostMood(${rating})">${rating}</button>
                `).join('')}
            </div>
            <p style="font-size: 12px; color: var(--text-secondary);">1 = Very Disconnected, 5 = Grounded</p>
        </div>
    `;
}

function setPostMood(rating) {
    state.postMoodRating = rating;
    saveSession();
    renderCompletionMessage();
}

function saveSession() {
    const session = {
        id: Date.now(),
        exerciseType: state.exerciseType,
        startTime: state.exerciseStartTime,
        endTime: new Date(),
        preMoodRating: state.preMoodRating,
        postMoodRating: state.postMoodRating
    };
    state.sessions.push(session);
    saveData();
}

function renderCompletionMessage() {
    const improvement = state.postMoodRating - state.preMoodRating;
    document.getElementById('exerciseContent').innerHTML = `
        <div class="exercise-screen">
            <div style="font-size: 60px; margin-bottom: 20px;">✨</div>
            <h2>Well Done!</h2>
            ${improvement > 0 ? `<p style="color: var(--primary-color); font-weight: 600;">Your mood improved by ${improvement} point${improvement > 1 ? 's' : ''}!</p>` : ''}
            <p>Remember to take care of yourself</p>
            <button class="btn-primary" onclick="closeExerciseModal(); renderHomeScreen()">Done</button>
        </div>
    `;
}

function closeExerciseModal() {
    const modal = document.getElementById('exerciseModal');
    if (modal) modal.remove();
}

// Habits Screen
function renderHabitsScreen() {
    document.getElementById('navTitle').textContent = 'Habits';
    
    if (state.habits.length === 0) {
        document.getElementById('content').innerHTML = `
            <div class="empty-state">
                <div class="empty-icon">✓</div>
                <h3>No Habits Yet</h3>
                <p>Start building healthy routines to manage DPDR</p>
                <button class="btn-primary" onclick="showAddHabitModal()">Add Your First Habit</button>
            </div>
        `;
    } else {
        const habitsHTML = state.habits.map(habit => {
            const isCompleted = habit.completions?.some(c => isToday(new Date(c.date)) && c.completed);
            const streak = calculateStreak(habit);
            
            return `
                <div class="habit-card">
                    <div class="habit-checkbox ${isCompleted ? 'checked' : ''}" onclick="toggleHabit(${habit.id})">
                        ${isCompleted ? '✓' : ''}
                    </div>
                    <div class="habit-info">
                        <div class="habit-name">${habit.name}</div>
                        ${streak > 0 ? `
                            <div class="habit-streak">
                                <span>🔥</span>
                                <span>${streak} day streak</span>
                            </div>
                        ` : ''}
                    </div>
                    <div style="font-size: 24px;">${habit.icon}</div>
                </div>
            `;
        }).join('');
        
        document.getElementById('content').innerHTML = `
            <div class="habit-list">${habitsHTML}</div>
            <button class="btn-primary" onclick="showAddHabitModal()" style="margin-top: 20px;">Add Habit</button>
        `;
    }
}

function calculateStreak(habit) {
    if (!habit.completions) return 0;
    let streak = 0;
    let date = new Date();
    
    while (true) {
        const completed = habit.completions.find(c => {
            const cDate = new Date(c.date);
            return cDate.toDateString() === date.toDateString() && c.completed;
        });
        
        if (completed) {
            streak++;
            date.setDate(date.getDate() - 1);
        } else {
            break;
        }
    }
    
    return streak;
}

function toggleHabit(habitId) {
    const habit = state.habits.find(h => h.id === habitId);
    if (!habit) return;
    
    if (!habit.completions) habit.completions = [];
    
    const today = new Date().toDateString();
    const existingCompletion = habit.completions.find(c => new Date(c.date).toDateString() === today);
    
    if (existingCompletion) {
        existingCompletion.completed = !existingCompletion.completed;
    } else {
        habit.completions.push({ date: new Date(), completed: true });
    }
    
    saveData();
    renderHabitsScreen();
}

function showAddHabitModal() {
    const modal = document.createElement('div');
    modal.className = 'modal active';
    modal.id = 'habitModal';
    modal.innerHTML = `
        <div class="modal-content">
            <div class="modal-header">
                <h2>New Habit</h2>
                <button class="close-button" onclick="closeHabitModal()">×</button>
            </div>
            <div class="input-group">
                <label>Habit Name</label>
                <input type="text" id="habitName" placeholder="e.g., Drink Water">
            </div>
            <div class="input-group">
                <label>Icon</label>
                <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                    ${['💧', '🏃', '🧘', '📝', '💊', '🌙', '🥗', '📱'].map(icon => `
                        <button class="mood-button" onclick="selectHabitIcon('${icon}')" style="width: 60px; height: 60px; font-size: 24px;">${icon}</button>
                    `).join('')}
                </div>
            </div>
            <div class="section-title">Templates</div>
            ${['Drink Water', 'Exercise', 'Meditate', 'Journal', 'Sleep 8+ Hours'].map(template => `
                <button class="btn-secondary" onclick="useTemplate('${template}')" style="width: 100%; margin-bottom: 10px;">${template}</button>
            `).join('')}
            <button class="btn-primary" onclick="addHabit()">Add Habit</button>
        </div>
    `;
    document.body.appendChild(modal);
    window.selectedHabitIcon = '💧';
}

function selectHabitIcon(icon) {
    window.selectedHabitIcon = icon;
}

function useTemplate(template) {
    document.getElementById('habitName').value = template;
}

function addHabit() {
    const name = document.getElementById('habitName').value;
    if (!name) return alert('Please enter a habit name');
    
    const habit = {
        id: Date.now(),
        name: name,
        icon: window.selectedHabitIcon || '💧',
        completions: []
    };
    
    state.habits.push(habit);
    saveData();
    closeHabitModal();
    renderHabitsScreen();
}

function closeHabitModal() {
    const modal = document.getElementById('habitModal');
    if (modal) modal.remove();
}

// Resources Screen
function renderResourcesScreen() {
    document.getElementById('navTitle').textContent = 'Resources';
    
    const resourcesHTML = state.resources.map(resource => `
        <div class="resource-card" onclick="viewResource(${resource.id})">
            <div class="resource-category">${resource.category}</div>
            <div class="resource-title">${resource.title}</div>
            <div class="resource-meta">
                <span>🕐</span>
                <span>${resource.readTime} min read</span>
            </div>
        </div>
    `).join('');
    
    document.getElementById('content').innerHTML = `
        <div class="search-bar">
            <span>🔍</span>
            <input type="text" placeholder="Search resources">
        </div>
        <div class="category-chips">
            <button class="category-chip active">All</button>
            <button class="category-chip">Understanding DPDR</button>
            <button class="category-chip">Coping Strategies</button>
        </div>
        <div class="resource-list">${resourcesHTML}</div>
    `;
}

function viewResource(id) {
    const resource = state.resources.find(r => r.id === id);
    if (!resource) return;
    
    const modal = document.createElement('div');
    modal.className = 'modal active';
    modal.id = 'resourceModal';
    modal.innerHTML = `
        <div class="modal-content">
            <div class="modal-header">
                <h2>${resource.title}</h2>
                <button class="close-button" onclick="closeResourceModal()">×</button>
            </div>
            <div class="resource-category">${resource.category}</div>
            <div class="resource-meta" style="margin-bottom: 20px;">
                <span>🕐</span>
                <span>${resource.readTime} min read</span>
            </div>
            <p>${resource.content}</p>
        </div>
    `;
    document.body.appendChild(modal);
}

function closeResourceModal() {
    const modal = document.getElementById('resourceModal');
    if (modal) modal.remove();
}

// Insights Screen
function renderInsightsScreen() {
    document.getElementById('navTitle').textContent = 'Insights';
    
    const avgImprovement = calculateAverageMoodImprovement();
    const completionRate = calculateHabitCompletionRate();
    
    document.getElementById('content').innerHTML = `
        <div class="insight-card">
            <h3>Grounding Sessions</h3>
            <div class="chart-placeholder">
                <div style="text-align: center;">
                    <div style="font-size: 48px; font-weight: bold; color: var(--accent-color);">${state.sessions.length}</div>
                    <div style="color: var(--text-secondary);">Total Sessions</div>
                </div>
            </div>
        </div>
        
        <div class="insight-card">
            <h3>Mood Improvement</h3>
            ${avgImprovement !== null ? `
                <div class="improvement-stat">
                    <div class="improvement-icon">↑</div>
                    <div>
                        <div class="improvement-value">+${avgImprovement.toFixed(1)}</div>
                        <div class="improvement-label">Average improvement</div>
                    </div>
                </div>
            ` : '<div class="chart-placeholder">Complete sessions to see insights</div>'}
        </div>
        
        <div class="insight-card">
            <h3>Habit Completion</h3>
            ${state.habits.length > 0 ? `
                <div style="display: flex; flex-direction: column; gap: 10px;">
                    ${state.habits.map(habit => `
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span>${habit.name}</span>
                            <span style="font-weight: 600; color: var(--accent-color);">${completionRate}%</span>
                        </div>
                    `).join('')}
                </div>
            ` : '<div class="chart-placeholder">No habits tracked yet</div>'}
        </div>
    `;
}

function calculateAverageMoodImprovement() {
    const improvements = state.sessions
        .filter(s => s.preMoodRating && s.postMoodRating)
        .map(s => s.postMoodRating - s.preMoodRating);
    
    if (improvements.length === 0) return null;
    return improvements.reduce((a, b) => a + b, 0) / improvements.length;
}

function calculateHabitCompletionRate() {
    if (state.habits.length === 0) return 0;
    
    const last7Days = Array.from({length: 7}, (_, i) => {
        const d = new Date();
        d.setDate(d.getDate() - i);
        return d.toDateString();
    });
    
    let totalPossible = state.habits.length * 7;
    let totalCompleted = 0;
    
    state.habits.forEach(habit => {
        if (!habit.completions) return;
        totalCompleted += habit.completions.filter(c => 
            last7Days.includes(new Date(c.date).toDateString()) && c.completed
        ).length;
    });
    
    return Math.round((totalCompleted / totalPossible) * 100);
}

// Profile Screen
function renderProfileScreen() {
    document.getElementById('navTitle').textContent = 'Profile';
    
    document.getElementById('content').innerHTML = `
        <div class="profile-header">
            <div class="profile-avatar">👤</div>
            <div class="profile-info">
                <h3>${state.userName || 'User'}</h3>
                <p>Free Plan</p>
            </div>
        </div>
        
        <div class="section-title">Settings</div>
        <div class="settings-list">
            <div class="settings-item">
                <span class="settings-icon">🔔</span>
                <span>Notifications</span>
            </div>
            <div class="settings-item">
                <span class="settings-icon">🔒</span>
                <span>Privacy</span>
            </div>
            <div class="settings-item">
                <span class="settings-icon">📤</span>
                <span>Export Data</span>
            </div>
        </div>
        
        <div class="section-title">Support</div>
        <div class="settings-list">
            <div class="settings-item">
                <span class="settings-icon">❓</span>
                <span>Help Center</span>
            </div>
            <div class="settings-item">
                <span class="settings-icon">✉️</span>
                <span>Contact Support</span>
            </div>
            <div class="settings-item">
                <span class="settings-icon">ℹ️</span>
                <span>About</span>
            </div>
        </div>
        
        <button class="btn-secondary" onclick="resetApp()" style="width: 100%; margin-top: 30px; color: red;">Reset Demo</button>
    `;
}

function resetApp() {
    if (confirm('This will reset all demo data. Continue?')) {
        localStorage.clear();
        location.reload();
    }
}
