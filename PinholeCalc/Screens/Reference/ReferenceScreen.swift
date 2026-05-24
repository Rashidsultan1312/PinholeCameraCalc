import SwiftUI

struct RiferimentoScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    SectionHeader("riferimento.formulas")
                    VStack(spacing: 10) {
                        ForEach(PinholeFactCatalog.formulas) { fact in
                            FormulaCard(fact: fact)
                        }
                    }
                    SectionHeader("riferimento.theory")
                    VStack(spacing: 10) {
                        ForEach(PinholeFactCatalog.theory) { fact in
                            FormulaCard(fact: fact)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
            .background(DarkroomCanvas(opacity: 0.32, imageName: "Backdrops/bd-darkroom-clock"))
            .navigationTitle("tab.riferimento")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
