//
//  HomeScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/9/22.
//

import SwiftUI

struct HomeScreen: View {
    @FetchRequest(sortDescriptors: []) var lists: FetchedResults<ListModel>

    private let twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        List {
            ForEach(lists, id: \.self) { list in
                NavigationLink {
                    switch ListType(rawValue: list.type ?? "none") {
                    case .Games:
                        GameListScreen(list: list)
                    case .Movies:
                        MovieListScreen(list: list)
                    case .Books:
                        Text("WIP")
                    case .none:
                        Text("Error Screen")
                    }
                } label: {
                    Text(list.title ?? "Untitled List")
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
