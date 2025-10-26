//
//  LearnerModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 01/05/1447 AH.
//

import Foundation

struct LearnerModel: Identifiable{ //Codable is for later...
    var id: UUID = UUID()
    var subject: String = ""
    var duration: Duration = .week
    var startDate: Date = Date()
    var streak: Int = 0
    var freezeCount: Int = 0
    var freezeLimit: Int = 0
    var loggedDates: [Date] = []  // days marked as learned
    var freezedDates: [Date] = [] // days marked as frozen
    var endDate: Date {
        let calendar = Calendar.current
        switch duration {
        case .week:
            return calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)!
        case .month:
            return calendar.date(byAdding: .month, value: 1, to: startDate)!
        case .year:
            return calendar.date(byAdding: .year, value: 1, to: startDate)!
        }//switch
    }//endDate
    //To use an enum in a ForEach, it must conform to CaseIterable (so you can access .allCases) and to Identifiable or Hashable (so SwiftUI can track each element uniquely).
    enum Duration: String, CaseIterable, Identifiable {
        case week, month, year
        
        // makes it identifiable
        var id: String { self.rawValue }
    }//enum Duration
}//struct
