import SwiftUI

struct PrivacyWebView: View {
    var body: some View {
        EmulsionFrame(print: AppConfig.privacyPolicyURL, unprocessed: true)
            .navigationTitle("settings.privacy")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
    }
}
