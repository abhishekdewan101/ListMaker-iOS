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
    var anyCancellable: AnyCancellable?

    init(gameAuthenticationRepository: GameAuthenticationRepository = GameAuthenticationRepository(authenticationService: AuthenticationServiceImpl(), userDefaults: UserDefaults.standard)) {
        self.gameAuthenticationRepository = gameAuthenticationRepository

        anyCancellable = self.gameAuthenticationRepository.$activeAuthToken.sink {
            print("\(self) --> \($0)")
        }
    }
}
