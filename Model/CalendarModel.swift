//
//  CalendarModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 29/04/1447 AH.
//
import SwiftUI
struct CalendarModel: View {
    @State private var selectedDates: Set<DateComponents> = []
    var body: some View {
//        MultiDatePicker("Select Dates", selection: $selectedDates)
        VStack(alignment: .leading, spacing: 12) {
            Text("Choose your dates")
                .font(.headline)
                .foregroundColor(.primary)
            
            MultiDatePicker("", selection: $selectedDates)
                .frame(maxHeight: 78)
                .tint(.blue) // 👈 change highlight color
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
        }

    }//body
}

#Preview {
    CalendarModel()
}
