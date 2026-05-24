import Foundation

struct FilmProfile: Identifiable, Hashable {
    var id: String { stock.rawValue }
    let stock: FilmStock
    let manufacturerKey: String
    let detailsKey: String
    let bestForKey: String
}

enum FilmProfileCatalog {
    static let all: [FilmProfile] = [
        .init(stock: .hp5,
              manufacturerKey: "film.hp5.manufacturer",
              detailsKey: "film.hp5.details",
              bestForKey: "film.hp5.bestfor"),
        .init(stock: .trix,
              manufacturerKey: "film.trix.manufacturer",
              detailsKey: "film.trix.details",
              bestForKey: "film.trix.bestfor"),
        .init(stock: .fomapan100,
              manufacturerKey: "film.fomapan100.manufacturer",
              detailsKey: "film.fomapan100.details",
              bestForKey: "film.fomapan100.bestfor"),
        .init(stock: .velvia50,
              manufacturerKey: "film.velvia50.manufacturer",
              detailsKey: "film.velvia50.details",
              bestForKey: "film.velvia50.bestfor")
    ]

    static func profile(for stock: FilmStock) -> FilmProfile {
        all.first { $0.stock == stock } ?? all[0]
    }
}
