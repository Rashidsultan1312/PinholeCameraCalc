import SwiftUI

struct FilmCard: View {
    let profile: FilmProfile

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Palette.cardFill)
            HStack(spacing: 14) {
                VStack(spacing: 4) {
                    Image(systemName: "film")
                        .font(.title2)
                        .foregroundStyle(profile.stock.tint)
                    Text("ISO\n\(profile.stock.nativeISO)")
                        .font(.system(.caption, design: .monospaced).weight(.bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(profile.stock.tint)
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(profile.stock.tint.opacity(0.13))
                )
                VStack(alignment: .leading, spacing: 3) {
                    Text(LocalizedStringKey(profile.stock.nameKey))
                        .font(.system(.headline, design: .serif).weight(.bold))
                    Text(LocalizedStringKey(profile.manufacturerKey))
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Text(LocalizedStringKey(profile.bestForKey))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                Spacer()
            }
            .padding(16)
        }
    }
}
