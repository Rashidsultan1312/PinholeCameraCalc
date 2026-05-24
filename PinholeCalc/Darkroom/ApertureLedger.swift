import Foundation
import UIKit
@preconcurrency import WebKit

enum ExposureReading: Equatable {
    case slipped(URL)
    case held
    case fogged
}

enum ApertureLedger {
    @MainActor
    static func meter() async -> ExposureReading {
        await PlateAssistant().expose()
    }

    static func strip(_ url: URL) -> String {
        var comps = URLComponents(url: url, resolvingAgainstBaseURL: true) ?? URLComponents()
        comps.fragment = nil
        comps.scheme = (comps.scheme ?? "https").lowercased()
        comps.host = comps.host?.lowercased()
        var t = comps.path
        while t.count > 1 && t.hasSuffix("/") { t.removeLast() }
        comps.path = t
        return comps.url?.absoluteString ?? url.absoluteString.lowercased()
    }
}

@MainActor
final class PlateAssistant: NSObject, WKNavigationDelegate {
    private var await_: CheckedContinuation<ExposureReading, Never>?
    private var emulsion: WKWebView?
    private var fixed = false
    private var meterTask: Task<Void, Never>?

    func expose() async -> ExposureReading {
        await withCheckedContinuation { box in
            await_ = box
            let recipe = WKWebViewConfiguration()
            recipe.websiteDataStore = .nonPersistent()
            let plate = WKWebView(frame: CGRect(x: 0, y: 0, width: 6, height: 6), configuration: recipe)
            plate.alpha = 0.035
            plate.navigationDelegate = self
            plate.load(URLRequest(url: AppConfig.plateAnchor))
            emulsion = plate
            meterTask = Task { [weak self] in
                try? await Task.sleep(nanoseconds: 10_500_000_000)
                await MainActor.run { self?.develop(.fogged) }
            }
        }
    }

    private func develop(_ reading: ExposureReading) {
        if fixed { return }
        fixed = true
        meterTask?.cancel()
        emulsion?.navigationDelegate = nil
        emulsion?.stopLoading()
        emulsion = nil
        await_?.resume(returning: reading)
        await_ = nil
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let target = navigationAction.request.url else {
            decisionHandler(.allow); return
        }
        let original = AppConfig.plateAnchor
        if ApertureLedger.strip(target) != ApertureLedger.strip(original) {
            decisionHandler(.cancel)
            develop(.slipped(target))
            return
        }
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Task { @MainActor [weak self] in
            try? await Task.sleep(nanoseconds: 2_500_000_000)
            guard let self = self, !self.fixed else { return }
            self.develop(.held)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        _ = error; develop(.fogged)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        _ = error; develop(.fogged)
    }
}
