import Foundation

// MARK: - Design Tokens (mirroring style.css)
enum AppTheme {
    static let bg        = "#070707"
    static let text      = "#EDEAE3"
    static let muted     = "#706C65"
    static let faint     = "#343230"
    static let accent    = "#C8A352"
    static let border    = "rgba(255,255,255,0.06)"
}

// MARK: - Data Models
struct Project: Identifiable, Hashable {
    let id: Int
    let number: String
    let title: String
    let tag: String
    let url: String
    let imageURL: String
}

struct Service: Identifiable {
    let id: Int
    let number: String
    let title: String
    let description: String
    let price: String
}

struct FAQ: Identifiable {
    let id: Int
    let question: String
    let answer: String
}

struct ClientReview: Identifiable {
    let id: Int
    let text: String
    let author: String
}

// MARK: - Sample Data
extension Project {
    static let all: [Project] = [
        Project(id: 1, number: "01", title: "Sylwester Bielsko-Biała 25/26",
                tag: "Reportaż", url: "https://niebiezki.myportfolio.com/",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/d1a3c43f-dbc9-47b0-9f42-f532847b142a_rwc_0x1123x1365x769x1365.jpg?h=1055083717dcadb5010ca4b808729927"),
        Project(id: 2, number: "02", title: "Street Yourself 2",
                tag: "Ulica", url: "https://niebiezki.myportfolio.com/",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/4ebc0e4c-2479-48c8-b3eb-d5867ee9bb5d_rwc_0x508x1365x769x1365.jpg?h=2301dc38cae991b2d07e2d0b0bf1bdf2"),
        Project(id: 3, number: "03", title: "Rekord — Sokół · Betclic II liga",
                tag: "Sport", url: "https://niebiezki.myportfolio.com/",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/0bf760d5-d0ef-4a40-9062-1af3265fad7e_rwc_0x305x1638x923x1638.jpg?h=b8da8e5156b530baed52a416b1b99727"),
        Project(id: 4, number: "04", title: "PSK 2026 — Inauguracja",
                tag: "Event", url: "https://niebiezki.myportfolio.com/",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/07d83596-9fd8-4a69-aeda-dcefad48ffb9_car_16x9.jpg?h=cfee3d55dc9ef0fc78cadea689acf54e"),
        Project(id: 5, number: "05", title: "Mistrzostwa Polski Roasters 2025",
                tag: "Reportaż", url: "https://niebiezki.myportfolio.com/",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/406e456c-f088-4069-a7d1-accf2fd26249_rwc_0x96x1920x1082x1920.jpg?h=8ad1e6aa8f30a5b7319024abaa1dca74"),
        Project(id: 6, number: "06", title: "Marsz Równości — Bielsko-Biała 2025",
                tag: "Dokument", url: "https://niebiezki.myportfolio.com/",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/abb051f4-5ac9-4baa-8044-54693c335c1d_rwc_0x756x1365x769x1365.jpg?h=196e57710072ceadc534c0a5dbb14d5e"),
        Project(id: 7, number: "07", title: "Sportsy",
                tag: "Ulica", url: "https://niebiezki.myportfolio.com/sportsy",
                imageURL: "https://cdn.myportfolio.com/c707dd54-58cb-4c19-95f2-7e640d370fe9/838e1451-a9b9-465d-bbbf-2ad22f272d52_rwc_0x639x1365x769x1365.jpg?h=0ad53312dd4d806a7fe004ae34f6ab51"),
    ]
}

extension Service {
    static let all: [Service] = [
        Service(id: 1, number: "01", title: "Reportaż z wydarzeń",
                description: "Koncerty, eventy kulturalne, backstage, sport i dokument miejsca. Rejestruję to, co dzieje się naprawdę — bez inscenizacji i bez nadęcia.",
                price: "od 450 zł"),
        Service(id: 2, number: "02", title: "Portret editorial",
                description: "Sesje miejskie dla twórców, muzyków i marek osobistych. Pracuję tam, gdzie są napięcie, faktura i prawdziwe światło.",
                price: "od 400 zł"),
        Service(id: 3, number: "03", title: "Materiał promocyjny",
                description: "Zdjęcia do social mediów, stron i publikacji online. Mają wyglądać świeżo, mocno i naturalnie — bez plastikowego efektu.",
                price: "od 600 zł"),
    ]
}

extension FAQ {
    static let all: [FAQ] = [
        FAQ(id: 1, question: "Jak szybko dostarczasz zdjęcia?",
            answer: "Standardowo do 7 dni roboczych od realizacji. Przy większych projektach — do 14 dni. Termin ustalamy przed zleceniem."),
        FAQ(id: 2, question: "Czy wyjeżdżasz poza Bielsko-Białą?",
            answer: "Tak — pracuję na Śląsku i w całej Polsce. Dojazd poza aglomerację wliczam w wycenę lub ustalamy indywidualnie."),
        FAQ(id: 3, question: "W jakim formacie dostarczasz pliki?",
            answer: "Zdjęcia dostarczam jako JPG w wysokiej rozdzielczości, gotowe do druku i social mediów. Na życzenie również TIFF lub RAW."),
        FAQ(id: 4, question: "Ile zdjęć wchodzi w pakiet?",
            answer: "Przy evencie od 80 do 200+ gotowych ujęć, przy sesji portretowej 20–40. Szczegóły ustalamy przed realizacją."),
        FAQ(id: 5, question: "Jak wygląda rezerwacja terminu?",
            answer: "Przez SMS, Instagram lub formularz na stronie. Termin potwierdzam po wpłacie zaliczki."),
    ]
}

extension ClientReview {
    static let all: [ClientReview] = [
        ClientReview(id: 1,
            text: "Nie jest łatwo znaleźć kogoś z tak dobrym okiem do kadrów i skillem do złapania dobrego momentu. Świetna współpraca; szybki kontakt, krótki czas oczekiwania na zdjęcia oraz, co ważne — przyjemna, swobodna atmosfera. Zdecydowanie warto.",
            author: "Klient"),
    ]
}
