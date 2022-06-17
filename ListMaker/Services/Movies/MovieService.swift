//
//  MovieService.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/17/22.
//

import Foundation

protocol MovieService {
    func searchForMovies(search: String) async throws -> MovieList
}

struct MovieServiceImpl: MovieService {
    private let searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=e3ddbb353811c2ead0fdb30472f6f462&language=en-US&page=1&include_adult=false"
    func searchForMovies(search: String) async throws -> MovieList {
        guard let url = URL(string: "\(searchUrl)&query=\(search)") else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let (data, resp) = try await URLSession.shared.data(for: request)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let movieLists = try decoder.decode(MovieList.self, from: data)
        return movieLists
    }
}
