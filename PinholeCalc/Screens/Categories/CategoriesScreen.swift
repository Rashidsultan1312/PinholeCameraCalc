import SwiftUI

struct PellicoleScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(FilmProfileCatalog.all) { profile in
                        NavigationLink(destination: FilmDetailView(profile: profile)) {
                            FilmCard(profile: profile)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
            }
            .background(DarkroomCanvas(opacity: 0.32, imageName: "Backdrops/bd-film-canister"))
            .navigationTitle("tab.pellicole")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
