//
//  AuthenticationRepository.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/13/22.
//

import Foundation

class GameAuthenticationRepository: ObservableObject {
    @Published var activeAuthToken: String
    private var authenticationService: AuthenticationService
    private var userDefaults: UserDefaults
    private let authenticationKey = "current_authentication"
    
    init(authenticationService: AuthenticationService, userDefaults: UserDefaults) {
        self.authenticationService = authenticationService
        self.userDefaults = userDefaults
        activeAuthToken = ""
        Task {
           await initializeAuthToken()
        }
    }
    
    private func initializeAuthToken() async {
        let storedAuthString = userDefaults.string(forKey: authenticationKey)
        if storedAuthString != nil {
            do {
                let storedAuth = try parseStoredAuthString(auth: storedAuthString!)
                if let storedAuth = storedAuth {
                    let currentEpoc = NSDate().timeIntervalSince1970
                    if currentEpoc.isLess(than: Double(storedAuth.expiresIn)) {
                        activeAuthToken = storedAuth.accessToken
                        return
                    }
                }
            } catch {
                print("\(self) --> Ran into issues parsing stored authentication")
            }
        }
        
        if !activeAuthToken.isEmpty { return }
        
        do {
            let remoteAuth = try await authenticationService.getAuthenticationData()
            var authenticationWithExpiresInFuture = remoteAuth
            authenticationWithExpiresInFuture.expiresIn = Int(NSDate().timeIntervalSince1970.advanced(by: Double(authenticationWithExpiresInFuture.expiresIn)))
            let authString = try String(decoding: JSONEncoder().encode(remoteAuth), as: UTF8.self)
            userDefaults.set(authString, forKey: authenticationKey)
            activeAuthToken = remoteAuth.accessToken
        } catch {
            print("\(self) --> Ran into issues getting authetication from service")
        }
    }
    
    private func parseStoredAuthString(auth: String) throws -> Authentication? {
        let jsonData = auth.data(using: .utf8)
        if let jsonData = jsonData {
            return try JSONDecoder().decode(Authentication.self, from: jsonData)
        }
        return nil
    }
}
