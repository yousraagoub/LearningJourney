import SwiftUI
struct CalendarView: View {
    @ObservedObject var activityVM: ActivityViewModel

    // Just a normal init that assigns the observed object
    init(activityVM: ActivityViewModel) {
        self.activityVM = activityVM
    }

    var body: some View {
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
            .padding(.vertical)
        }
    }

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

