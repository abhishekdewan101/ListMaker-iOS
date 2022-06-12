//
//  MovieListScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import SwiftUI

struct MovieListScreen: View {
    var list: ListModel

    var body: some View {
        Text("Hello from the movie list screen of \(list.id ?? UUID())")
            .navigationTitle(list.title ?? "Untitled list")
            .navigationBarTitleDisplayMode(.inline)
    }
}
