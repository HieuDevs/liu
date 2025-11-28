import Foundation

protocol AuthRepository {
    func signIn(email: String, password: String) async throws -> User
    func signUp(name: String, email: String, password: String) async throws -> User
    func signOut() async throws
    func getCurrentUser() async -> User?
}

