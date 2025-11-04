import SwiftUI

@main
struct LearningJourneyApp: App {
    @StateObject private var onboardingVM = OnboardingViewModel()
    var body: some Scene {
        WindowGroup {
            if onboardingVM.createdLearner {
                ActivityView(onboardingVM: onboardingVM)
            } else {
                OnboardingView(onboardingVM: onboardingVM)
            }
        }
    }
}


