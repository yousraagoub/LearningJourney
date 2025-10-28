//
//  LearningJourneyApp.swift
//  LearningJourney
//

import SwiftUI

@main
struct LearningJourneyApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @StateObject private var onboardingVM = OnboardingViewModel()
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                // ✅ Normal flow
                ActivityView(onboardingVM: onboardingVM)
            } else {
                // ✅ First-launch onboarding
                OnboardingView(onboardingVM: onboardingVM) { learner in
                    hasCompletedOnboarding = true
                }
            }
        }
    }
}

