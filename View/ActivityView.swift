//
//  ActivityView.swift
//  LearningJourney
//
//  Created by Yousra Abdelrahman on 29/04/1447 AH.
//
import SwiftUI
struct ActivityView: View {
    var body: some View {
        VStack{
            HStack{
                Text("Activity")
                    .font(.system(size: 34))
                    .bold()
                Spacer()
                Image(systemName: "calendar")
                    .font(.system(size: 22))
                    .frame(width: 44, height: 44)
                    .glassEffect()
                Image(systemName: "pencil.and.outline")
                    .font(.system(size: 22))
                    .frame(width: 44, height: 44)
                    .glassEffect()
                
            }//HStack - For Title and Tool Bar
           ZStack {
               RoundedRectangle(cornerRadius:50)
                   .fill(Color.clear)
                   .stroke(Color.white, lineWidth: 5)
                   .opacity(0.5)
                   
               
               VStack{
                   MultiDatePicker("Label"/*@END_MENU_TOKEN@*/, selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Binding<Set<DateComponents>>@*/.constant([]))
                       .frame(maxHeight: 78)
                       .tint(.blue) // 👈 change highlight color
                       .background(.thinMaterial)
                       .clipShape(RoundedRectangle(cornerRadius: 16))
                       .padding(.horizontal)
                   Divider()
                   Text("Learning *Placeholder*")
                       .font(.system(size: 16))
                       .bold()
                   HStack {
                       ZStack{
                           RoundedRectangle(cornerRadius: 100)
                               .fill(Color.clear)
                               .frame(width: 160, height: 69)
                               .glassEffect(.clear.tint(.streakBG))
                           HStack{
                               Image(systemName: "flame.fill")
                                   .font(.system(size: 15))
                                   .foregroundStyle(Color.flameOranage)
                               VStack (alignment: .leading){
                                   Text("*100*")
                                       .font(.system(size: 24))
                                       .bold()
                                       .foregroundStyle(Color.white)
                                   Text("Days of Learning")
                                       .font(.system(size: 12))
                                       .foregroundStyle(Color.white)
                               }//VStack - For Count and Text
                           }//HStack - For Flame, Count, and Text
                       }//ZStack - For Streak Overlaping
                       ZStack{
                           RoundedRectangle(cornerRadius: 100)
                               .fill(Color.clear)
                               .frame(width: 160, height: 69)
                               .glassEffect(.clear.tint(.freezeBG))
                           HStack{
                               Image(systemName: "cube.fill")
                                   .font(.system(size: 15))
                                   .foregroundStyle(Color.cubeBlue)
                               VStack (alignment: .leading){
                                   Text("*100*")
                                       .font(.system(size: 24))
                                       .bold()
                                       .foregroundStyle(Color.white)
                                   Text("Days of Learning")
                                       .font(.system(size: 12))
                                       .foregroundStyle(Color.white)
                               }//VStack - For Count and Text
                           }//HStack - For Cube, Count, and Text
                       }//ZStack - For Freeze Overlaping
                   }//HStack - For Streak and Freeze Count
               }//VStack - For Calendar, Text, and Counts
            }//ZStack - For Background Frame of Calendar and Counts
           .frame(width: 365, height: 254)
           .padding(.bottom, 40)
            ZStack{
                Circle()
                    .fill(Color.clear)
                    .frame(width: 274, height: 274)
                    .glassEffect(.clear.tint(.primaryButton))
                Text("Log as learned")
                    .font(.system(size: 36))
                    .foregroundStyle(Color.white)
                    .frame(width: 232, height: 100)
                    .bold()
            }//ZStack - For Log Button
            Spacer()
            Text("Log as freezed")
                .font(.system(size: 17))
                .foregroundColor(Color(.white))
                .frame(width: 274, height: 48)
                .glassEffect(.regular.interactive().tint(.freezePrimaryButton))
            Text("*1* out of *2* freezes used")
                .font(.system(size: 14))
                .foregroundColor(Color(.gray))

        }//VStack
        .padding()
    }//body
}//struct

#Preview {
    ActivityView()
}
