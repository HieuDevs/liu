import SwiftUI

protocol ThemeColors {
    var primary: Color { get }
    var secondary: Color { get }
    var background: Color { get }
    var surface: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var error: Color { get }
    var success: Color { get }
}

struct LightThemeColors: ThemeColors {
    let primary = Color.blue
    let secondary = Color.cyan
    let background = Color.white
    let surface = Color(white: 0.95)
    let textPrimary = Color.black
    let textSecondary = Color.gray
    let error = Color.red
    let success = Color.green
}

struct DarkThemeColors: ThemeColors {
    let primary = Color.blue
    let secondary = Color.cyan
    let background = Color.black
    let surface = Color(white: 0.1)
    let textPrimary = Color.white
    let textSecondary = Color.gray
    let error = Color.red
    let success = Color.green
}

