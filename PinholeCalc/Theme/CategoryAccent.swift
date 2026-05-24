import SwiftUI

enum FilmAccent {
    static func tint(for film: FilmStock) -> Color { film.tint }
    static func surface(for film: FilmStock) -> Color { film.tint.opacity(0.13) }
}
