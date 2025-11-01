import Combine
import Foundation

@MainActor
class OnboardingViewModel: ObservableObject {
    @Published var learnerM: LearnerModel
    @Published var createdLearner: Bool = false
    
    //key for UserDefaults
    private let learnerKey = "learnerData"
    
    init(learnerM: LearnerModel = LearnerModel()) {
        // Try to load saved learner first
        if let data = UserDefaults.standard.data(forKey: learnerKey),
           //🟥
            let savedLearner = try? JSONDecoder().decode(LearnerModel.self, from: data) {
                self.learnerM = savedLearner
                self.createdLearner = true
        } else {
            self.learnerM = learnerM
        }
    }
    //Creat new learner
    func createLearner() {
        saveLearner()
        createdLearner = true
    }
    
    //Update existing learner
    func updateLearner(subject: String, duration: LearnerModel.Duration) {
        learnerM.subject = subject
        learnerM.duration = duration
        saveLearner()
    }
    
    //Select duration for Onboarding UI
    func selectDuration(_ duration: LearnerModel.Duration) {
        learnerM.duration = duration
    }
    
    //Save and load
    func saveLearner() {
        //🟥
        do {
            //🟥
            let data = try JSONEncoder().encode(learnerM)
            UserDefaults.standard.set(data, forKey: learnerKey)
        } catch {
            print("❌ Failed to save learner: \(error)")
        }
    }
    
    //Deletes current learner and starts fresh
    func deleteLearner() {
        UserDefaults.standard.removeObject(forKey: learnerKey)
        learnerM = LearnerModel()
        createdLearner = false
    }
}
//class
