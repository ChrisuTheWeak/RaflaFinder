import Foundation

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    @Published var currentLanguage: String {
        didSet {
            userDefaults.setValue(currentLanguage, forKey: "appLanguage")
            print("Language changed to \(currentLanguage)")
        }
    }

    private let userDefaults = UserDefaults.standard

    private init() {
        currentLanguage = userDefaults.string(forKey: "appLanguage") ?? "en"
    }

    func changeLanguage() {
        currentLanguage = (currentLanguage == "en") ? "sv" : "en"
    }

    func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

