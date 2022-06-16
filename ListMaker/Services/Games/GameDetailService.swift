//
//  GamePosterService.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/15/22.
//

import Foundation

protocol GameDetailService {
    func getGameFor(id: String, withToken: String) async throws -> Game
    func getGamesFor(search: String, withToken: String) async throws -> [Game]
}

struct GameDetailServiceImpl: GameDetailService {
    private let baseUrl = "https://api.igdb.com/v4/games"
    func getGameFor(id: String, withToken: String) async throws -> Game {
        guard let url = URL(string: baseUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        request.httpMethod = "POST"
        request.httpBody = "f  name, cover.image_id; w slug = \(id)".data(using: .utf8)

        request.addValue("c48izyt9768kq3uqhsv2upllsqmtc4", forHTTPHeaderField: "Client-ID")
        request.addValue("Bearer \(withToken)", forHTTPHeaderField: "Authorization")

        let (data, resp) = try await URLSession.shared.data(for: request)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        let game = try JSONDecoder().decode(Game.self, from: data)
        return game
    }

    func getGamesFor(search: String, withToken: String) async throws -> [Game] {
        guard let url = URL(string: baseUrl) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        request.httpMethod = "POST"
        request.httpBody = "f slug, name,cover.image_id; search \"\(search)\"; l 50;".data(using: .utf8)

        request.addValue("c48izyt9768kq3uqhsv2upllsqmtc4", forHTTPHeaderField: "Client-ID")
        request.addValue("Bearer \(withToken)", forHTTPHeaderField: "Authorization")

        let (data, resp) = try await URLSession.shared.data(for: request)
        let response = (resp as? HTTPURLResponse)
        guard response?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let games = try decoder.decode([Game].self, from: data)
        return games
    }
}
