import SwiftUI

struct ProjectsView: View {
    @State private var selectedProject: Project? = nil
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wybrane prace")
                            .accentLabelStyle()
                        Text("Projekty")
                            .font(.appTitle)
                            .foregroundColor(.appText)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    .padding(.bottom, 24)

                    // Grid
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(Project.all) { project in
                            Button {
                                selectedProject = project
                            } label: {
                                ProjectGridCell(project: project)
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    // Portfolio link
                    Link(destination: URL(string: "https://niebiezki.myportfolio.com/")!) {
                        HStack {
                            Text("Pełne portfolio")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.appAccent)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundColor(.appAccent)
                        }
                        .padding(20)
                        .background(Color.appSurface)
                        .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 1))
                        .padding(24)
                        .padding(.top, 8)
                    }

                    Spacer(minLength: 80)
                }
            }
            .background(Color.appBG)
            .sheet(item: $selectedProject) { project in
                ProjectDetailSheet(project: project)
            }
        }
    }
}

struct ProjectGridCell: View {
    let project: Project
    @State private var loaded = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: project.imageURL)) { img in
                img.resizable().scaledToFill()
                    .onAppear { withAnimation { loaded = true } }
            } placeholder: {
                Color.appFaint.shimmer()
            }
            .frame(height: 180)
            .clipped()
            .overlay(
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .center,
                    endPoint: .bottom
                )
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(project.number)
                    .font(.system(size: 9, weight: .medium))
                    .kerning(1)
                    .foregroundColor(.appAccent)
                Text(project.title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.appText)
                    .lineLimit(2)
            }
            .padding(12)
        }
        .frame(height: 180)
        .scaleEffect(loaded ? 1 : 0.98)
    }
}

struct ProjectDetailSheet: View {
    let project: Project
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    AsyncImage(url: URL(string: project.imageURL)) { img in
                        img.resizable().scaledToFill()
                    } placeholder: {
                        Color.appFaint.shimmer()
                    }
                    .frame(height: 320)
                    .clipped()

                    VStack(alignment: .leading, spacing: 16) {
                        Text(project.number)
                            .accentLabelStyle()

                        Text(project.title)
                            .font(.appTitle)
                            .foregroundColor(.appText)

                        Text(project.tag)
                            .font(.appMeta)
                            .foregroundColor(.appMuted)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.appBorder, lineWidth: 1)
                            )

                        Divider().background(Color.appBorder)

                        Link(destination: URL(string: project.url)!) {
                            HStack {
                                Text("Otwórz w przeglądarce")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.appAccent)
                                Spacer()
                                Image(systemName: "arrow.up.right.square")
                                    .foregroundColor(.appAccent)
                            }
                            .padding(16)
                            .background(Color.appSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .padding(24)
                }
            }
            .background(Color.appBG)

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.appText)
                    .padding(10)
                    .background(Color.appSurface.opacity(0.9))
                    .clipShape(Circle())
            }
            .padding(20)
            .padding(.top, 8)
        }
        .preferredColorScheme(.dark)
    }
}
