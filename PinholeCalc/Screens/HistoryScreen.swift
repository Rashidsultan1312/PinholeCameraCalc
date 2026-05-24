import SwiftUI

struct DiarioScreen: View {
    @EnvironmentObject private var log: ExposureLog

    var body: some View {
        NavigationStack {
            Group {
                if log.shots.isEmpty {
                    ScrollView {
                        EmptyStateBox(symbol: "tray",
                                      titleKey: "diario.empty.title",
                                      messageKey: "diario.empty.body")
                            .padding(20)
                    }
                } else {
                    List {
                        ForEach(log.shots) { shot in
                            shotRow(shot)
                        }
                        .onDelete { log.remove(at: $0) }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .background(DarkroomCanvas(opacity: 0.32, imageName: "Backdrops/bd-contact-sheet"))
            .navigationTitle("tab.diario")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func shotRow(_ shot: ShotEntry) -> some View {
        let calc = shot.calculation
        return VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: "film")
                    .foregroundStyle(shot.film.tint)
                    .padding(6)
                    .background(shot.film.tint.opacity(0.15), in: Circle())
                Text(LocalizedStringKey(shot.film.nameKey))
                    .font(.system(.subheadline, design: .serif).weight(.bold))
                Spacer()
                Text(shot.savedAt, style: .date)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
            }
            HStack(spacing: 16) {
                Text(String(format: "%.0fmm", shot.focalMm))
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                Text("ISO \(shot.iso)")
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                Text(ExposureFormatter.fStop(calc.fStop))
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                Text(ExposureFormatter.seconds(calc.schwarzschildSeconds))
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                    .foregroundStyle(Palette.accent)
            }
            if !shot.note.isEmpty {
                Text(shot.note)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}
