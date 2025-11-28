import Foundation
import Combine

@MainActor
class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    
    private let signInUseCase: SignInUseCase
    
    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = Constants.LocalizationKeys.fillAllFields.localized
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                _ = try await signInUseCase.execute(email: email, password: password)
                isAuthenticated = true
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

