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
    private var gameDetailService: GameDetailService
    var anyCancellable: AnyCancellable?

    init(gameAuthenticationRepository: GameAuthenticationRepository = GameAuthenticationRepository(authenticationService: AuthenticationServiceImpl(), userDefaults: UserDefaults.standard), gameDetailService: GameDetailService = GameDetailServiceImpl()) {
        self.gameAuthenticationRepository = gameAuthenticationRepository
        self.gameDetailService = gameDetailService

        anyCancellable = self.gameAuthenticationRepository.$activeAuthToken.sink { auth in
            if !auth.isEmpty {
                Task {
                    let games = try! await gameDetailService.getGamesFor(search: "Batman", withToken: auth)
                    games.forEach { game in
                        print(game.name)
                    }
                }
            }
        }
    }
}
