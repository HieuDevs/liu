import Foundation

protocol AuthDataSource {
    func signIn(email: String, password: String) async throws -> UserDTO
    func signUp(name: String, email: String, password: String) async throws -> UserDTO
}

struct UserDTO: Codable {
    let id: String
    let email: String
    let name: String
    
    func toDomain() -> User {
        return User(id: id, email: email, name: name)
    }
}

class FakeAuthDataSource: AuthDataSource {
    
    func signIn(email: String, password: String) async throws -> UserDTO {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Simulate success for test credentials
        if (email == "user@example.com" && password == "password") || (email == "hieubh" && password == "123") {
            return UserDTO(id: UUID().uuidString, email: email, name: "Boss Hieu")
        } else if email == "error@example.com" {
             throw NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: Constants.LocalizationKeys.invalidCredentials.localized])
        }
        
        // Default success for other inputs (for testing convenience)
        return UserDTO(id: UUID().uuidString, email: email, name: "User \(email)")
    }
    
    func signUp(name: String, email: String, password: String) async throws -> UserDTO {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        if email == "exists@example.com" {
            throw NSError(domain: "AuthError", code: 409, userInfo: [NSLocalizedDescriptionKey: Constants.LocalizationKeys.userAlreadyExists.localized])
        }
        
        return UserDTO(id: UUID().uuidString, email: email, name: name)
    }
}

