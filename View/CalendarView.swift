import SwiftUI
struct CalendarView: View {
    @ObservedObject var activityVM: ActivityViewModel

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
            .padding(.top, 70)
            .padding(.vertical)

        }//ZStack
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
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

