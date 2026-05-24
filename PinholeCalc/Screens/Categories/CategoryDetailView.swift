import SwiftUI

struct FilmDetailView: View {
    let profile: FilmProfile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                heroBlock
                RoundedCard {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("pellicole.details").upperLabel()
                        Text(LocalizedStringKey(profile.detailsKey))
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                RoundedCard(tinted: profile.stock.tint.opacity(0.10)) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("pellicole.bestfor").upperLabel()
                        Text(LocalizedStringKey(profile.bestForKey))
                            .font(.system(.body, design: .serif).weight(.semibold))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                RoundedCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("pellicole.schwarzschild").upperLabel()
                        Text(String(format: NSLocalizedString("pellicole.schwarzschild.body", comment: ""), profile.stock.schwarzschild))
                            .font(.system(.subheadline, design: .monospaced))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .background(DarkroomCanvas(opacity: 0.35, imageName: DarkroomBackdrop.named(for: profile.stock)))
        .navigationTitle(Text(LocalizedStringKey(profile.stock.nameKey)))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroBlock: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(profile.stock.nameKey))
                    .font(.system(.largeTitle, design: .serif).weight(.bold))
                    .foregroundStyle(.white)
                Text(LocalizedStringKey(profile.manufacturerKey))
                    .font(.system(.subheadline, design: .monospaced).weight(.bold))
                    .foregroundStyle(Palette.silverEdge)
            }
            Spacer()
            Text("ISO \(profile.stock.nativeISO)")
                .font(.system(.title2, design: .serif).weight(.heavy))
                .foregroundStyle(profile.stock.tint)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Palette.anthracite)
        )
    }
}
