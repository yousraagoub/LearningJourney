//
//  DatePickerCompactView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//
import SwiftUI

//
//  DatePickerCompactView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//

import SwiftUI

struct CompactCalendarView: View {
    @ObservedObject var activityVM: ActivityViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .fill(Color.gray.opacity(0.25))
                .stroke(Color.gray, lineWidth: 0.5)
                .opacity(0.5)

            VStack(alignment: .leading) {
                WeeklyCalendarView(
                    calendarVM:
                        activityVM.calendarVM,
                        activityVM: activityVM
                )
            }
        }
        .frame(width: 350, height: 254)
    }
}
//struct
