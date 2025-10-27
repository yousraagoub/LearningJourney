//
//  LearningJourneyApp.swift
//  LearningJourney
//

import SwiftUI

@main
struct LearningJourneyApp: App {
    @AppStorage("hasOnboarded") var hasOnboarded = false
    @StateObject var onboardingVM = OnboardingViewModel() // shared instance

    var body: some Scene {
        WindowGroup {
            if hasOnboarded {
                // Launch directly to ActivityView on re-launch
                ActivityView(onboardingVM: onboardingVM)
            } else {
                // First launch: show onboarding
                OnboardingView(onboardingVM: onboardingVM, isEditing: false) { learner in
                    // Update the learner in the view model
                    onboardingVM.learnerM = learner
                    onboardingVM.createdLearner = true
                    // Mark onboarding as completed
                    hasOnboarded = true
                }
            }
        }
    }
}
