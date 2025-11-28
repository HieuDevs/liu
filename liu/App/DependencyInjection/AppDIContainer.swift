import Foundation

class AppDIContainer: ObservableObject {
    let themeManager: ThemeManager
    let authRepository: AuthRepository
    let signInUseCase: SignInUseCase
    let signUpUseCase: SignUpUseCase

    init() {
        self.themeManager = ThemeManager()

        let authDataSource = FakeAuthDataSource()
        self.authRepository = AuthRepositoryImpl(dataSource: authDataSource)

        self.signInUseCase = SignInUseCaseImpl(repository: authRepository)
        self.signUpUseCase = SignUpUseCaseImpl(repository: authRepository)
    }

    @MainActor func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(signInUseCase: signInUseCase)
    }

    @MainActor func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(signUpUseCase: signUpUseCase)
    }

    @MainActor func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(authRepository: authRepository)
    }
}
