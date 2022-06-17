//
//  MovieRepository.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/17/22.
//

import Foundation

class MovieRepository: ObservableObject {
    @Published var movieSearchResults: MovieList = MovieList(results: [])
    private var movieService: MovieService
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func searchForMovies(searchTerm: String) async throws -> MovieList{
        return try await movieService.searchForMovies(search: searchTerm)
    }
}
