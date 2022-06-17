//
//  MovieListScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import SwiftUI

struct MovieListScreen: View {
    var list: ListModel
    @FetchRequest var entries: FetchedResults<ListEntry>
    @Environment(\.managedObjectContext) var moc
    @State var showAddMovieSheet = false
    
    private var viewModel = MovieListViewModel()
    @State private var searchTerm = ""
    
    init(list: ListModel) {
        _entries = FetchRequest<ListEntry>(sortDescriptors: [],
                                           predicate: NSPredicate(format: "listId == %@", list.id! as CVarArg))
        self.list = list
    }

    var body: some View {
        VStack {
            if entries.isEmpty {
                EmptyListView()
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
                    showAddMovieSheet.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .imageScale(.large)
                }.buttonStyle(.plain)
            }
        }
        .sheet(isPresented: $showAddMovieSheet) {
            MovieSearchScreen(viewModel: viewModel) { movie in
                let listItem = ListEntry(context: moc)
                listItem.id = UUID()
                listItem.body = movie.title ?? movie.name ?? "Untitled"
                listItem.image = movie.quailifiedPosterPath
                listItem.listId = list.id
                try! moc.save()
                showAddMovieSheet.toggle()
            }
        }
    }
}
