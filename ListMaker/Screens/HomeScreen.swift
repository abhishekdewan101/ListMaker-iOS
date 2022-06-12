//
//  HomeScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/9/22.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = HomeScreenViewModel()

    private let twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        SwiftUI.List {
            ForEach(viewModel.lists, id: \.self) { list in
                NavigationLink {
                    switch list.type {
                    case .games:
                        GameListScreen(list: list)
                    case .movies:
                        MovieListScreen(list: list)
                    }
                } label: {
                    Text(list.title)
                }
            }
        }.padding(.top)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
