
import SwiftUI
struct ActivityView: View {
    @ObservedObject var onboardingVM: OnboardingViewModel
    @StateObject var activityVM: ActivityViewModel
    @StateObject var calendarVM: CalendarViewModel

    @State private var showCalendar = false
    @State private var showOnboarding = false

    // Custom initializer
    init(onboardingVM: OnboardingViewModel) {
        self.onboardingVM = onboardingVM
        _activityVM = StateObject(wrappedValue: ActivityViewModel(onboardingVM: onboardingVM))
        _calendarVM = StateObject(wrappedValue: CalendarViewModel(learnerM: onboardingVM.learnerM))
    }


    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("Activity")
                        .font(.system(size: 34))
                        .bold()
                    Spacer()
                    Group {
                        Button {
                            showCalendar = true
                        } label: {
                            Image(systemName: "calendar")
                        }
                        
                        Button {
                            showOnboarding = true
                        } label: {
                            Image(systemName: "pencil.and.outline")
                        }
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 22))
                    .frame(width: 44, height: 44)
                    .glassEffect(.regular.interactive().tint(.gray.opacity(0.1)))
                    
                    
                }//HStack - For Title and Tool Bar
                ZStack {
                    VStack(alignment: .leading){
                        CompactCalendarView(activityVM: activityVM)
                    }//VStack - For Calendar, Text, and Counts
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                }//ZStack - For Background Frame of Calendar and Counts
                .frame(width: 365, height: 254)
                .padding(.bottom, 25)
                if activityVM.isGoalAchieved {
                    // 🎉 Congratulations UI
                    VStack(spacing: 20) {
                        Text("👏🏼")
                            .font(.system(size: 40))
                        Text("Will done!")
                            .font(.system(size: 22))
                            .bold()
                            .padding(.top, 40)
                        Text("Goal completed! start learning again or set new learning goal")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)

                        Button {
                            showOnboarding = true
                        } label: {
                            Text("Set New Learning Goal")
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.plain)
                        .glassEffect(.clear.interactive().tint(.primaryButton))

                        Button {
                            activityVM.resetForNewGoal(learnerM: activityVM.onboardingVM.learnerM)
                        } label: {
                            Text("Set same learning goal and duration")
                                .font(.system(size: 15))
                                .foregroundColor(.primaryButton)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 40)

                } else {
                    // 🟢 Normal logging/freezing UI
                    Button {
                        activityVM.logAsLearned()
                    } label: {
                        Text(activityVM.didUseFreezeToday ? "Day Freezed" : "Log as learned")
                            .font(.system(size: 36))
                            .foregroundStyle(Color(activityVM.isLogButtonDisabled ? (activityVM.didUseFreezeToday ? .cubeBlue : .flameOranage): .white))
                            .frame(width: 232, height: 100)
                            .bold()
                    }
                    .disabled(activityVM.isLogButtonDisabled)
                    .buttonStyle(.plain)
                    .frame(width: 274, height: 274)
                    .glassEffect(.clear.interactive().tint(Color(activityVM.isLogButtonDisabled ? (activityVM.didUseFreezeToday ? .dayFreezeBG : .onboardingLogoBG): .primaryButton)))

                    Spacer()

                    Button {
                        activityVM.useFreeze()
                    } label: {
                        Text("Log as freezed")
                    }
                    .disabled(activityVM.isFreezeButtonDisabled)
                    .buttonStyle(.plain)
                    .font(.system(size: 17))
                    .foregroundColor(Color(.white))
                    .frame(width: 274, height: 48)
                    .glassEffect(.regular.interactive().tint(Color(activityVM.didUseFreezeToday ? .disabledLogFreeze : (activityVM.isOutOfFreeze ? .disabledLogFreeze :.freezePrimaryButton))))

                    Text("\(activityVM.onboardingVM.learnerM.freezeCount) out of \(activityVM.onboardingVM.learnerM.freezeLimit) freezes used")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.gray))
                }
            }//VStack
            .padding()
            
            .onAppear {
                activityVM.checkStreakResetCondition()
                activityVM.checkGoalCompletion() // ✅ add this line
            }
            // 👇 Add your navigation destinations here
            .navigationDestination(isPresented: $showCalendar) {
                CalendarView(activityVM: activityVM)
            }
            .navigationDestination(isPresented: $showOnboarding) {
                OnboardingView(onboardingVM: onboardingVM, isEditing: true) { learner in
                    activityVM.resetForNewGoal(learnerM: learner)
                }
            }
        }//NavigationStack
    }//body
    
}//struct

//#Preview {
//    
//    ActivityView()
//}
