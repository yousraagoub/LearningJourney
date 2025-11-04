import Foundation

struct Day: Identifiable {
    let id = UUID()
    let date: Date
    var isCurrent: Bool = false
    var isLogged: Bool = false
    var isFreezed: Bool = false
}
