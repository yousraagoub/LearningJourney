//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 30/04/1447 AH.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var activityVM: ActivityViewModel
    //🟥
    init(learnerM: LearnerModel) {
           _activityVM = StateObject(wrappedValue: ActivityViewModel(learnerM: learnerM))
       }
    var body: some View {
        let viewModel = CalendarViewModel(learnerM: activityVM.learnerM)
        MonthlyCalendarView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
            .padding()
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
