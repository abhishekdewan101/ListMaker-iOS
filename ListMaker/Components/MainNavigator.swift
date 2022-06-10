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

    var body: some View {
        NavigationView {
            HomeScreen()
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAccountBottomSheet.toggle()
                        } label: {
                            Image(systemName: "person.circle")
                        }.buttonStyle(.plain)
                    }
                }
        }.sheet(isPresented: $showAccountBottomSheet) {
            AccountScreen()
        }
    }
}

struct MainNavigator_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigator(title: "ListMaker")
    }
}
