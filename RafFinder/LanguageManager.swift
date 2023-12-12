import Foundation

class LanguageManager: ObservableObject {
    
    // Singleton instance of LanguageManager
    static let shared = LanguageManager()
    
    // Published property to track the current language
    @Published var currentLanguage: String {
        didSet {
            // Save the updated language to UserDefaults
            userDefaults.setValue(currentLanguage, forKey: "appLanguage")
            
            // Print a message indicating that the language has changed
            print("Language changed to \(currentLanguage)")
        }
    }

    // UserDefaults instance to persist the selected language
    private let userDefaults = UserDefaults.standard

    // Private initializer to enforce singleton pattern and set the initial language
    private init() {
        // Load the current language from UserDefaults or default to "en" (English)
        currentLanguage = userDefaults.string(forKey: "appLanguage") ?? "en"
    }

    // Function to toggle between English and Swedish languages
    func changeLanguage() {
        currentLanguage = (currentLanguage == "en") ? "sv" : "en"
    }

    // Function to translate a given key using NSLocalizedString
    func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

