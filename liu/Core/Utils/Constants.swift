import Foundation

enum Constants {
    enum AppStorageKeys {
        static let selectedLanguage = "selectedLanguage"
    }
    
    enum UserDefaultsKeys {
        static let appleLanguages = "AppleLanguages"
    }
    
    enum LocalizationKeys {
        static let helloWorld = "hello_world"
        static let changeLanguage = "change_language"
        static let currentLanguage = "current_language"
        static let welcomeMessage = "welcome_message"
        
        // Auth
        static let signIn = "sign_in"
        static let signUp = "sign_up"
        static let email = "email"
        static let password = "password"
        static let confirmPassword = "confirm_password"
        static let name = "name"
        static let dontHaveAccount = "dont_have_account"
        static let alreadyHaveAccount = "already_have_account"
        static let fillAllFields = "fill_all_fields"
        static let passwordsDoNotMatch = "passwords_do_not_match"
        static let logout = "logout"
        static let invalidCredentials = "invalid_credentials"
        static let userAlreadyExists = "user_already_exists"
        
        // Theme
        static let theme = "theme"
        static let themeSystem = "theme_system"
        static let themeLight = "theme_light"
        static let themeDark = "theme_dark"
    }
}
