import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel: SignInViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    // Callback to navigate to SignUp or handle success
    var onSignUpTap: () -> Void
    var onLoginSuccess: () -> Void
    
    init(viewModel: SignInViewModel, onSignUpTap: @escaping () -> Void, onLoginSuccess: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSignUpTap = onSignUpTap
        self.onLoginSuccess = onLoginSuccess
    }
    
    var body: some View {
        ZStack {
            // Background
            themeManager.theme.colors.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 40)
                    
                    // Logo / Title
                    VStack(spacing: 12) {
                        Image(systemName: "swift")
                            .font(.system(size: 80))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [themeManager.theme.colors.primary, themeManager.theme.colors.secondary],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .padding(.bottom, 10)
                        
                        Text(Constants.LocalizationKeys.signIn.localized)
                            .font(themeManager.theme.fonts.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.theme.colors.textPrimary)
                        
                        Text("Welcome back, Boss Hieu!")
                            .font(themeManager.theme.fonts.body)
                            .foregroundColor(themeManager.theme.colors.textSecondary)
                    }
                    .padding(.bottom, 20)
                    
                    // Inputs
                    VStack(spacing: 20) {
                        CustomTextField(
                            icon: "envelope.fill",
                            placeholder: Constants.LocalizationKeys.email.localized,
                            text: $viewModel.email,
                            keyboardType: .emailAddress,
                            themeManager: themeManager
                        )
                        
                        CustomSecureField(
                            icon: "lock.fill",
                            placeholder: Constants.LocalizationKeys.password.localized,
                            text: $viewModel.password,
                            themeManager: themeManager
                        )
                    }
                    .padding(.horizontal)
                    
                    // Error Message
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(themeManager.theme.fonts.caption)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .transition(.opacity)
                    }
                    
                    // Buttons
                    VStack(spacing: 16) {
                        Button(action: viewModel.signIn) {
                            ZStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text(Constants.LocalizationKeys.signIn.localized)
                                        .fontWeight(.semibold)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(
                                    colors: [themeManager.theme.colors.primary, themeManager.theme.colors.secondary],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(color: themeManager.theme.colors.primary.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .disabled(viewModel.isLoading)
                        
                        Button(action: onSignUpTap) {
                            HStack {
                                Text(Constants.LocalizationKeys.dontHaveAccount.localized)
                                    .foregroundColor(themeManager.theme.colors.textSecondary)
                                Text("Sign Up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(themeManager.theme.colors.primary)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onChange(of: viewModel.isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                onLoginSuccess()
            }
        }
    }
}

#Preview {
    let dataSource = FakeAuthDataSource()
    let repository = AuthRepositoryImpl(dataSource: dataSource)
    let useCase = SignInUseCaseImpl(repository: repository)
    let viewModel = SignInViewModel(signInUseCase: useCase)
    
    return SignInView(
        viewModel: viewModel,
        onSignUpTap: {},
        onLoginSuccess: {}
    )
    .environmentObject(ThemeManager())
}
