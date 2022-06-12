//
//  NewListScreen.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/10/22.
//

import SwiftUI

struct NewListScreen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State var title: String = ""
    @State var type: ListType = .Games

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("List title", text: $title)
                    Picker("List type", selection: $type) {
                        ForEach(ListType.allCases, id: \.self) { type in
                            Text("\(type.rawValue)")
                        }
                    }.pickerStyle(.automatic)
                }
                Button {
                    let listModel = ListModel(context: moc)
                    listModel.id = UUID()
                    listModel.type = type.rawValue
                    listModel.title = title
                    try! moc.save()
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }
            }.navigationTitle("New List")
                .padding(.top)
        }
    }
}
