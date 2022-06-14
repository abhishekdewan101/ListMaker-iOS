//
//  GameListScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import SwiftUI

struct GameListScreen: View {
    var list: ListModel
    @FetchRequest var entries: FetchedResults<ListEntry>
    @Environment(\.managedObjectContext) var moc

    init(list: ListModel) {
        _entries = FetchRequest<ListEntry>(sortDescriptors: [],
                                           predicate: NSPredicate(format: "listId == %@", list.id! as CVarArg))
        self.list = list
    }

    var body: some View {
        Text("Hello from the game list screen of \(list.id ?? UUID())")
            .navigationTitle(list.title ?? "Untitled")
            .navigationBarTitleDisplayMode(.inline)

        Text("Size of the payload \(entries.count)")
    }
}
