//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 30/04/1447 AH.
//
import SwiftUI
struct CalendarView: View {
    @StateObject var activityVM: ActivityViewModel

    init(learnerM: LearnerModel) {
        _activityVM = StateObject(wrappedValue: ActivityViewModel(learnerM: learnerM))
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                ForEach(generateMonths(), id: \.self) { monthDate in
                    // Pass the monthDate into the ViewModel initializer
                    let viewModel = CalendarViewModel(
                        learnerM: activityVM.learnerM,
                        selectedMonth: monthDate
                    )

                    MonthlyCalendarView(viewModel: viewModel)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }

    private func generateMonths() -> [Date] {
        let calendar = Calendar.current
        let current = Date()
        let monthsBefore = 6
        let monthsAfter = 6

        return (-monthsBefore...monthsAfter).compactMap {
            calendar.date(byAdding: .month, value: $0, to: current)
        }
    }
}


#Preview {
    CalendarView(learnerM: LearnerModel(
        subject: "Swift",
        duration: .month,
        startDate: Date(),
        streak: 3,
        freezeCount: 1,
        freezeLimit: 8
    ))
}

