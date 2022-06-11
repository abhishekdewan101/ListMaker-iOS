//
//  MainNavigator.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/9/22.
//

import SwiftUI

struct MainNavigator: View {
    var title: String

    @State private var showAccountBottomSheet = false
    @State private var showNewListBottomSheet = false

    var body: some View {
        NavigationView {
            HomeScreen()
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            showAccountBottomSheet.toggle()
                        } label: {
                            Image(systemName: "person.fill")
                                .imageScale(.large)
                        }.buttonStyle(.plain)
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            showNewListBottomSheet.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                    .imageScale(.large)
                                Text("New List")
                            }

                        }.buttonStyle(.plain)
                    }
                }
        }.sheet(isPresented: $showAccountBottomSheet) {
            AccountScreen()
        }.sheet(isPresented: $showNewListBottomSheet) {
            NewListScreen()
        }
    }
}

struct MainNavigator_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigator(title: "ListMaker")
    }
}
