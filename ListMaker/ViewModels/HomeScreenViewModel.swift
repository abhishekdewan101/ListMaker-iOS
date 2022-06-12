//
//  HomeScreenViewModel.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import Foundation
import SwiftUI

class HomeScreenViewModel: ObservableObject {
    @Published private(set) var lists: [List] = [
        List(title: "Games in progress 🕹", type: .games, id: UUID()),
        List(title: "Movies backlog 🍿", type: .movies, id: UUID()),
        List(title: "Game need to play 😅 ", type: .games, id: UUID()),
        List(title: "Movies we love 😍 ", type: .games, id: UUID()),
    ]
}
