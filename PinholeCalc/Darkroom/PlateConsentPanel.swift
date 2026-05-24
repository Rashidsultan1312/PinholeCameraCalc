import SwiftUI

struct PlateConsentPanel: View {
    let leaf: URL
    let onFix: () -> Void
    @State private var exposed = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 18) {
                VStack(spacing: 6) {
                    Text("gate.welcome.title")
                        .font(.system(size: 30, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.primary)
                    Text("gate.welcome.subtitle")
                        .font(.system(size: 14, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 26)
                }
                .padding(.top, 28)

                EmulsionFrame(print: leaf, unprocessed: true)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.primary.opacity(0.15), lineWidth: 1)
                    )
                    .padding(.horizontal, 18)

                Button(action: { exposed.toggle() }) {
                    HStack(spacing: 12) {
                        Image(systemName: exposed ? "largecircle.fill.circle" : "circle")
                            .font(.system(size: 22))
                            .foregroundStyle(exposed ? Color.accentColor : Color.secondary)
                        Text("gate.privacy.agree")
                            .font(.system(size: 15, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 18)

                Button(action: onFix) {
                    Text("gate.privacy.continue")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
                .disabled(!exposed)
                .opacity(exposed ? 1 : 0.4)
                .padding(.horizontal, 18)
                .padding(.bottom, 22)
            }
        }
        .interactiveDismissDisabled(true)
    }
}
