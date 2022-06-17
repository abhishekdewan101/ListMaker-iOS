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
                let urlEncodedSearch = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let results = try await movieRepository.searchForMovies(searchTerm: urlEncodedSearch)
                await MainActor.run {
                    searchResults = results.results
                }
            } catch {
                print(error)
            }
        }
    }
    
    func clearSearchResults() {
        searchResults = []
    }
}
