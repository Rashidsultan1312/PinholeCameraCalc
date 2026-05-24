import SwiftUI

struct MainTabView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            CalcScreen()
                .tabItem { Label("tab.calcolo", systemImage: "camera.aperture") }
                .tag(0)
            DiarioScreen()
                .tabItem { Label("tab.diario", systemImage: "book.fill") }
                .tag(1)
            PellicoleScreen()
                .tabItem { Label("tab.pellicole", systemImage: "film") }
                .tag(2)
            RiferimentoScreen()
                .tabItem { Label("tab.riferimento", systemImage: "function") }
                .tag(3)
            SettingsScreen()
                .tabItem { Label("tab.impostazioni", systemImage: "gearshape.fill") }
                .tag(4)
        }
        .tint(Palette.accent)
    }
}
