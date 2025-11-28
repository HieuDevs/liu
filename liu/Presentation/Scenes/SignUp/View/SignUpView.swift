import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel: SignUpViewModel
    @EnvironmentObject var themeManager: ThemeManager

    var onSignInTap: () -> Void
    var onSignUpSuccess: () -> Void

    init(
        viewModel: SignUpViewModel, onSignInTap: @escaping () -> Void,
        onSignUpSuccess: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSignInTap = onSignInTap
        self.onSignUpSuccess = onSignUpSuccess
    }

    var body: some View {
        ZStack {
            // Background
            themeManager.theme.colors.background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 20)

                    // Header
                    VStack(spacing: 8) {
                        Text(Constants.LocalizationKeys.signUp.localized)
                            .font(themeManager.theme.fonts.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(themeManager.theme.colors.textPrimary)

                        Text("Create your account")
                            .font(themeManager.theme.fonts.body)
                            .foregroundColor(themeManager.theme.colors.textSecondary)
                    }
                    .padding(.bottom, 20)

                    // Inputs
                    VStack(spacing: 20) {
                        CustomTextField(
                            icon: "person.fill",
                            placeholder: Constants.LocalizationKeys.name.localized,
                            text: $viewModel.name,
                            themeManager: themeManager
                        )

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

                        CustomSecureField(
                            icon: "lock.shield.fill",
                            placeholder: Constants.LocalizationKeys.confirmPassword.localized,
                            text: $viewModel.confirmPassword,
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
                        Button(action: viewModel.signUp) {
                            ZStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .tint(.white)
                                } else {
                                    Text(Constants.LocalizationKeys.signUp.localized)
                                        .fontWeight(.semibold)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                LinearGradient(
                                    colors: [
                                        themeManager.theme.colors.primary,
                                        themeManager.theme.colors.secondary,
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .shadow(
                                color: themeManager.theme.colors.primary.opacity(0.3), radius: 10,
                                x: 0, y: 5)
                        }
                        .disabled(viewModel.isLoading)

                        Button(action: onSignInTap) {
                            HStack {
                                Text(Constants.LocalizationKeys.alreadyHaveAccount.localized)
                                    .foregroundColor(themeManager.theme.colors.textSecondary)
                                Text(Constants.LocalizationKeys.signIn.localized)
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
        .onChange(of: viewModel.isRegistered) { _, isRegistered in
            if isRegistered {
                onSignUpSuccess()
            }
        }
    }
}

#Preview {
    let dataSource = FakeAuthDataSource()
    let repository = AuthRepositoryImpl(dataSource: dataSource)
    let useCase = SignUpUseCaseImpl(repository: repository)
    let viewModel = SignUpViewModel(signUpUseCase: useCase)

    return SignUpView(
        viewModel: viewModel,
        onSignInTap: {},
        onSignUpSuccess: {}
    )
    .environmentObject(ThemeManager())
}
