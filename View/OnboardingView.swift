//
//  OnboardingView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 29/04/1447 AH.
//

import SwiftUI
struct OnboardingView: View {
    var body: some View {
        VStack{
            Image(systemName: "flame.fill")
                .font(.system(size: 36))
                .foregroundStyle(Color(.flameOranage))
                .frame(width: 109, height: 109)
                .glassEffect(.regular.tint(.onboardingLogoBG))
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
                    
                TextField("Swift", text: .constant(""))
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                Divider()
                Text("I want to learn it in a ")
                    .font(.system(size: 22))
                    .padding(.top, 20)
                HStack{
                    Text("Week")
                        .font(.system(size: 17))
                        .frame(width: 97, height: 48)
                        .glassEffect(.regular.interactive())
                        .onTapGesture {
                           //Action here
                        }
                    Text("Month")
                        .font(.system(size: 17))
                        .frame(width: 97, height: 48)
                        .glassEffect(.regular.interactive())
                        .onTapGesture {
                           //Action here
                        }
                    Text("Year")
                        .font(.system(size: 17))
                        .frame(width: 97, height: 48)
                        .glassEffect(.regular.interactive())
                        .onTapGesture {
                           //Action here
                        }
                }//HStack - For Buttons
            }//VStack - For Text Alignment
            .padding(.top, 40)
            Spacer()
            Text("Start learning")
                .font(.system(size: 17))
                .foregroundColor(Color(.white))
                .frame(width: 182, height: 48)
                .glassEffect(.regular.interactive().tint(.primaryButton))
        }//VStack
        .padding()
    }//body
}//struct
#Preview {
    OnboardingView()
}
