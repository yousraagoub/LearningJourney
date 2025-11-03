

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var onboardingVM: OnboardingViewModel
    var onFinished: (LearnerModel) -> Void = { _ in }
    var isEditing: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    @State private var showUpdateAlert = false
    
    init(onboardingVM: OnboardingViewModel, isEditing: Bool = false, onFinished: @escaping (LearnerModel) -> Void = { _ in }) {
        self.onboardingVM = onboardingVM
        self.isEditing = isEditing
        self.onFinished = onFinished
    }
    var body: some View {
            NavigationStack{
                VStack{
                    if isEditing {
                        Text("Learning Goal")
                            .font(.system(size: 13))
                            .bold()
                    } else {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(Color(.flameOranage))
                            .frame(width: 109, height: 109)
                            .glassEffect(.clear)
                            .background(.onboardingLogoBG)
                            .cornerRadius(100)
                    }
                    VStack(alignment: .leading){
                        Text(isEditing ? "" : "Hello Learner")
                            .font(.system(size: 34))
                            .bold()
                        Text(isEditing ? "" : "This app will help you learn everyday!")
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
                    // Only show Start Fresh when editing
                    if isEditing {
                        Button(role: .destructive) {
                            onboardingVM.deleteLearner()
                        } label: {
                            Text("Delete History")
                        }
                    } else {
                        // Show Start Learning only on first onboarding
                        Button {
                            onboardingVM.createLearner()
                            onFinished(onboardingVM.learnerM)
                        } label: {
                            Text("Start Learning")
                        }
                        .buttonStyle(.plain)
                        .font(.system(size: 17))
                        .foregroundColor(Color.white)
                        .frame(width: 182, height: 48)
                        .glassEffect(.clear.interactive())
                        .background(.primaryButton)
                        .cornerRadius(30)
                    }
 
                }//VStack
                .padding()
            }//NavigationStack
            .ignoresSafeArea(edges: .top)
            // ensure this view does not create its own NavigationStack
            .navigationBarTitleDisplayMode(.inline)        // prefers inline title (works well with .principal)
            .toolbar {
                // principal toolbar item centers the text while preserving system back button at left
                ToolbarItem(placement: .principal) {
                    Text(isEditing ? "Learning Goal" : "")
                        .font(.headline)
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing){
                    if isEditing {
                        Button {
                            showUpdateAlert = true
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 18))

                        }

                    }//if
                }
            }//toolbar
            // Confirmation alert
            .alert("Update Learning goal", isPresented: $showUpdateAlert) {
                Button("Dismiss", role: .cancel) {}
                Button("Update") {
                    onboardingVM.createLearner() // ✅ Save updates
                    onFinished(onboardingVM.learnerM) // ✅ Go back to ActivityView
                    dismiss() // ✅ Dismiss update view
                }
            } message: {
                Text("If you update now, your streak will start over.")
            }
    }//body
}//struct


