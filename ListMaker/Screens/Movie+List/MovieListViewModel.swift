//
//  MovieListViewModel.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/17/22.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movieRepository: MovieRepository
    @Published var searchResults: [Movie] = []
    
    init(movieRepository: MovieRepository = MovieRepository(movieService: MovieServiceImpl())) {
        self.movieRepository = movieRepository
    }
    
    func searchForMovies(searchTerm: String) {
        Task {
            do {
                let results = try await movieRepository.searchForMovies(searchTerm: searchTerm)
                print(results)
                searchResults = results.results
            } catch {
                print(error)
            }
        }
    }
    
    func clearSearchResults() {
        searchResults = []
    }
}
