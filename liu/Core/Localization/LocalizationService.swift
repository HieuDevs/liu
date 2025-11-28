import Foundation
import Combine

// MARK: - LocalizationServiceType
protocol LocalizationServiceType: ObservableObject {
    var language: Language { get }
    var bundle: Bundle { get }
    func setLanguage(_ newLanguage: Language)
}

enum Language: String, CaseIterable, Identifiable {
    case english = "en"
    case vietnamese = "vi"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .vietnamese: return "Tiếng Việt"
        }
    }
}

class LocalizationService: LocalizationServiceType {
    static let shared = LocalizationService()
    
    @Published private(set) var language: Language
    @Published private(set) var bundle: Bundle
    
    private init() {
        let savedLanguage = UserDefaults.standard.string(forKey: Constants.AppStorageKeys.selectedLanguage)
        let lang = Language(rawValue: savedLanguage ?? "") ?? .english
        self.language = lang
        self.bundle = Bundle.main // Fallback
        self.bundle = getBundle(for: lang)
    }
    
    func setLanguage(_ newLanguage: Language) {
        guard language != newLanguage else { return }
        
        language = newLanguage
        bundle = getBundle(for: newLanguage)
        
        UserDefaults.standard.set(newLanguage.rawValue, forKey: Constants.AppStorageKeys.selectedLanguage)
        UserDefaults.standard.set([newLanguage.rawValue], forKey: Constants.UserDefaultsKeys.appleLanguages)
        UserDefaults.standard.synchronize()
    }
    
    private func getBundle(for language: Language) -> Bundle {
        guard let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return .main
        }
        return bundle
    }
}
