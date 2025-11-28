import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var localizationService = LocalizationService.shared
    @State private var showLanguageSheet = false
    
    // Mock data for dashboard
    let dashboardItems = [
        DashboardItem(icon: "person.circle.fill", title: "Profile", color: .blue),
        DashboardItem(icon: "bell.fill", title: "Notifications", color: .orange),
        DashboardItem(icon: "message.fill", title: "Messages", color: .green),
        DashboardItem(icon: "gearshape.fill", title: "Settings", color: .purple)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                themeManager.theme.colors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Welcome Card
                        welcomeCard
                        
                        // Dashboard Grid
                        dashboardGrid
                        
                        // Content Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Preferences")
                                .font(themeManager.theme.fonts.headline)
                                .foregroundStyle(themeManager.theme.colors.textSecondary)
                                .padding(.horizontal)
                            
                            // Language Selection
                            languageSelector
                            
                            // Theme Selection
                            themeSelector
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var welcomeCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome back,")
                    .font(themeManager.theme.fonts.headline)
                    .foregroundColor(.white.opacity(0.9))
                Text("Boss Hieu")
                    .font(themeManager.theme.fonts.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.white)
        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [themeManager.theme.colors.primary, themeManager.theme.colors.secondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: themeManager.theme.colors.primary.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    private var dashboardGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(dashboardItems, id: \.title) { item in
                VStack(spacing: 12) {
                    Circle()
                        .fill(item.color.opacity(0.1))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: item.icon)
                                .font(.title2)
                                .foregroundColor(item.color)
                        )
                    
                    Text(item.title)
                        .font(themeManager.theme.fonts.body)
                        .fontWeight(.medium)
                        .foregroundColor(themeManager.theme.colors.textPrimary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(themeManager.theme.colors.surface)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
            }
        }
        .padding(.horizontal)
    }
    
    private var languageSelector: some View {
        VStack(spacing: 0) {
            ForEach(Language.allCases, id: \.id) { language in
                LanguageRow(
                    language: language,
                    isSelected: localizationService.language == language,
                    action: {
                        withAnimation {
                            localizationService.setLanguage(language)
                        }
                    }
                )
                
                if language != Language.allCases.last {
                    Divider()
                        .padding(.leading, 50)
                }
            }
        }
        .background(themeManager.theme.colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    private var themeSelector: some View {
        VStack(spacing: 0) {
            ForEach(ThemeMode.allCases) { mode in
                ThemeRow(
                    mode: mode,
                    isSelected: themeManager.themeMode == mode,
                    action: {
                        withAnimation {
                            themeManager.setThemeMode(mode)
                        }
                    }
                )
                
                if mode != ThemeMode.allCases.last {
                    Divider()
                        .padding(.leading, 50)
                }
            }
        }
        .background(themeManager.theme.colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct DashboardItem {
    let icon: String
    let title: String
    let color: Color
}

struct LanguageRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let language: Language
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Circle()
                    .fill(isSelected ? themeManager.theme.colors.primary : Color.gray.opacity(0.1))
                    .frame(width: 24, height: 24)
                    .overlay {
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.caption2.bold())
                                .foregroundColor(.white)
                        }
                    }
                
                Text(language.displayName)
                    .font(themeManager.theme.fonts.body)
                    .foregroundStyle(themeManager.theme.colors.textPrimary)
                
                Spacer()
                
                if isSelected {
                    Text(Constants.LocalizationKeys.currentLanguage.localized)
                        .font(themeManager.theme.fonts.caption)
                        .foregroundStyle(themeManager.theme.colors.textSecondary)
                }
            }
            .padding()
            .background(themeManager.theme.colors.surface)
        }
        .buttonStyle(.plain)
    }
}

struct ThemeRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let mode: ThemeMode
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Circle()
                    .fill(isSelected ? themeManager.theme.colors.primary : Color.gray.opacity(0.1))
                    .frame(width: 24, height: 24)
                    .overlay {
                        if isSelected {
                            Image(systemName: "checkmark")
                                .font(.caption2.bold())
                                .foregroundColor(.white)
                        }
                    }
                
                Text(mode.title)
                    .font(themeManager.theme.fonts.body)
                    .foregroundStyle(themeManager.theme.colors.textPrimary)
                
                Spacer()
            }
            .padding()
            .background(themeManager.theme.colors.surface)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}
