//
//  GameListScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import SwiftUI

struct GameListScreen: View {
    var list: ListModel

    var body: some View {
        Text("Hello from the game list screen of \(list.id ?? UUID())")
            .navigationTitle(list.title ?? "Untitled")
            .navigationBarTitleDisplayMode(.inline)
    }
}
