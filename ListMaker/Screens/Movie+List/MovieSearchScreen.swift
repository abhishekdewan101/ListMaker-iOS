//
//  MovieSearchScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/17/22.
//

import SwiftUI

struct MovieSearchScreen: View {
    @State var searchTerm: String = ""
    @ObservedObject private var viewModel: MovieListViewModel
    private var onSaveMovie: (Movie) -> Void

    init(viewModel: MovieListViewModel, onSaveMovie: @escaping (Movie) -> Void) {
        self.viewModel = viewModel
        self.onSaveMovie = onSaveMovie
    }

    var body: some View {
        VStack {
            SearchBar(searchTerm: $searchTerm, onSubmit: { searchTerm in
                viewModel.searchForMovies(searchTerm: searchTerm)
            })
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color.white))
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.searchResults, id: \.id) { movie in
                        MovieListItem(movie: movie, onTap: onSaveMovie)
                    }
                }
            }
            .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .onDisappear {
            viewModel.clearSearchResults()
            searchTerm = ""
        }
        .padding()
    }
}

private struct SearchBar: View {
    var searchTerm: Binding<String>
    var onSubmit: (String) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search movies...", text: searchTerm)
                .foregroundColor(Color.white)
                .font(.body)
                .onSubmit {
                    onSubmit(searchTerm.wrappedValue)
                }
        }
    }
}

private struct MovieListItem: View {
    var movie: Movie
    var onTap: (Movie) -> Void

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.quailifiedPosterPath)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(movie.title).font(.body).lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            onTap(movie)
        }
    }
}
