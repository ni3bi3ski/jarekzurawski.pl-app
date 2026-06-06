import SwiftUI

struct AboutView: View {
    let gear: [(String, String)] = [
        ("camera", "Sony A7 IV"),
        ("camera", "Ricoh GRIII"),
        ("circle.dashed", "Sigma Art 24–70mm"),
        ("circle.dashed", "Sigma Art 85mm"),
        ("circle.dashed", "Sigma Art 20mm"),
        ("bolt", "Godox TT685II"),
    ]

    let reviews = ClientReview.all

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // Hero photo area
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/ni3bi3ski/ni3bi3ski.github.io/main/DSC08526.jpg")) { img in
                        img.resizable().scaledToFill()
                    } placeholder: {
                        Color.appFaint.shimmer()
                    }
                    .frame(height: 300)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            colors: [.clear, Color.appBG],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
                }

                // About text
                VStack(alignment: .leading, spacing: 16) {
                    Text("O mnie")
                        .accentLabelStyle()

                    Text("Łapię momenty\nzanim znikną")
                        .font(.appTitle)
                        .foregroundColor(.appText)
                        .lineSpacing(2)

                    Text("Pracuję szybko, uważnie i bez sztucznego ustawiania sceny.\n\nNajbardziej interesuje mnie światło, gest i prawda miejsca. Szukam kadrów, które mają energię, ciężar i zostają w pamięci dłużej niż kilka sekund.")
                        .font(.appBody)
                        .foregroundColor(.appMuted)
                        .lineSpacing(4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 32)

                // Gear section
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sprzęt")
                        .accentLabelStyle()

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(gear.indices, id: \.self) { i in
                            HStack(spacing: 10) {
                                Image(systemName: gear[i].0)
                                    .font(.system(size: 13))
                                    .foregroundColor(.appAccent)
                                    .frame(width: 20)
                                Text(gear[i].1)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.appText)
                                Spacer()
                            }
                            .padding(12)
                            .background(Color.appSurface)
                            .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)

                // Reviews
                VStack(alignment: .leading, spacing: 16) {
                    Text("Referencje")
                        .accentLabelStyle()
                    Text("Opinie klientów")
                        .font(.appSection)
                        .foregroundColor(.appText)

                    ForEach(reviews) { review in
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: "quote.opening")
                                .font(.system(size: 24))
                                .foregroundColor(.appAccent.opacity(0.5))

                            Text(review.text)
                                .font(.appBody)
                                .foregroundColor(.appText)
                                .lineSpacing(4)

                            Text("— \(review.author)")
                                .font(.appMeta)
                                .foregroundColor(.appMuted)
                        }
                        .padding(20)
                        .background(Color.appSurface)
                        .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 0.5))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)

                // Social links
                VStack(alignment: .leading, spacing: 12) {
                    Text("Social")
                        .accentLabelStyle()

                    Link(destination: URL(string: "https://www.instagram.com/ni3bi3ski/")!) {
                        HStack {
                            Image(systemName: "camera.filters")
                                .foregroundColor(.appAccent)
                            Text("@ni3bi3ski")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.appText)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(.appMuted)
                        }
                        .padding(16)
                        .background(Color.appSurface)
                        .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 0.5))
                    }

                    Link(destination: URL(string: "https://niebiezki.myportfolio.com/")!) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .foregroundColor(.appAccent)
                            Text("Portfolio Adobe")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.appText)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(.appMuted)
                        }
                        .padding(16)
                        .background(Color.appSurface)
                        .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 0.5))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 80)
            }
        }
        .background(Color.appBG)
        .ignoresSafeArea(edges: .top)
    }
}
