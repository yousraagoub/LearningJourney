//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 30/04/1447 AH.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDates: Set<DateComponents> = []
    private let currentMonth = DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
    private let currentYear = Calendar.current.component(.year, from: Date())

    var body: some View {
        VStack {
            Text("\(currentMonth) \(currentYear)")
                .font(.title2)
                .bold()

            MultiDatePicker("Select Dates", selection: $selectedDates)
                .frame(maxHeight: 320) // limits to roughly one month view
        }
        .padding()
    }
}


#Preview {
    CalendarView()
}
