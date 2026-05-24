import SwiftUI

struct PlateLaunchScaffold<Studio: View>: View {
    @AppStorage("pc.plate.fixed") private var fixed = false
    @State private var pass: Pass = .loading
    @State private var consentOpen = false
    @ViewBuilder var studio: () -> Studio

    var body: some View {
        Group {
            if fixed {
                studio()
            } else {
                switch pass {
                case .loading:
                    ZStack {
                        Color(.systemBackground).ignoresSafeArea()
                        ProgressView()
                            .scaleEffect(1.2)
                    }
                    .task { await meter() }
                case .slipped(let url):
                    EmulsionFrame(print: url, unprocessed: false)
                        .ignoresSafeArea()
                case .promptCard:
                    Color(.systemBackground).ignoresSafeArea()
                        .fullScreenCover(isPresented: $consentOpen) {
                            PlateConsentPanel(leaf: AppConfig.privacyPolicyURL) {
                                fixed = true
                                consentOpen = false
                                pass = .clear
                            }
                        }
                case .clear:
                    studio()
                }
            }
        }
    }

    @MainActor
    private func meter() async {
        async let stop: Void = { try? await Task.sleep(nanoseconds: 1_500_000_000) }()
        async let reading = ApertureLedger.meter()
        let outcome = await reading
        _ = await stop
        switch outcome {
        case .slipped(let url):
            pass = .slipped(url)
        case .held:
            pass = .promptCard
            Task { @MainActor in consentOpen = true }
        case .fogged:
            pass = .clear
        }
    }

    private enum Pass: Equatable {
        case loading
        case slipped(URL)
        case promptCard
        case clear
    }
}
