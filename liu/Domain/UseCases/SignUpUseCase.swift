import Foundation

protocol SignUpUseCase {
    func execute(name: String, email: String, password: String) async throws -> User
}

struct SignUpUseCaseImpl: SignUpUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(name: String, email: String, password: String) async throws -> User {
        // Add business logic validation if needed
        return try await repository.signUp(name: name, email: email, password: password)
    }
}

