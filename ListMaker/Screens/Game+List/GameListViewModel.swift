//
//  GameListViewModel.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/14/22.
//

import Combine
import Foundation

class GameListViewModel: ObservableObject {
    @Published var gameAuthenticationRepository: GameAuthenticationRepository
    @Published var searchResults:[Game] = []
    private var gameDetailService: GameDetailService
    var anyCancellable: AnyCancellable?

    init(gameAuthenticationRepository: GameAuthenticationRepository = GameAuthenticationRepository(authenticationService: AuthenticationServiceImpl(), userDefaults: UserDefaults.standard), gameDetailService: GameDetailService = GameDetailServiceImpl()) {
        self.gameAuthenticationRepository = gameAuthenticationRepository
        self.gameDetailService = gameDetailService

        anyCancellable = self.gameAuthenticationRepository.$activeAuthToken.sink { _ in
        }
    }

    func searchGames(search: String) {
        Task {
            do {
                let games = try await gameDetailService.getGamesFor(search: search, withToken: gameAuthenticationRepository.activeAuthToken)
                await MainActor.run {
                    searchResults = games
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
