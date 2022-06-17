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
    private let movieSearchUrl = "https://api.themoviedb.org/3/search/movie?api_key=e3ddbb353811c2ead0fdb30472f6f462&language=en-US&page=1&include_adult=false"
    private let tvSearchUrl = "https://api.themoviedb.org/3/search/tv?api_key=e3ddbb353811c2ead0fdb30472f6f462&language=en-US&page=1&include_adult=false"
    
    func searchForMovies(search: String) async throws -> MovieList {
        guard let url = URL(string: "\(movieSearchUrl)&query=\(search)") else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let (data, resp) = try await URLSession.shared.data(for: request)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let movieLists = try decoder.decode(MovieList.self, from: data)
        
        guard let tvUrl = URL(string: "\(tvSearchUrl)&query=\(search)") else {
            throw URLError(.badURL)
        }
        let tvRequest = URLRequest(url: tvUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        let(data1,resp1) = try await URLSession.shared.data(for: tvRequest)
        guard (resp1 as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        
        let showList = try decoder.decode(MovieList.self, from: data1)
        
        
        
        return MovieList(results: movieLists.results + showList.results)
    }
}
