import SwiftUI

struct AppCoordinator: View {
    @StateObject private var router = AppRouter()
    @StateObject private var diContainer = AppDIContainer()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            build(router.root)
                .navigationDestination(for: AppRoute.self) { route in
                    build(route)
                }
        }
        .environmentObject(diContainer.themeManager)
        .preferredColorScheme(diContainer.themeManager.preferredColorScheme)
    }
    
    @ViewBuilder
    private func build(_ route: AppRoute) -> some View {
        switch route {
        case .signIn:
            makeSignInView()
        case .signUp:
            makeSignUpView()
        case .home:
            makeHomeView()
        }
    }
    
    // MARK: - View Factories
    
    private func makeSignInView() -> some View {
        SignInView(
            viewModel: diContainer.makeSignInViewModel(),
            onSignUpTap: {
                router.push(.signUp)
            },
            onLoginSuccess: {
                router.setRoot(.home)
            }
        )
    }
    
    private func makeSignUpView() -> some View {
        SignUpView(
            viewModel: diContainer.makeSignUpViewModel(),
            onSignInTap: {
                router.pop()
            },
            onSignUpSuccess: {
                router.setRoot(.home)
            }
        )
    }
    
    private func makeHomeView() -> some View {
        HomeView()
            .overlay(alignment: .topTrailing) {
                Button(Constants.LocalizationKeys.logout.localized) {
                    router.setRoot(.signIn)
                }
                .padding()
            }
    }
}
