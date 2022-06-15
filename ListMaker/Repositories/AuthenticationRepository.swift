//
//  AuthenticationRepository.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/13/22.
//

import Foundation

class AuthenticationRepository: ObservableObject {
    @Published var currentAuthentication: Authentication?
    private var authenticationService: AuthenticationService
    private var userDefaults: UserDefaults
    private var userDefaultKey = "current_authentication"

    static let shared: AuthenticationRepository = {
        let instance = AuthenticationRepository(authenticationService: AuthenticationService())
        // setup code
        return instance
    }()

    private init(authenticationService: AuthenticationService = AuthenticationService()) {
        self.authenticationService = authenticationService
        self.currentAuthentication = nil
        self.userDefaults = UserDefaults.standard
        Task {
            await getCurrentAuthentication()
        }
    }

    func getCurrentAuthentication() async {
        let storedAuthentication = userDefaults.string(forKey: userDefaultKey)
        do {
            if storedAuthentication != nil {
                currentAuthentication = try parseStoredAuthentication(storedAuth: storedAuthentication!)
            } else {
                let auth = try await authenticationService.getAuthenticationData()
                let authString = try String(decoding: JSONEncoder().encode(auth), as: UTF8.self)
                userDefaults.set(authString, forKey: userDefaultKey)
                currentAuthentication = auth
            }
        } catch {
            print("AuthenticationRepository -> Failed to get authentication token")
        }
    }

    private func parseStoredAuthentication(storedAuth: String) throws -> Authentication {
        print("AuthenticationRepository -> Parsing authentication from cache")
        let auth = try JSONDecoder().decode(Authentication.self, from: storedAuth.data(using: .utf8)!)
        return auth
    }
}
