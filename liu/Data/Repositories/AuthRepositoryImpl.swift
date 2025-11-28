import Foundation

class AuthRepositoryImpl: AuthRepository {
    private let dataSource: AuthDataSource
    private var currentUser: User?
    
    init(dataSource: AuthDataSource) {
        self.dataSource = dataSource
    }
    
    func signIn(email: String, password: String) async throws -> User {
        let userDTO = try await dataSource.signIn(email: email, password: password)
        let user = userDTO.toDomain()
        self.currentUser = user
        return user
    }
    
    func signUp(name: String, email: String, password: String) async throws -> User {
        let userDTO = try await dataSource.signUp(name: name, email: email, password: password)
        let user = userDTO.toDomain()
        self.currentUser = user
        return user
    }
    
    func signOut() async throws {
        // Simulate network delay if needed
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 second
        self.currentUser = nil
    }
    
    func getCurrentUser() async -> User? {
        return currentUser
    }
}

