import SwiftUI
import Combine

struct HomeView: View {
    @State private var heroIndex = 0
    private let heroImages = Project.all.map { $0.imageURL }
    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // HERO
                    ZStack(alignment: .bottomLeading) {
                        ZStack {
                            ForEach(heroImages.indices, id: \.self) { i in
                                AsyncImage(url: URL(string: heroImages[i])) { img in
                                    img.resizable().scaledToFill()
                                } placeholder: {
                                    Color.appFaint
                                }
                                .opacity(i == heroIndex ? 1 : 0)
                                .animation(.easeInOut(duration: 1.2), value: heroIndex)
                            }
                        }
                        .frame(height: geo.size.height * 0.72)
                        .clipped()
                        .overlay(
                            LinearGradient(
                                colors: [.clear, .black.opacity(0.85)],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Jarek\nŻurawski")
                                .font(.system(size: 56, weight: .black, design: .default))
                                .foregroundColor(.appText)
                                .lineSpacing(-4)

                            Text("Ulica · Wydarzenia · Portrety")
                                .font(.appBody)
                                .foregroundColor(.appMuted)

                            HStack(spacing: 4) {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.appAccent)
                                Text("Bielsko-Biała · Śląsk")
                                    .font(.appMeta)
                                    .foregroundColor(.appMuted)
                            }
                            .padding(.top, 4)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    .frame(height: geo.size.height * 0.72)

                    // MARQUEE-style tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(["Fotografia uliczna", "Reportaż z wydarzeń", "Portret editorial", "Sony A7 IV", "Ricoh GRIII", "Bielsko-Biała", "Śląsk / Polska"], id: \.self) { tag in
                                HStack(spacing: 6) {
                                    Text("✦")
                                        .foregroundColor(.appAccent)
                                        .font(.system(size: 10))
                                    Text(tag)
                                        .font(.appMeta)
                                        .kerning(0.5)
                                        .foregroundColor(.appMuted)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                    }
                    .background(Color.appSurface)

                    // FEATURED PROJECT
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Wyróżniony projekt")
                            .accentLabelStyle()
                            .padding(.horizontal, 24)
                            .padding(.top, 40)
                            .padding(.bottom, 16)

                        if let featured = Project.all.last {
                            FeaturedProjectCard(project: featured)
                        }
                    }

                    // STATS
                    HStack(spacing: 0) {
                        StatView(number: "7+", label: "Lat praktyki")
                        Divider()
                            .background(Color.appBorder)
                            .frame(height: 48)
                        StatView(number: "200+", label: "Eventów")
                        Divider()
                            .background(Color.appBorder)
                            .frame(height: 48)
                        StatView(number: "2×", label: "Systemy")
                    }
                    .padding(.vertical, 32)
                    .background(Color.appSurface)

                    Spacer(minLength: 80)
                }
            }
        }
        .background(Color.appBG)
        .ignoresSafeArea(edges: .top)
        .onReceive(timer) { _ in
            withAnimation {
                heroIndex = (heroIndex + 1) % heroImages.count
            }
        }
    }
}

struct StatView: View {
    let number: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(number)
                .font(.system(size: 28, weight: .black))
                .foregroundColor(.appAccent)
            Text(label)
                .labelStyle()
        }
        .frame(maxWidth: .infinity)
    }
}

struct FeaturedProjectCard: View {
    let project: Project

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: project.imageURL)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                Color.appFaint.shimmer()
            }
            .frame(height: 240)
            .clipped()

            VStack(alignment: .leading, spacing: 12) {
                Text(project.title)
                    .font(.appSection)
                    .foregroundColor(.appText)

                Text("Reportaż z kultowego eventu ulicznego. Energia, ruch i kadry, które działy się tylko raz.")
                    .font(.appBody)
                    .foregroundColor(.appMuted)
                    .lineLimit(3)

                Link(destination: URL(string: project.url)!) {
                    HStack(spacing: 6) {
                        Text("Otwórz projekt")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.appAccent)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.appAccent)
                    }
                }
            }
            .padding(24)
            .background(Color.appSurface2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 0))
        .overlay(
            Rectangle()
                .stroke(Color.appBorder, lineWidth: 1)
        )
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
    }
}
