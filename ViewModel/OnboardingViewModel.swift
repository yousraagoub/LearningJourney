//
//  OnboardingViewModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 01/05/1447 AH.
//
import Foundation
import SwiftUI

@Observable
class OnboardingViewModel {
    var subject: String = ""
    var selectedDuration: LearnerModel.Duration = .week
    var startDate: Date = Date()
    //Object of the LearnerModel
    var learner = LearnerModel()
    //To navigate from onboarding to activity
    var shouldNavigate = false
    
    func createLearner() {
        learner = LearnerModel(
            subject: subject,
            duration: selectedDuration,
            startDate: startDate
        )
        shouldNavigate = true
    }//func
    
    func selectDuration(_ duration: LearnerModel.Duration) {
            selectedDuration = duration
        }
}//class
