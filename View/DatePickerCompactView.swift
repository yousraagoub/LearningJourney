//
//  DatePickerCompactView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//
import SwiftUI

struct DatePickerCompactView: View {
    @StateObject var activityVM: ActivityViewModel
    init(learnerM: LearnerModel) {
           _activityVM = StateObject(wrappedValue: ActivityViewModel(learnerM: learnerM))
       }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius:13, style: .continuous)
                .fill(Color.gray.opacity(0.25))
                .stroke(Color.gray, lineWidth: 0.5)
                .opacity(0.5)
            VStack(alignment: .leading){
                //📅
                let calendarVM = CalendarViewModel(learnerM: activityVM.learnerM)
                WeeklyCalendarView(calendarVM: calendarVM)
                    .previewLayout(.sizeThatFits)
            }//VStack - For Calendar, Text, and Counts
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.top, 12)
            .padding(.bottom, 12)
        }//ZStack
        .frame(width: 365, height: 254)
    }//body
}//struct


#Preview {
    DatePickerCompactView(learnerM: LearnerModel(
        subject: "Swift",
        duration: .month,
        startDate: Date(),
        streak: 3,
        freezeCount: 1,
        freezeLimit: 8
    ))
}
