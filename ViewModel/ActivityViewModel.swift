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

    @Published var isLogButtonDisabled = false
    @Published var isFreezeButtonDisabled = false
    @Published var didUseFreezeToday = false
    @Published var isOutOfFreeze = false

    @Published var calendarVM: CalendarViewModel
    
    @Published var isGoalAchieved: Bool = false
    
    //Timer to re-enable buttons at midnight.
    private var midnightTimer: Timer?
    
    init(onboardingVM: OnboardingViewModel) {
        self.onboardingVM = onboardingVM
        self.calendarVM = CalendarViewModel(learnerM: onboardingVM.learnerM)
        
        DispatchQueue.main.async { [weak self] in
            self?.setupFreezeLimit()
            self?.setupMidnightReset()
            self?.updateButtonStates()
            self?.restoreButtonStates()
        }
        
    }
    func checkGoalCompletion() {
        let totalDays: Int
        switch onboardingVM.learnerM.duration {
        case .week:
            totalDays = 7
        case .month:
            totalDays = 30
        case .year:
            totalDays = 365
        }
        
        //Check if streak reached duration
        isGoalAchieved = onboardingVM.learnerM.streak >= totalDays
    }
    
    //Setup freezes limit based on the choosen duration
    private func setupFreezeLimit() {
        switch onboardingVM.learnerM.duration {
            case .week: onboardingVM.learnerM.freezeLimit = 2
            case .month: onboardingVM.learnerM.freezeLimit = 8
            case .year: onboardingVM.learnerM.freezeLimit = 96
        }
        //Persist any model updates
        onboardingVM.saveLearner()
    }
        
    func logAsLearned() {
        guard !isLogButtonDisabled else { return }
        
        onboardingVM.learnerM.streak += 1
        onboardingVM.learnerM.loggedDates.append(Date())
        calendarVM.refresh()
        onboardingVM.learnerM.lastActionDate = Date()
    
        disableButtonsUntilMidnight()
        onboardingVM.saveLearner()
        
        didUseFreezeToday = false
        
        checkGoalCompletion()
        
    }
        
    func useFreeze() {
        guard !isFreezeButtonDisabled else { return }
        guard onboardingVM.learnerM.freezeCount < onboardingVM.learnerM.freezeLimit else {
            isOutOfFreeze = true
            return
        }
        onboardingVM.learnerM.freezeCount += 1
        onboardingVM.learnerM.freezedDates.append(Date())
        calendarVM.refresh()
        
        onboardingVM.learnerM.lastActionDate = Date()
        
        didUseFreezeToday = true
        disableButtonsUntilMidnight()

        onboardingVM.saveLearner()
        
        checkGoalCompletion()

    }
        
    func checkStreakResetCondition() {
        // If more than 32 hours passed since last log or freeze
        guard let last = onboardingVM.learnerM.lastActionDate else { return }
        let hoursPassed = Date().timeIntervalSince(last) / 3600
        if hoursPassed > 32 {
            onboardingVM.learnerM.streak = 0
            onboardingVM.saveLearner()
        }
    }
     
    func resetForNewGoal(learnerM: LearnerModel) {
        var updatedLearner = learnerM

        if updatedLearner.streak > 0 {
            let completedGoal = CompletedGoal(
                subject: updatedLearner.subject,
                duration: updatedLearner.duration,
                completedDate: Date(),
                streakAchieved: updatedLearner.streak
            )
            updatedLearner.completedGoals.append(completedGoal)
        }

        updatedLearner.startDate = Date()
        updatedLearner.streak = 0
        updatedLearner.freezeCount = 0
        updatedLearner.loggedDates.removeAll()
        updatedLearner.freezedDates.removeAll()

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

        calendarVM.learnerM = updatedLearner
        calendarVM.setup()

        updateButtonStates()
    }

    private func updateButtonStates() {
        isFreezeButtonDisabled = onboardingVM.learnerM.freezeCount >= onboardingVM.learnerM.freezeLimit
        isOutOfFreeze = onboardingVM.learnerM.freezeCount >= onboardingVM.learnerM.freezeLimit
        isLogButtonDisabled = false
    }
    
    private func disableButtonsUntilMidnight() {
        isLogButtonDisabled = true
        isFreezeButtonDisabled = true
    }
        
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
  
    private func enableButtonsAtMidnight() {
        isLogButtonDisabled = false
        isFreezeButtonDisabled = onboardingVM.learnerM.freezeCount >= onboardingVM.learnerM.freezeLimit
        didUseFreezeToday = false 
        setupMidnightReset() // schedule again for next day
    }
   
    deinit {
        midnightTimer?.invalidate()
    }
    //New helper function
    private func restoreButtonStates() {
        guard let lastAction = onboardingVM.learnerM.lastActionDate else { return }

        let calendar = Calendar.current
        if calendar.isDateInToday(lastAction) {
            isLogButtonDisabled = true
            isFreezeButtonDisabled = true
            didUseFreezeToday = onboardingVM.learnerM.freezedDates.contains { calendar.isDateInToday($0) }
        } else {
            enableButtonsAtMidnight()
        }
    }

}//class
