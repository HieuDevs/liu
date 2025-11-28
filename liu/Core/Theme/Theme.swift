import Foundation

protocol Theme {
    var colors: ThemeColors { get }
    var fonts: ThemeFonts { get }
}

struct LightTheme: Theme {
    let colors: ThemeColors = LightThemeColors()
    let fonts: ThemeFonts = AppThemeFonts()
}

struct DarkTheme: Theme {
    let colors: ThemeColors = DarkThemeColors()
    let fonts: ThemeFonts = AppThemeFonts()
}

enum ThemeMode: String, CaseIterable, Identifiable {
    case system
    case light
    case dark
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .system: return Constants.LocalizationKeys.themeSystem.localized
        case .light: return Constants.LocalizationKeys.themeLight.localized
        case .dark: return Constants.LocalizationKeys.themeDark.localized
        }
    }
}
