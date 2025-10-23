//
//  LearnerModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 01/05/1447 AH.
//

import Foundation

struct LearnerModel: Identifiable{
    var id: UUID = UUID()
    var subject: String = ""
    var duration: Duration = .week
    var startDate: Date = Date()
    var endDate: Date = Date()
    var streak: Int = 0
    var freezeCount: Int = 0
    var freezeLimit: Int = 0
}//struct

enum Duration: String{
    case week, month, year
}
