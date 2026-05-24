import SwiftUI

@main
struct PinholeCalcApp: App {
    @StateObject private var log = ExposureLog()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(log)
                .preferredColorScheme(log.appearance.colorScheme)
                .tint(Palette.accent)
        }
    }
}
