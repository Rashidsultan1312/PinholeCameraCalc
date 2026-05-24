import SwiftUI

enum FilmStock: String, CaseIterable, Codable, Identifiable {
    case hp5
    case trix
    case fomapan100
    case velvia50

    var id: String { rawValue }

    var nameKey: String { "film.\(rawValue).name" }
    var noteKey: String { "film.\(rawValue).note" }

    var schwarzschild: Double {
        switch self {
        case .hp5:        return 0.78
        case .trix:       return 0.85
        case .fomapan100: return 0.70
        case .velvia50:   return 0.65
        }
    }

    var nativeISO: Int {
        switch self {
        case .hp5: return 400
        case .trix: return 400
        case .fomapan100: return 100
        case .velvia50: return 50
        }
    }

    var tint: Color {
        switch self {
        case .hp5: return Color(red: 0.62, green: 0.52, blue: 0.30)
        case .trix: return Color(red: 0.40, green: 0.38, blue: 0.36)
        case .fomapan100: return Color(red: 0.55, green: 0.50, blue: 0.42)
        case .velvia50: return Color(red: 0.86, green: 0.28, blue: 0.22)
        }
    }
}

enum LightCondition: String, CaseIterable, Codable, Identifiable {
    case sunny
    case hazy
    case cloudy
    case overcast
    case sunset
    case indoor

    var id: String { rawValue }
    var titleKey: String { "light.\(rawValue)" }
    var symbol: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .hazy: return "sun.haze.fill"
        case .cloudy: return "cloud.fill"
        case .overcast: return "cloud.fog.fill"
        case .sunset: return "sun.horizon.fill"
        case .indoor: return "lightbulb.fill"
        }
    }

    var sunny16Multiplier: Double {
        switch self {
        case .sunny: return 1.0
        case .hazy: return 2.0
        case .cloudy: return 4.0
        case .overcast: return 8.0
        case .sunset: return 16.0
        case .indoor: return 64.0
        }
    }
}
