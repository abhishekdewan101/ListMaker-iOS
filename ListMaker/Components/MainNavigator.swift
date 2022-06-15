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
    @ObservedObject private var authenticationRepository = AuthenticationRepository.shared

    var body: some View {
        if authenticationRepository.currentAuthentication != nil {
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
                                Image(systemName: "square.and.pencil")
                                    .imageScale(.large)
                            }.buttonStyle(.plain)
                        }
                    }
            }.sheet(isPresented: $showAccountBottomSheet) {
                AccountScreen()
            }.sheet(isPresented: $showNewListBottomSheet) {
                NewListScreen()
            }
        } else {
            SplashScreen()
        }
    }
}

struct MainNavigator_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigator(title: "ListMaker")
    }
}
