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
            Text("Home Screen")
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
            Text("Account Information")
        }
    }
}

struct MainNavigator_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigator(title: "ListMaker")
    }
}
