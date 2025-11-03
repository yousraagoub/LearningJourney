import SwiftUI

struct MonthlyCalendarView: View {
    @ObservedObject var calendarVM: CalendarViewModel
    var monthDate: Date
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(monthDate , format: .dateTime.month().year())
                    .font(.system(size: 17))
                    .bold()
                Spacer()
                
            }
            .padding()
            
            LazyVGrid(columns: columns) {
    
                ForEach(calendarVM.weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 13))
                        .foregroundColor(Color.gray)
                }
                                ForEach(calendarVM.days(for: monthDate)) { day in
                    Text("\(Calendar.current.component(.day, from: day.date))")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(8)
                        .background(day.isCurrent ? Color.flameOranage : (day.isLogged ? Color.streakBG : (day.isFreezed ? Color.freezeBG : Color.clear)))
                        .clipShape(Circle())
                        .foregroundColor(day.isCurrent || day.isLogged || day.isFreezed ? .white : .white)
                        .bold()
                    
                   
                }
                
            }
        }
    }
}
