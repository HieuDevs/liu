import Foundation

protocol SignInUseCase {
    func execute(email: String, password: String) async throws -> User
}

struct SignInUseCaseImpl: SignInUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) async throws -> User {
        // Add business logic validation if needed (e.g., email format)
        return try await repository.signIn(email: email, password: password)
    }
}

