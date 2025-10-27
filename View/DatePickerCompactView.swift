//
//  DatePickerCompactView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//
import SwiftUI

struct DatePickerCompactView: View {
    @ObservedObject var calendarVM: CalendarViewModel
    @ObservedObject var activityVM: ActivityViewModel  // not @StateObject anymore
 
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius:13, style: .continuous)
                .fill(Color.gray.opacity(0.25))
                .stroke(Color.gray, lineWidth: 0.5)
                .opacity(0.5)
            VStack(alignment: .leading){
                //📅
                //Here ⭕️
                let calendarVM = CalendarViewModel(learnerM: activityVM.learnerM)
                WeeklyCalendarView(calendarVM: calendarVM, activityVM: activityVM)
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


//#Preview {
//    DatePickerCompactView(activityVM: ActivityViewModel)
//}
