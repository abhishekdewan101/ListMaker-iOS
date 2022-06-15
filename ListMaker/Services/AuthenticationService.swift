//
//  AuthenticationService.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/13/22.
//

import Foundation

struct AuthenticationService {
    func getAuthenticationData() async throws -> Authentication {
        guard let url = URL(string: "https://px058nbguc.execute-api.us-east-1.amazonaws.com/default/authentication") else {
            throw AuthenticationError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        let authentication = try JSONDecoder().decode(Authentication.self, from: data)
        return authentication
    }
}
