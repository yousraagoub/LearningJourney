//
//  CalendarViewModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 30/04/1447 AH.
//
import Foundation
internal import Combine

class CalendarViewModel: ObservableObject {
    @Published var currentDate: Date = Date()        // current date shown
    @Published var selectedMonth: Date = Date()      // for month picker
    @Published var weekDays: [String] = ["SUN","MON","TUE","WED","THU","FRI","SAT"]
    
    @Published var daysInWeek: [Day] = []           // weekly view
    @Published var daysInMonth: [Day] = []          // monthly overview
    
    var learner: LearnerModel
    
    init(learner: LearnerModel) {
        self.learner = learner
        generateWeekDays()
        generateMonthDays()
    }
    
    func generateWeekDays() {
        let calendar = Calendar.current
        guard let weekStart = calendar.dateInterval(of: .weekOfMonth, for: currentDate)?.start else { return }
        daysInWeek = (0..<7).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: weekStart) {
                return Day(
                    date: date,
                    isCurrent: calendar.isDateInToday(date),
                    isLogged: learner.loggedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }),
                    isFreezed: learner.freezedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) })
                )
            }
            return nil
        }
    }
    
    func generateMonthDays() {
        let calendar = Calendar.current
        guard let monthInterval = calendar.dateInterval(of: .month, for: selectedMonth) else { return }
        daysInMonth = (0..<calendar.dateComponents([.day], from: monthInterval.start, to: monthInterval.end).day!).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: offset, to: monthInterval.start) {
                return Day(
                    date: date,
                    isCurrent: calendar.isDateInToday(date),
                    isLogged: learner.loggedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) }),
                    isFreezed: learner.freezedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) })
                )
            }
            return nil
        }
    }
    
    func goToNextWeek() {
        currentDate = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: currentDate) ?? currentDate
        generateWeekDays()
    }
    
    func goToPreviousWeek() {
        currentDate = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: currentDate) ?? currentDate
        generateWeekDays()
    }
    
    func goToNextMonth() {
        selectedMonth = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) ?? selectedMonth
        generateMonthDays()
    }
    
    func goToPreviousMonth() {
        selectedMonth = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) ?? selectedMonth
        generateMonthDays()
    }
}
