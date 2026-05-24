import Foundation

enum ExposureFormatter {
    static func diameter(_ mm: Double) -> String {
        if mm >= 1 { return String(format: "%.2f mm", mm) }
        return String(format: "%.3f mm", mm)
    }

    static func fStop(_ value: Double) -> String {
        if value >= 100 { return String(format: "f/%.0f", value) }
        return String(format: "f/%.1f", value)
    }

    static func seconds(_ value: Double) -> String {
        if value < 1 {
            let fraction = 1.0 / value
            return String(format: "1/%.0f s", fraction)
        }
        if value < 60 { return String(format: "%.1f s", value) }
        let minutes = Int(value / 60)
        let remainder = value - Double(minutes * 60)
        return String(format: "%d min %d s", minutes, Int(remainder))
    }
}
