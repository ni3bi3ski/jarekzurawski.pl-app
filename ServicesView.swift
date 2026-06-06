import SwiftUI

struct ServicesView: View {
    @State private var expandedFAQ: Int? = nil

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Co robię")
                        .accentLabelStyle()
                    Text("Usługi i cennik")
                        .font(.appTitle)
                        .foregroundColor(.appText)
                    Text("Krótko: jeśli chcesz zdjęcia z charakterem, odezwij się i sprawdzimy termin.")
                        .font(.appBody)
                        .foregroundColor(.appMuted)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 32)

                // Services
                VStack(spacing: 2) {
                    ForEach(Service.all) { service in
                        ServiceRow(service: service)
                    }
                }

                // Note
                Text("Większe wydarzenia, dłuższa obecność na miejscu i niestandardowe projekty wyceniam indywidualnie po krótkim briefie.")
                    .font(.appBody)
                    .foregroundColor(.appMuted)
                    .padding(24)
                    .background(Color.appSurface)
                    .padding(.top, 2)

                // Why it works
                VStack(alignment: .leading, spacing: 0) {
                    Text("Dlaczego to działa")
                        .accentLabelStyle()
                        .padding(.bottom, 16)

                    Text("Szybko, naturalnie, konkretnie")
                        .font(.appSection)
                        .foregroundColor(.appText)
                        .padding(.bottom, 20)

                    VStack(spacing: 12) {
                        BulletRow(number: "01", text: "Jasny kontakt i szybka odpowiedź.")
                        BulletRow(number: "02", text: "Reportaż, portret i materiał promocyjny.")
                        BulletRow(number: "03", text: "Bielsko-Biała, Śląsk i wyjazdy dalej.")
                    }
                }
                .padding(24)

                // FAQ
                VStack(alignment: .leading, spacing: 0) {
                    Text("FAQ")
                        .accentLabelStyle()
                        .padding(.bottom, 4)
                    Text("Często zadawane pytania")
                        .font(.appTitle)
                        .foregroundColor(.appText)
                        .padding(.bottom, 20)

                    VStack(spacing: 2) {
                        ForEach(FAQ.all) { faq in
                            FAQRow(faq: faq, isExpanded: expandedFAQ == faq.id) {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                    expandedFAQ = expandedFAQ == faq.id ? nil : faq.id
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)

                Spacer(minLength: 80)
            }
        }
        .background(Color.appBG)
    }
}

struct ServiceRow: View {
    let service: Service

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Text(service.number)
                .font(.system(size: 11, weight: .medium))
                .kerning(1)
                .foregroundColor(.appAccent)
                .frame(width: 24)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text(service.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.appText)

                Text(service.description)
                    .font(.appBody)
                    .foregroundColor(.appMuted)
                    .lineLimit(nil)
            }

            Spacer()

            Text(service.price)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.appAccent)
                .multilineTextAlignment(.trailing)
        }
        .padding(20)
        .background(Color.appSurface)
        .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 0.5))
    }
}

struct BulletRow: View {
    let number: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Text(number)
                .font(.system(size: 10, weight: .medium))
                .kerning(1)
                .foregroundColor(.appAccent)
                .frame(width: 20)
            Text(text)
                .font(.appBody)
                .foregroundColor(.appMuted)
            Spacer()
        }
    }
}

struct FAQRow: View {
    let faq: FAQ
    let isExpanded: Bool
    let onToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: onToggle) {
                HStack {
                    Text(faq.question)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.appText)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.appAccent)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isExpanded)
                }
                .padding(.vertical, 16)
            }
            .buttonStyle(.plain)

            if isExpanded {
                Text(faq.answer)
                    .font(.appBody)
                    .foregroundColor(.appMuted)
                    .padding(.bottom, 16)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }

            Divider().background(Color.appBorder)
        }
    }
}
