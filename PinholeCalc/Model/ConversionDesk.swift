import SwiftUI

enum AppearanceMode: String, CaseIterable, Identifiable, Codable {
    case system
    case dark
    case light
    var id: String { rawValue }
    var label: LocalizedStringKey {
        switch self {
        case .system: return "appearance.system"
        case .dark:   return "appearance.dark"
        case .light:  return "appearance.light"
        }
    }
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .dark:   return .dark
        case .light:  return .light
        }
    }
}

struct ShotEntry: Identifiable, Codable, Hashable {
    let id: UUID
    var savedAt: Date
    var focalMm: Double
    var film: FilmStock
    var condition: LightCondition
    var iso: Int
    var note: String

    init(id: UUID = UUID(),
         savedAt: Date = Date(),
         focalMm: Double,
         film: FilmStock,
         condition: LightCondition,
         iso: Int,
         note: String = "") {
        self.id = id
        self.savedAt = savedAt
        self.focalMm = focalMm
        self.film = film
        self.condition = condition
        self.iso = iso
        self.note = note
    }

    var calculation: PinholeCalculation {
        PinholeCalculation(focalMm: focalMm, film: film, lightCondition: condition, iso: iso)
    }
}

@MainActor
final class ExposureLog: ObservableObject {
    @Published var focal: Double = 100 { didSet { persistPrefs() } }
    @Published var film: FilmStock = .hp5 { didSet { persistPrefs() } }
    @Published var condition: LightCondition = .sunny { didSet { persistPrefs() } }
    @Published var iso: Int = 400 { didSet { persistPrefs() } }
    @Published var appearance: AppearanceMode = .system { didSet { persistPrefs() } }
    @Published var shots: [ShotEntry] = [] { didSet { persistShots() } }

    private let defaults = UserDefaults.standard
    private let kFocal = "pc.pref.focal"
    private let kFilm = "pc.pref.film"
    private let kCond = "pc.pref.condition"
    private let kISO = "pc.pref.iso"
    private let kApp = "pc.pref.appearance"
    private let kShots = "pc.log.shots"

    init() { restore() }

    var current: PinholeCalculation {
        PinholeCalculation(focalMm: focal, film: film, lightCondition: condition, iso: iso)
    }

    func save(note: String) {
        let entry = ShotEntry(focalMm: focal, film: film, condition: condition, iso: iso, note: note)
        var bag = shots
        bag.insert(entry, at: 0)
        if bag.count > 40 { bag = Array(bag.prefix(40)) }
        shots = bag
    }

    func remove(at offsets: IndexSet) { shots.remove(atOffsets: offsets) }
    func wipe() { shots = [] }

    private func persistPrefs() {
        defaults.set(focal, forKey: kFocal)
        defaults.set(film.rawValue, forKey: kFilm)
        defaults.set(condition.rawValue, forKey: kCond)
        defaults.set(iso, forKey: kISO)
        defaults.set(appearance.rawValue, forKey: kApp)
    }

    private func persistShots() {
        if let data = try? JSONEncoder().encode(shots) {
            defaults.set(data, forKey: kShots)
        }
    }

    private func restore() {
        let storedFocal = defaults.double(forKey: kFocal)
        if storedFocal != 0 { focal = storedFocal }
        if let raw = defaults.string(forKey: kFilm), let f = FilmStock(rawValue: raw) { film = f }
        if let raw = defaults.string(forKey: kCond), let c = LightCondition(rawValue: raw) { condition = c }
        let storedISO = defaults.integer(forKey: kISO)
        if storedISO != 0 { iso = storedISO }
        if let raw = defaults.string(forKey: kApp), let a = AppearanceMode(rawValue: raw) { appearance = a }
        if let data = defaults.data(forKey: kShots),
           let decoded = try? JSONDecoder().decode([ShotEntry].self, from: data) {
            shots = decoded
        }
    }
}
