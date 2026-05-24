import SwiftUI

struct DarkroomCanvas: View {
    var opacity: Double = 0.55
    var imageName: String = DarkroomBackdrop.primary

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.97)
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(opacity)
                .ignoresSafeArea()
            LinearGradient(colors: [Color.white.opacity(0.78), Color.white.opacity(0.86)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            LinearGradient(colors: [Palette.safelight.opacity(0.04), Color.clear],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct DarkroomScrim: View {
    let film: FilmStock
    var body: some View {
        FilmAccent.tint(for: film).opacity(0.08).ignoresSafeArea()
    }
}
