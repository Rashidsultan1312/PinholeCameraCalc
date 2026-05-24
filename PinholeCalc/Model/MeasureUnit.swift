import Foundation

struct PinholeCalculation: Codable, Hashable {
    let focalMm: Double
    let film: FilmStock
    let lightCondition: LightCondition
    let iso: Int

    var optimalDiameterMm: Double {
        0.03659 * sqrt(focalMm)
    }

    var fStop: Double {
        focalMm / optimalDiameterMm
    }

    var meteredSeconds: Double {
        let isoTerm = Double(iso) * (256.0 / (fStop * fStop))
        let base = 1.0 / isoTerm
        return base * lightCondition.sunny16Multiplier
    }

    var schwarzschildSeconds: Double {
        let t = meteredSeconds
        if t <= 1 { return t }
        return pow(t, 1.0 / film.schwarzschild)
    }
}
