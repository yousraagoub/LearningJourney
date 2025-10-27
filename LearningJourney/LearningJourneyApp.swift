//
//  LearningJourneyApp.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 29/04/1447 AH.
//

import SwiftUI

@main
struct LearningJourneyApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    init() {
        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
 
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasCompletedOnboarding {
                    ActivityView(
                        learnerM: LearnerModel(
                            subject: "Swift",
                            duration: .month,
                            startDate: Date(),
                            streak: 3,
                            freezeCount: 1,
                            freezeLimit: 8
                        )
                    )
                } else {
                    // Pass closure to mark onboarding as complete
                    OnboardingView {
                        hasCompletedOnboarding = true
                    }
                }
            }
        }
    }
}
