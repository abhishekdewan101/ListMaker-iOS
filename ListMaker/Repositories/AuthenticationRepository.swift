//
//  AuthenticationRepository.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/13/22.
//

import Foundation

protocol AuthenticationRepository {
    var currentAuthentication: Authentication? { get }
    mutating func getCurrentAuthentication() async
}

struct AuthenticationRepositoryImpl: AuthenticationRepository {
    var currentAuthentication: Authentication?
    private var authenticationService: AuthenticationService
    private var userDefaults: UserDefaults
    private var userDefaultKey = "current_authentication"

    init(authenticationService: AuthenticationService = AuthenticationServiceImpl()) {
        self.authenticationService = authenticationService
        self.currentAuthentication = nil
        self.userDefaults = UserDefaults.standard
    }

    mutating func getCurrentAuthentication() async {
        let storedAuthentication = userDefaults.string(forKey: userDefaultKey)
        do {
            if storedAuthentication != nil {
                currentAuthentication = try parseStoredAuthentication(storedAuth: storedAuthentication!)
            } else {
                let auth = try await authenticationService.getAuthenticationData()
                let authString = try JSONEncoder().encode(auth)
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
