import Combine
import Foundation

@MainActor
class CalendarViewModel: ObservableObject {
    // used for weekly view
    @Published var currentDate: Date = Date() {
        didSet {
            selectedMonth = currentDate
        }
    }
    // which month this VM represents
    @Published var selectedMonth: Date = Date() {
        didSet {
            currentDate = selectedMonth
            generateWeekDays()
            generateMonthDays()
    }
}
    
    
    @Published var showMonthPicker: Bool = false
    
    @Published var weekDays: [String] = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    @Published var daysInWeek: [Day] = []
    @Published var daysInMonth: [Day] = []
    
    var learnerM: LearnerModel
    private var calendar = Calendar.current
    
    // UPDATED initializer — accept a selectedMonth
    // ✅ FIXED initializer
    // ✅ Safe initializer — don’t call methods that depend on self
    init(learnerM: LearnerModel, selectedMonth: Date = Date()) {
        self.learnerM = learnerM
        generateWeekDays()
        generateMonthDays()
        // ❌ No calls to generateWeekDays or generateMonthDays here
    }
    
    
    func refresh() {
        generateWeekDays()
        generateMonthDays()
    }
    
    // ✅ Call this from the View or onAppear
    func setup() {
        generateWeekDays()
        generateMonthDays()
    }
    
    // Helper to change the month and regenerate
    func setMonth(_ month: Date) {
        selectedMonth = month
        // optionally sync currentDate too:
        currentDate = month
        generateMonthDays()
        generateWeekDays()
    }
    
    func generateWeekDays() {
        guard let weekStart = calendar.dateInterval(of: .weekOfMonth, for: currentDate)?.start else { return }
        daysInWeek = (0..<7).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: weekStart) {
                return Day(
                    date: date,
                    isCurrent: calendar.isDateInToday(date),
                    isLogged: learnerM.loggedDates.contains { calendar.isDate($0, inSameDayAs: date) },
                    isFreezed: learnerM.freezedDates.contains { calendar.isDate($0, inSameDayAs: date) }
                )
            }
            return nil
        }
    }
    
    func generateMonthDays() {
        guard let monthInterval = calendar.dateInterval(of: .month, for: selectedMonth) else { return }
        let daysCount = calendar.dateComponents([.day], from: monthInterval.start, to: monthInterval.end).day ?? 0
        
        daysInMonth = (0..<daysCount).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: monthInterval.start) {
                return Day(
                    date: date,
                    isCurrent: calendar.isDateInToday(date),
                    isLogged: learnerM.loggedDates.contains { calendar.isDate($0, inSameDayAs: date) },
                    isFreezed: learnerM.freezedDates.contains { calendar.isDate($0, inSameDayAs: date) }
                )
            }
            return nil
        }
    }
    
    func goToNextWeek() {
        currentDate = calendar.date(byAdding: .weekOfMonth, value: 1, to: currentDate) ?? currentDate
        generateWeekDays()
    }
    
    func goToPreviousWeek() {
        currentDate = calendar.date(byAdding: .weekOfMonth, value: -1, to: currentDate) ?? currentDate
        generateWeekDays()
    }
    
    // month navigation: use setMonth so everything regenerates consistently
    func goToNextMonth() {
        if let next = calendar.date(byAdding: .month, value: 1, to: selectedMonth) {
            setMonth(next)
        }
    }
    
    func goToPreviousMonth() {
        if let prev = calendar.date(byAdding: .month, value: -1, to: selectedMonth) {
            setMonth(prev)
        }
    }
    
    //Helper
    func days(for month: Date) -> [Day] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return [] }
        let daysCount = calendar.dateComponents([.day], from: monthInterval.start, to: monthInterval.end).day ?? 0
        
        return (0..<daysCount).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: monthInterval.start) {
                return Day(
                    date: date,
                    isCurrent: calendar.isDateInToday(date),
                    isLogged: learnerM.loggedDates.contains { calendar.isDate($0, inSameDayAs: date) },
                    isFreezed: learnerM.freezedDates.contains { calendar.isDate($0, inSameDayAs: date) }
                )
            }
            return nil
        }
    }

}
