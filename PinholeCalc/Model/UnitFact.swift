import Foundation

struct PinholeFact: Identifiable, Hashable {
    var id: String { titleKey }
    let titleKey: String
    let bodyKey: String
    let symbol: String
}

enum PinholeFactCatalog {
    static let formulas: [PinholeFact] = [
        .init(titleKey: "formula.rayleigh.title", bodyKey: "formula.rayleigh.body", symbol: "function"),
        .init(titleKey: "formula.fstop.title",    bodyKey: "formula.fstop.body",    symbol: "camera.aperture"),
        .init(titleKey: "formula.sunny16.title",  bodyKey: "formula.sunny16.body",  symbol: "sun.max"),
        .init(titleKey: "formula.schwarzschild.title", bodyKey: "formula.schwarzschild.body", symbol: "clock.badge.exclamationmark")
    ]

    static let theory: [PinholeFact] = [
        .init(titleKey: "theory.history.title",  bodyKey: "theory.history.body",  symbol: "scroll"),
        .init(titleKey: "theory.diffraction.title", bodyKey: "theory.diffraction.body", symbol: "circle.dotted"),
        .init(titleKey: "theory.image.title",    bodyKey: "theory.image.body",    symbol: "rectangle.on.rectangle.angled"),
        .init(titleKey: "theory.depth.title",    bodyKey: "theory.depth.body",    symbol: "rectangle.stack")
    ]
}
