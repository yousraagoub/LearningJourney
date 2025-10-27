//
//  OnboardingViewModel.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 01/05/1447 AH.
//
import Foundation
internal import Combine

class OnboardingViewModel: ObservableObject {
    @Published var learnerM: LearnerModel
    @Published var createdLearner: Bool = false
    
    init(learnerM: LearnerModel = LearnerModel()) {
        self.learnerM = learnerM
    }
    
    func createLearner() {
       
        createdLearner = true
    }
    
    func updateLearner(subject: String, duration: LearnerModel.Duration) {
        learnerM.subject = subject
        learnerM.duration = duration
    }
    
    func selectDuration(_ duration: LearnerModel.Duration) {
        learnerM.duration = duration
    }
}
//class
