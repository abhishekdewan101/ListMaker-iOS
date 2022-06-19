//
//  MainNavigator.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/9/22.
//

import SwiftUI

struct MainNavigator: View {
    var title: String

    @State private var showNewListBottomSheet = false

    var body: some View {
        NavigationView {
            HomeScreen()
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Spacer()
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            showNewListBottomSheet.toggle()
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                        }.buttonStyle(.plain)
                    }
                }
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
