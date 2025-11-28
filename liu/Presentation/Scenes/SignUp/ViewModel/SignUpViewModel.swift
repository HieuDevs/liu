import Foundation
import Combine

@MainActor
class SignUpViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isRegistered = false
    
    private let signUpUseCase: SignUpUseCase
    
    init(signUpUseCase: SignUpUseCase) {
        self.signUpUseCase = signUpUseCase
    }
    
    func signUp() {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = Constants.LocalizationKeys.fillAllFields.localized
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = Constants.LocalizationKeys.passwordsDoNotMatch.localized
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                _ = try await signUpUseCase.execute(name: name, email: email, password: password)
                isRegistered = true
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

