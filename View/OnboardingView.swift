//
//  OnboardingView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 29/04/1447 AH.
//

import SwiftUI
internal import Combine
struct OnboardingView: View {
    @ObservedObject var onboardingVM: OnboardingViewModel
    var onFinished: (LearnerModel) -> Void = { _ in }
    var isEditing: Bool = false
    
    init(onboardingVM: OnboardingViewModel, isEditing: Bool = false, onFinished: @escaping (LearnerModel) -> Void = { _ in }) {
        self.onboardingVM = onboardingVM
        self.isEditing = isEditing
        self.onFinished = onFinished
//        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
    }
    
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    
    var body: some View {
            NavigationStack{
                VStack{
                    Image(systemName: "flame.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(Color(.flameOranage))
                        .frame(width: 109, height: 109)
                        .glassEffect(.clear)
                        .background(.onboardingLogoBG)
                        .cornerRadius(100)
                    VStack(alignment: .leading){
                        Text("Hello Learner")
                            .font(.system(size: 34))
                            .bold()
                        Text("This app will help you learn everyday!")
                            .font(.system(size: 17))
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        Text("I want to learn")
                            .font(.system(size: 22))
                            
                        TextField("Swift", text: $onboardingVM.learnerM.subject)
                            .font(.system(size: 17))
                            .foregroundColor(.gray)
                        Divider()
                        Text("I want to learn it in a ")
                            .font(.system(size: 22))
                            .padding(.top, 20)
                        HStack{
                            //No need for (...id: \.self) anymore — because the enum is Identifiable.
                            ForEach(LearnerModel.Duration.allCases) {
                                duration in Button {
                                    onboardingVM.selectDuration(duration)
                                } label: {
                                    Text(duration.rawValue.capitalized)
                                        .frame(width: 97, height: 48)
                                        .glassEffect(.clear.interactive())
                                        .background(onboardingVM.learnerM.duration == duration ? Color(.primaryButton) : Color.clear)
                                        .cornerRadius(30)
                                        .foregroundColor(.white)
                                    }
                                    .buttonStyle(.plain)
                            }//ForEach
                        }//HStack - For Buttons
                    Spacer()
                    }//VStack - For Text Alignment
                    .padding(.top, 40)
                    Button{
                        onboardingVM.createLearner()
                        onFinished(onboardingVM.learnerM)  // ✅ triggers app to switch root
                    }label: {
                        Text(isEditing ? "Save Changes" : "Start learning")
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 17))
                    .foregroundColor(Color(.white))
                    .frame(width: 182, height: 48)
                    .glassEffect(.clear.interactive())
                    .background(.primaryButton)
                    .cornerRadius(30)
                  
                
                }//VStack
                .padding()
            }
           
     
        
        
    }//body
}//struct


