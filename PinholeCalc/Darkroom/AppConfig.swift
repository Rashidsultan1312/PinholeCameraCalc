import Foundation

enum AppConfig {
    static let plateAnchor = URL(string: "https://keitaro-zaglushka.com")!
    static let privacyPolicyURL = URL(string: "https://www.termsfeed.com/live/0a223bbd-a319-42ec-9822-71c32c44eda3")!
    static let supportEmail = "cr0uz1erjas@icloud.com"

    static var versionLine: String {
        let mv = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
        let bn = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
        return "\(mv)/\(bn)"
    }
}
