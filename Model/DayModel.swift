//
//  DayModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 04/05/1447 AH.
//
import Foundation

struct Day: Identifiable {
    let id = UUID()
    let date: Date
    var isCurrent: Bool = false
    var isLogged: Bool = false
    var isFreezed: Bool = false
}
