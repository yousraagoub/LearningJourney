//
//  DatePickerCompactView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//
import SwiftUI

struct CompactCalendarView: View {
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
        }//ZStack
        .frame(width: 350, height: 254)
    }//body
}//struct
