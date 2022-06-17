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
    @State var showGameAddSheet = false

    private var viewModel = GameListViewModel()
    @State private var searchTerm = ""

    init(list: ListModel) {
        _entries = FetchRequest<ListEntry>(sortDescriptors: [],
                                           predicate: NSPredicate(format: "listId == %@", list.id! as CVarArg))
        self.list = list
    }

    var body: some View {
        VStack {
            if entries.isEmpty {
                EmptyGameList()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(entries, id: \.id) { entry in
                            HStack {
                                AsyncImage(url: URL(string: entry.image!)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 64, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                Text(entry.body!).font(.body).lineLimit(2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }.padding()
            }
        }
        .navigationTitle(list.title ?? "Untitled")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
            ToolbarItem(placement: .bottomBar) {
                Button {
                    showGameAddSheet.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }.buttonStyle(.plain)
            }
        }
        .sheet(isPresented: $showGameAddSheet) {
            GameSearchScreen(viewModel: viewModel) {
                let listItem = ListEntry(context: moc)
                listItem.id = UUID()
                listItem.body = $0.name
                listItem.image = $0.cover!.qualifiedUrl
                listItem.listId = list.id
                try! moc.save()
                showGameAddSheet.toggle()
            }
        }
    }
}

private struct EmptyGameList: View {
    var body: some View {
        VStack {
            Image(systemName: "binoculars")
                .font(.system(size: 24.0))
                .foregroundColor(.black)
                .padding(20)
                .background(Color.white)
                .clipShape(Circle())
            Text("Your list is empty").font(.title3).padding(.top)
        }
    }
}
