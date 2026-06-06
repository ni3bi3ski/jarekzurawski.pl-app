import SwiftUI

struct ContactView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    @State private var showConfirmation = false
    @State private var emailError = false
    @FocusState private var focusedField: ContactField?

    enum ContactField { case name, email, message }

    private var isEmailValid: Bool {
        let pattern = #"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }

    private var canSend: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        isEmailValid &&
        !message.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Zacznijmy rozmawiać")
                        .accentLabelStyle()
                    Text("Masz projekt?")
                        .font(.appTitle)
                        .foregroundColor(.appText)
                    Text("Napisz do mnie — odpiszę najszybciej jak mogę.")
                        .font(.appBody)
                        .foregroundColor(.appMuted)
                        .padding(.top, 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 32)

                // Direct contact
                VStack(spacing: 2) {
                    ContactLinkRow(
                        icon: "phone",
                        label: "Telefon",
                        value: "+48 572 116 577",
                        url: "tel:+48572116577"
                    )
                    ContactLinkRow(
                        icon: "envelope",
                        label: "Email",
                        value: "kontakt@jarekzurawski.pl",
                        url: "mailto:kontakt@jarekzurawski.pl"
                    )
                    ContactLinkRow(
                        icon: "camera.filters",
                        label: "Instagram",
                        value: "@ni3bi3ski",
                        url: "https://www.instagram.com/ni3bi3ski/"
                    )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)

                // Form
                VStack(alignment: .leading, spacing: 16) {
                    Text("Formularz kontaktowy")
                        .accentLabelStyle()
                        .padding(.bottom, 4)

                    AppTextField(
                        label: "Imię i nazwisko",
                        placeholder: "Jan Kowalski",
                        text: $name
                    )
                    .focused($focusedField, equals: .name)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .email }

                    VStack(alignment: .leading, spacing: 4) {
                        AppTextField(
                            label: "Adres email",
                            placeholder: "jan@firma.pl",
                            text: $email
                        )
                        .focused($focusedField, equals: .email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .message }
                        .onChange(of: email) { _ in
                            if emailError { emailError = false }
                        }

                        if emailError {
                            Text("Podaj prawidłowy adres email")
                                .font(.appMeta)
                                .foregroundColor(.red.opacity(0.8))
                                .transition(.opacity)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wiadomość")
                            .labelStyle()
                        TextEditor(text: $message)
                            .frame(minHeight: 100)
                            .padding(12)
                            .background(Color.appSurface)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(focusedField == .message ? Color.appAccent : Color.appBorder, lineWidth: 1)
                            )
                            .focused($focusedField, equals: .message)
                            .tint(.appAccent)
                            .scrollContentBackground(.hidden)
                            .font(.appBody)
                            .foregroundColor(.appText)
                    }

                    Button {
                        guard isEmailValid else {
                            withAnimation { emailError = true }
                            return
                        }
                        // Open mailto as actual send mechanism
                        let subject = "Zapytanie od \(name)"
                        let body = message
                        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        if let url = URL(string: "mailto:kontakt@jarekzurawski.pl?subject=\(encodedSubject)&body=\(encodedBody)") {
                            UIApplication.shared.open(url)
                        }
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            showConfirmation = true
                            name = ""
                            email = ""
                            message = ""
                            focusedField = nil
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation { showConfirmation = false }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if showConfirmation {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Otwarto klienta pocztowego")
                                    .font(.system(size: 15, weight: .semibold))
                            } else {
                                Text("Wyślij wiadomość")
                                    .font(.system(size: 15, weight: .semibold))
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 16)
                        .background(
                            showConfirmation ? Color.green.opacity(0.8) : Color.appAccent
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    .disabled(!canSend)
                    .opacity(canSend ? 1 : 0.5)
                    .animation(.easeInOut(duration: 0.2), value: canSend)
                }
                .padding(.horizontal, 24)

                // Location note
                HStack(spacing: 8) {
                    Image(systemName: "mappin")
                        .foregroundColor(.appAccent)
                        .font(.system(size: 14))
                    Text("Bielsko-Biała · Śląsk / Polska")
                        .font(.appBody)
                        .foregroundColor(.appMuted)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)

                Spacer(minLength: 80)
            }
        }
        .background(Color.appBG)
        .onTapGesture { focusedField = nil }
    }
}

struct ContactLinkRow: View {
    let icon: String
    let label: String
    let value: String
    let url: String

    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.appAccent)
                    .frame(width: 24)

                VStack(alignment: .leading, spacing: 2) {
                    Text(label)
                        .labelStyle()
                    Text(value)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.appText)
                }

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 12))
                    .foregroundColor(.appMuted)
            }
            .padding(16)
            .background(Color.appSurface)
            .overlay(Rectangle().stroke(Color.appBorder, lineWidth: 0.5))
        }
    }
}

struct AppTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .labelStyle()
            TextField(placeholder, text: $text)
                .padding(12)
                .background(Color.appSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.appBorder, lineWidth: 1)
                )
                .tint(.appAccent)
                .foregroundColor(.appText)
        }
    }
}
