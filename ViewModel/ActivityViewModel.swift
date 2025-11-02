// Combine is Apple’s reactive framework used for: @Published properties, ObservableObject, @StateObject, @ObservedObject, sink and assign for reactive bindings.
import Combine
//Foundation framework adds the everyday tools apps need — dates, files, data, etc.
import Foundation
//SwiftUI UI framework
import SwiftUI

//@MainActor means run this code on the main thread. It should be @MainActor if the file is ObservableObject.
@MainActor
class ActivityViewModel: ObservableObject {
    @ObservedObject var onboardingVM: OnboardingViewModel
    //🟥
    @Published var isLogButtonDisabled = false
    @Published var isFreezeButtonDisabled = false
    @Published var didUseFreezeToday = false
    @Published var isOutOfFreeze = false
    //🟥
    @Published var calendarVM: CalendarViewModel
    
    //Timer to re-enable buttons at midnight.
    private var midnightTimer: Timer?
    
    // MARK: - Initializer (✅ Required)
    init(onboardingVM: OnboardingViewModel) {
        //🟥 Why self. ???
        self.onboardingVM = onboardingVM
        //🟥
        self.calendarVM = CalendarViewModel(learnerM: onboardingVM.learnerM)
        setupFreezeLimit()
        setupMidnightReset()
        updateButtonStates()
        restoreButtonStates()
        
    }
    
    //Setup freezes limit based on the choosen duration
    private func setupFreezeLimit() {
        switch onboardingVM.learnerM.duration {
            case .week: onboardingVM.learnerM.freezeLimit = 2
            case .month: onboardingVM.learnerM.freezeLimit = 8
            case .year: onboardingVM.learnerM.freezeLimit = 96
        }
        // ✅ persist any model updates
        onboardingVM.saveLearner()
    }
        
    //🟥  MARK: - Logging Learning
    func logAsLearned() {
        guard !isLogButtonDisabled else { return }
        
        onboardingVM.learnerM.streak += 1
        //🟥 Assuming it is for loggedDates stack ?? 
        onboardingVM.learnerM.loggedDates.append(Date())
        
        // ✅ Refresh visuals
        calendarVM.refresh()
        
        // ✅ record today's action
        onboardingVM.learnerM.lastActionDate = Date()
        
        disableButtonsUntilMidnight()
        // ✅ persist streak and log
        onboardingVM.saveLearner()
        
        didUseFreezeToday = false
        
        
        
        
        
    }
        
    //🟥 MARK: - Using a Freeze
    func useFreeze() {
        guard !isFreezeButtonDisabled else { return }
        guard onboardingVM.learnerM.freezeCount < onboardingVM.learnerM.freezeLimit else {
            isOutOfFreeze = true
            return
        }
        onboardingVM.learnerM.freezeCount += 1
        //🟥 Assuming it is for loggedDates stack ??
        onboardingVM.learnerM.freezedDates.append(Date())
        
        // ✅ Refresh visuals
        calendarVM.refresh()
        
        
        // ✅ record today's action
        onboardingVM.learnerM.lastActionDate = Date()
        
        // ✅ Track that freeze was used today
        didUseFreezeToday = true
        disableButtonsUntilMidnight()
        // ✅ persist freeze use
        onboardingVM.saveLearner()
    }
        
    //🟥 MARK: - Resetting and Conditions
    func checkStreakResetCondition() {
        // If more than 32 hours passed since last log or freeze
        guard let last = onboardingVM.learnerM.lastActionDate else { return }
        let hoursPassed = Date().timeIntervalSince(last) / 3600
        if hoursPassed > 32 {
            onboardingVM.learnerM.streak = 0
            // ✅ persist streak reset
            onboardingVM.saveLearner()
        }
    }
        
    //🟥
    func resetForNewGoal(learnerM: LearnerModel) {
        var updatedLearner = learnerM

        // ✅ Reset only goal-specific data
        updatedLearner.startDate = Date()
        updatedLearner.streak = 0
        updatedLearner.freezeCount = 0
        updatedLearner.loggedDates.removeAll()
        updatedLearner.freezedDates.removeAll()

        // ✅ Recalculate limits
        switch updatedLearner.duration {
            case .week:
                updatedLearner.freezeLimit = 2
            case .month:
                updatedLearner.freezeLimit = 8
            case .year:
                updatedLearner.freezeLimit = 96
        }

        onboardingVM.learnerM = updatedLearner
        onboardingVM.createdLearner = true
        onboardingVM.saveLearner()
        
        // ✅ keep calendar synced
        calendarVM.learnerM = learnerM
        // ✅ refresh calendar days
        calendarVM.setup()


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
    //New helper function
    private func restoreButtonStates() {
        guard let lastAction = onboardingVM.learnerM.lastActionDate else { return }

        let calendar = Calendar.current
        if calendar.isDateInToday(lastAction) {
            // ✅ They already acted today — disable buttons
            isLogButtonDisabled = true
            isFreezeButtonDisabled = true
            didUseFreezeToday = onboardingVM.learnerM.freezedDates.contains { calendar.isDateInToday($0) }
        } else {
            // ✅ New day — reset states
            enableButtonsAtMidnight()
        }
    }

}//class
