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
        .task {
            await checkLoginStatus()
        }
    }

    private func checkLoginStatus() async {
        // Small delay to ensure UI is ready or show splash briefly if desired
        // try? await Task.sleep(nanoseconds: 500_000_000)

        if await diContainer.authRepository.getCurrentUser() != nil {
            router.setRoot(.home)
        } else {
            router.setRoot(.signIn)
        }
    }

    @ViewBuilder
    private func build(_ route: AppRoute) -> some View {
        switch route {
        case .splash:
            ProgressView()  // Or a dedicated SplashView
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
        HomeView(viewModel: diContainer.makeHomeViewModel())
            .overlay(alignment: .topTrailing) {
                Button(Constants.LocalizationKeys.logout.localized) {
                    Task {
                        try? await diContainer.authRepository.signOut()
                        router.setRoot(.signIn)
                    }
                }
                .padding()
            }
    }
}
