//
//  ActivityViewModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 01/05/1447 AH.
//
//

import Foundation
internal import Combine
import SwiftUI

//🟥
@MainActor
class ActivityViewModel: ObservableObject {
    @ObservedObject var onboardingVM: OnboardingViewModel
    //🟥
    @Published var lastLoggedDate: Date?
    @Published var isLogButtonDisabled = false
    @Published var isFreezeButtonDisabled = false
    
    @Published var didUseFreezeToday = false
    @Published var isOutOfFreeze = false
    
    //🟥 Timer to re-enable buttons at midnight
    private var midnightTimer: Timer?
    // MARK: - Initializer (✅ Required)
    init(onboardingVM: OnboardingViewModel) {
        self.onboardingVM = onboardingVM
        setupFreezeLimit()
        setupMidnightReset()
        updateButtonStates()
    }
    //🟥
    //    if onboardingVM.createdLearner {
    //        setupFreezeLimit()
    //        setupMidnightReset()
    //        updateButtonStates()
//    //    }
//    init() {
//
//    }
//    
//    
        private func setupFreezeLimit() {
                 switch onboardingVM.learnerM.duration {
                 case .week: onboardingVM.learnerM.freezeLimit = 2
                 case .month: onboardingVM.learnerM.freezeLimit = 8
                 case .year: onboardingVM.learnerM.freezeLimit = 96
                 }
             }
        //🟥  MARK: - Logging Learning
        func logAsLearned() {
            guard !isLogButtonDisabled else { return }
            onboardingVM.learnerM.streak += 1
            lastLoggedDate = Date()
            disableButtonsUntilMidnight()
        }
        
        //🟥 MARK: - Using a Freeze
        
        func useFreeze() {
            guard !isFreezeButtonDisabled else { return }
            guard onboardingVM.learnerM.freezeCount < onboardingVM.learnerM.freezeLimit else {
                isOutOfFreeze = true
                return
            }
            
            onboardingVM.learnerM.freezeCount += 1
            lastLoggedDate = Date()
            didUseFreezeToday = true   // ✅ Track that freeze was used today
            disableButtonsUntilMidnight()
        }
        
        //🟥 MARK: - Resetting and Conditions
        
        func checkStreakResetCondition() {
            // If more than 32 hours passed since last log or freeze
            guard let last = lastLoggedDate else { return }
            let hoursPassed = Date().timeIntervalSince(last) / 3600
            
            if hoursPassed > 32 {
                onboardingVM.learnerM.streak = 0
            }
        }
        
        //🟥
        func resetForNewGoal(learnerM: LearnerModel) {
            onboardingVM.learnerM = learnerM
            onboardingVM.createdLearner = true
            onboardingVM.learnerM.streak = 0
            onboardingVM.learnerM.freezeCount = 0
            lastLoggedDate = nil
            updateButtonStates()
        }

        
        //🟥 MARK: - Helpers for Button States
        
        private func updateButtonStates() {
            isFreezeButtonDisabled = onboardingVM.learnerM.freezeCount >= onboardingVM.learnerM.freezeLimit
            isOutOfFreeze = onboardingVM.learnerM.freezeCount >= onboardingVM.learnerM.freezeLimit
            isLogButtonDisabled = false
        }
        //🟥
        private func disableButtonsUntilMidnight() {
            isLogButtonDisabled = true
            isFreezeButtonDisabled = true
        }
        
        //🟥 MARK: - Midnight Reset
        private func setupMidnightReset() {
            let calendar = Calendar.current
            let now = Date()
            if let nextMidnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTime) {
                let interval = nextMidnight.timeIntervalSinceNow
                midnightTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
                    self?.enableButtonsAtMidnight()
                }
            }
        }
        //🟥
        private func enableButtonsAtMidnight() {
            isLogButtonDisabled = false
            isFreezeButtonDisabled = onboardingVM.learnerM.freezeCount >= onboardingVM.learnerM.freezeLimit
            didUseFreezeToday = false // ✅ reset text and colors for the new day
            setupMidnightReset() // schedule again for next day
        }
        //🟥
        deinit {
            midnightTimer?.invalidate()
        }
        
        
        
        
    
    
}//class
