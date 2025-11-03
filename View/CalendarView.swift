import SwiftUI
struct CalendarView: View {
    @ObservedObject var activityVM: ActivityViewModel

    // Just a normal init that assigns the observed object
    init(activityVM: ActivityViewModel) {
        self.activityVM = activityVM
    }

    var body: some View {
        ZStack(alignment: .top){
            //Background content
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    ForEach(generateMonths(), id: \.self) { monthDate in
                        MonthlyCalendarView(
                            calendarVM: activityVM.calendarVM,
                            monthDate: monthDate
                        )
                    }
                    
                }
            }
            .padding(.top, 70) // leave space for header
            .padding(.vertical)

        }//ZStack
        .ignoresSafeArea(edges: .top)
        // ensure this view does not create its own NavigationStack
        .navigationBarTitleDisplayMode(.inline)        // prefers inline title (works well with .principal)
        .toolbar {
            // principal toolbar item centers the text while preserving system back button at left
            ToolbarItem(placement: .principal) {
                Text("All Activities")
                    .font(.headline)
                    .bold()
            }
        }//toolbar
    }//body
}//struct

    private func generateMonths() -> [Date] {
        let calendar = Calendar.current
        let current = Date()
        let monthsBefore = 6
        let monthsAfter = 6

        return (-monthsBefore...monthsAfter).compactMap {
            calendar.date(byAdding: .month, value: $0, to: current)
        }
    }



#Preview {
//    CalendarView(activityVM: activityVM)
}

