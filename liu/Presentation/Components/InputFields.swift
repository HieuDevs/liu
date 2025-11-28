import SwiftUI

struct CustomTextField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var themeManager: ThemeManager
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(themeManager.theme.colors.textSecondary)
                .frame(width: 20)
            
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .foregroundColor(themeManager.theme.colors.textPrimary)
        }
        .padding()
        .background(themeManager.theme.colors.surface)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct CustomSecureField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var themeManager: ThemeManager
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(themeManager.theme.colors.textSecondary)
                .frame(width: 20)
            
            SecureField(placeholder, text: $text)
                .foregroundColor(themeManager.theme.colors.textPrimary)
        }
        .padding()
        .background(themeManager.theme.colors.surface)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

