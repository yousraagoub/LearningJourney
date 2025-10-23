//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 30/04/1447 AH.
//

import SwiftUI
struct CalendarView: View {
    var body: some View {
        MultiDatePicker("Label", selection: .constant([]))
    }
}

#Preview {
    CalendarView()
}
