//
//  ActivityViewModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 01/05/1447 AH.
//

import Foundation
internal import Combine
class ActivityViewModel: ObservableObject {
    @Published var learnerM = LearnerModel()
//    @Published var streak: Int = 0
    
    func LogAsLearned() {
        learnerM.streak += 1
    }
    func showStreak() -> Int {
        return learnerM.streak
    }
}

