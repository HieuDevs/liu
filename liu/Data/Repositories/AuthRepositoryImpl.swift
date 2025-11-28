import Foundation

class AuthRepositoryImpl: AuthRepository {
    private let dataSource: AuthDataSource
    private var currentUser: User?
    private let userDefaultsKey = "logged_in_user"

    init(dataSource: AuthDataSource) {
        self.dataSource = dataSource
        self.currentUser = loadUserFromDefaults()
    }

    func signIn(email: String, password: String) async throws -> User {
        let userDTO = try await dataSource.signIn(email: email, password: password)
        let user = userDTO.toDomain()
        saveUserToDefaults(user)
        self.currentUser = user
        return user
    }

    func signUp(name: String, email: String, password: String) async throws -> User {
        let userDTO = try await dataSource.signUp(name: name, email: email, password: password)
        let user = userDTO.toDomain()
        saveUserToDefaults(user)
        self.currentUser = user
        return user
    }

    func signOut() async throws {
        // Simulate network delay if needed
        try await Task.sleep(nanoseconds: 500_000_000)  // 0.5 second
        removeUserFromDefaults()
        self.currentUser = nil
    }

    func getCurrentUser() async -> User? {
        return currentUser
    }

    // MARK: - Persistence Helpers

    private func saveUserToDefaults(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    private func loadUserFromDefaults() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }

    private func removeUserFromDefaults() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
