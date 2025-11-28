import SwiftUI
import Combine

final class ThemeManager: ObservableObject {
    @AppStorage("selected_theme_mode") var themeMode: ThemeMode = .system {
        didSet {
            updateTheme()
        }
    }
    
    @Published private(set) var theme: Theme = LightTheme()
    
    /// The color scheme that should be applied to the root view.
    /// Returns nil if system (default) behavior is desired.
    var preferredColorScheme: ColorScheme? {
        switch themeMode {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
    
    init() {
        updateTheme()
    }
    
    func setThemeMode(_ mode: ThemeMode) {
        self.themeMode = mode
    }
    
    func updateTheme(with colorScheme: ColorScheme? = nil) {
        switch themeMode {
        case .light:
            self.theme = LightTheme()
        case .dark:
            self.theme = DarkTheme()
        case .system:
            if let scheme = colorScheme {
                self.theme = (scheme == .dark) ? DarkTheme() : LightTheme()
            } else {
                // Fallback or initial state before View loads
                // Could check UITraitCollection.current.userInterfaceStyle but keeping it simple
                self.theme = LightTheme() 
            }
        }
    }
}
