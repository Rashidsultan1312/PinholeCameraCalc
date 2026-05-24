import SwiftUI

struct PinholeBadge: View {
    let titleKey: LocalizedStringKey
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titleKey).font(.caption2.weight(.semibold)).foregroundStyle(.secondary)
            Text(value).font(.system(.subheadline, design: .monospaced).weight(.bold))
        }
    }
}
