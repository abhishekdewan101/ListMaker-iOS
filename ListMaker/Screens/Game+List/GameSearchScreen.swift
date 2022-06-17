//
//  GameSearchScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/16/22.
//

import SwiftUI

struct GameSearchScreen: View {
    @State var searchTerm: String = ""
    @ObservedObject private var viewModel: GameListViewModel
    private var onSaveGame: (Game) -> Void

    init(viewModel: GameListViewModel, onSaveGame: @escaping (Game) -> Void) {
        self.viewModel = viewModel
        self.onSaveGame = onSaveGame
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search games...", text: $searchTerm)
                    .foregroundColor(Color.white)
                    .font(.body)
                    .onSubmit {
                        viewModel.searchGames(search: searchTerm)
                    }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color.white))
            ScrollView {
                LazyVStack {
                    let filteredGames = viewModel.searchResults.filter {
                        $0.cover != nil
                    }
                    ForEach(filteredGames, id: \.id) { game in
                        GameListItem(game: game, onTap: onSaveGame)
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

private struct GameListItem: View {
    var game: Game
    var onTap: (Game) -> Void

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: game.cover!.qualifiedUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 64, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Text(game.name).font(.body).lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            onTap(game)
        }
    }
}
