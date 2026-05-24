import Foundation

enum DarkroomBackdrop {
    static let names: [String] = [
        "Backdrops/bd-box-camera",
        "Backdrops/bd-light-meter",
        "Backdrops/bd-film-canister",
        "Backdrops/bd-120-spool",
        "Backdrops/bd-safelight",
        "Backdrops/bd-light-cone",
        "Backdrops/bd-sprocket",
        "Backdrops/bd-developing-tank",
        "Backdrops/bd-tripod-feet",
        "Backdrops/bd-contact-sheet",
        "Backdrops/bd-darkroom-clock",
        "Backdrops/bd-loupe-print",
        "Backdrops/bd-enlarger",
        "Backdrops/bd-negative-strip"
    ]

    static let primary = "Backdrops/bd-box-camera"

    static func named(for film: FilmStock) -> String {
        switch film {
        case .hp5:        return "Backdrops/bd-contact-sheet"
        case .trix:       return "Backdrops/bd-enlarger"
        case .fomapan100: return "Backdrops/bd-developing-tank"
        case .velvia50:   return "Backdrops/bd-negative-strip"
        }
    }
}
