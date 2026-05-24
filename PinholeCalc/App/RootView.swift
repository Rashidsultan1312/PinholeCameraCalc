import SwiftUI

struct RootView: View {
    @AppStorage("pc.onboarding.seen") private var onboardingSeen = false

    var body: some View {
        PlateLaunchScaffold {
            if onboardingSeen {
                MainTabView()
            } else {
                OnboardingFlow()
            }
        }
    }
}
