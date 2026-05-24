import SwiftUI

struct FormulaCard: View {
    let fact: PinholeFact

    var body: some View {
        RoundedCard {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: fact.symbol)
                    .font(.title3)
                    .foregroundStyle(Palette.accent)
                    .frame(width: 36, height: 36)
                    .background(Palette.accentSoft, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                VStack(alignment: .leading, spacing: 6) {
                    Text(LocalizedStringKey(fact.titleKey))
                        .font(.system(.headline, design: .serif).weight(.bold))
                    Text(LocalizedStringKey(fact.bodyKey))
                        .font(.system(.subheadline, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
