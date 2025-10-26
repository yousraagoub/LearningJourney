//
//  WeeklyCalendarView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//
import SwiftUI

struct WeeklyCalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.selectedMonth, style: .date)
                    .font(.system(size: 16, weight: .bold))
                    
                Spacer()
                Button(action: { viewModel.goToPreviousWeek()}) { Image(systemName: "chevron.left").foregroundStyle(Color.flameOranage) }
                Button(action: { viewModel.goToNextWeek() }) { Image(systemName: "chevron.right").foregroundStyle(Color.flameOranage) }
            }//HStack
            .padding(.bottom, 12)
            
            HStack {
                ForEach(viewModel.weekDays, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 13))
                        .foregroundColor(Color.gray)
                }
            }//HStack
            
            HStack {
                ForEach(viewModel.daysInWeek) { day in
                    Text("\(Calendar.current.component(.day, from: day.date))")
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 20, weight: .bold))
                        .padding(5)
                        .background(day.isCurrent ? Color.flameOranage : (day.isLogged ? Color.onboardingLogoBG : (day.isFreezed ? Color.freezeBG : Color.clear)))
                        .clipShape(Circle())
                        .foregroundColor(day.isCurrent || day.isLogged || day.isFreezed ? .white : .white)
                    
                }
            }//HStack
        }//VStack
    }//body
}//struct


