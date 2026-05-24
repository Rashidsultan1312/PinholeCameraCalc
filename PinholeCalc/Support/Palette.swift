import SwiftUI

enum Palette {
    static let accent = Color("AccentColor")
    static let accentSoft = Color("AccentColor").opacity(0.14)
    static var cardFill: Color { Color(uiColor: .secondarySystemGroupedBackground) }
    static var chipFill: Color { Color(uiColor: .tertiarySystemFill) }
    static var canvas: Color { Color(uiColor: .systemGroupedBackground) }
    static let anthracite = Color(red: 0.16, green: 0.18, blue: 0.20)
    static let silverEdge = Color(red: 0.72, green: 0.74, blue: 0.76)
    static let safelight = Color(red: 0.76, green: 0.20, blue: 0.17)
}
