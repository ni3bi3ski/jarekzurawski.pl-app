import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    enum Tab: String, CaseIterable {
        case home    = "house"
        case projects = "photo.on.rectangle"
        case services = "camera"
        case about   = "person"
        case contact = "envelope"

        var label: String {
            switch self {
            case .home: return "Start"
            case .projects: return "Projekty"
            case .services: return "Usługi"
            case .about: return "O mnie"
            case .contact: return "Kontakt"
            }
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:     HomeView()
                case .projects: ProjectsView()
                case .services: ServicesView()
                case .about:    AboutView()
                case .contact:  ContactView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(systemName: selectedTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                                .font(.system(size: 20, weight: selectedTab == tab ? .semibold : .regular))
                                .foregroundColor(selectedTab == tab ? .appAccent : .appMuted)
                                .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                            Text(tab.label)
                                .font(.system(size: 10, weight: selectedTab == tab ? .semibold : .regular))
                                .foregroundColor(selectedTab == tab ? .appAccent : .appMuted)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            .background(
                Color.appSurface
                    .overlay(
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(Color.appBorder),
                        alignment: .top
                    )
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .background(Color.appBG)
        .preferredColorScheme(.dark)
    }
}
