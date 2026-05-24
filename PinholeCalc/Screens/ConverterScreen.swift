import SwiftUI

struct CalcScreen: View {
    @EnvironmentObject private var log: ExposureLog
    @State private var note: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    heroResult
                    focalCard
                    filmCard
                    conditionCard
                    isoCard
                    noteCard
                    saveButton
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
            .background(DarkroomCanvas(opacity: 0.35, imageName: DarkroomBackdrop.named(for: log.film)))
            .navigationTitle("tab.calcolo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var heroResult: some View {
        let calc = log.current
        return ZStack {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Palette.anthracite)
            VStack(alignment: .leading, spacing: 16) {
                Text("calc.result.title".asKey)
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                    .foregroundStyle(Palette.silverEdge)
                    .textCase(.uppercase)
                    .kerning(1.5)
                HStack(alignment: .firstTextBaseline) {
                    Text(ExposureFormatter.seconds(calc.schwarzschildSeconds))
                        .font(.system(size: 42, weight: .black, design: .serif))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "clock.badge.exclamationmark")
                        .font(.title2)
                        .foregroundStyle(Palette.safelight)
                }
                Divider().background(Palette.silverEdge.opacity(0.3))
                HStack(spacing: 22) {
                    metric(labelKey: "calc.result.diameter", value: ExposureFormatter.diameter(calc.optimalDiameterMm))
                    metric(labelKey: "calc.result.fstop", value: ExposureFormatter.fStop(calc.fStop))
                }
                Text(String(format: NSLocalizedString("calc.result.metered", comment: ""),
                            ExposureFormatter.seconds(calc.meteredSeconds)))
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(Palette.silverEdge.opacity(0.8))
            }
            .padding(22)
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topLeading) {
            Rectangle()
                .fill(Palette.safelight)
                .frame(width: 14, height: 14)
                .rotationEffect(.degrees(45))
                .offset(x: -4, y: -4)
        }
    }

    private func metric(labelKey: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(labelKey.asKey)
                .font(.system(.caption2, design: .monospaced))
                .foregroundStyle(Palette.silverEdge.opacity(0.7))
                .textCase(.uppercase)
                .kerning(1.0)
            Text(value)
                .font(.system(.title3, design: .serif).weight(.semibold))
                .foregroundStyle(.white)
        }
    }

    private var focalCard: some View {
        RoundedCard {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("calc.focal.title".asKey).upperLabel()
                    Spacer()
                    Text(String(format: "%.0f mm", log.focal))
                        .font(.system(.title3, design: .serif).weight(.bold))
                        .foregroundStyle(Palette.accent)
                }
                Slider(value: $log.focal, in: 25...300, step: 5) {
                    Text("calc.focal.title".asKey)
                } minimumValueLabel: {
                    Text("25").font(.caption2).foregroundStyle(.secondary)
                } maximumValueLabel: {
                    Text("300").font(.caption2).foregroundStyle(.secondary)
                }
                .tint(Palette.accent)
            }
        }
    }

    private var filmCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("calc.film.title".asKey).upperLabel().padding(.horizontal, 4)
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                ForEach(FilmStock.allCases) { stock in
                    Button {
                        log.film = stock
                        log.iso = stock.nativeISO
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Image(systemName: "film")
                                    .foregroundStyle(stock.tint)
                                Spacer()
                                if log.film == stock {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Palette.accent)
                                }
                            }
                            Text(LocalizedStringKey(stock.nameKey))
                                .font(.system(.subheadline, design: .serif).weight(.bold))
                                .foregroundStyle(.primary)
                            Text("ISO \(stock.nativeISO)")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(stock.tint)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(log.film == stock ? stock.tint.opacity(0.18) : Palette.cardFill)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(log.film == stock ? stock.tint : .clear, lineWidth: 1.5)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var conditionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("calc.condition.title".asKey).upperLabel().padding(.horizontal, 4)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(LightCondition.allCases) { cond in
                        ChipButton(LocalizedStringKey(cond.titleKey),
                                   symbol: cond.symbol,
                                   selected: cond == log.condition) {
                            log.condition = cond
                        }
                    }
                }
            }
        }
    }

    private var isoCard: some View {
        RoundedCard {
            HStack {
                Text("calc.iso.title".asKey).upperLabel()
                Spacer()
                Stepper("ISO \(log.iso)", value: $log.iso, in: 25...3200, step: log.iso < 100 ? 25 : (log.iso < 400 ? 50 : 100))
                    .labelsHidden()
                Text("ISO \(log.iso)")
                    .font(.system(.title3, design: .serif).weight(.bold))
                    .foregroundStyle(Palette.accent)
            }
        }
    }

    private var noteCard: some View {
        RoundedCard {
            VStack(alignment: .leading, spacing: 6) {
                Text("calc.note.title".asKey).upperLabel()
                TextField("calc.note.placeholder".asKey, text: $note)
                    .font(.subheadline)
            }
        }
    }

    private var saveButton: some View {
        Button {
            log.save(note: note)
            note = ""
            Haptics.success()
        } label: {
            Label("calc.save", systemImage: "tray.and.arrow.down.fill")
                .font(.system(.headline, design: .serif).weight(.bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Palette.accent, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .foregroundStyle(.white)
        }
    }
}

extension String {
    var asKey: LocalizedStringKey { LocalizedStringKey(self) }
}
