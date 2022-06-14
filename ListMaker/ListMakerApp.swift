//
//  ListMakerApp.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/6/22.
//

import SwiftUI

@main
struct ListMakerApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            MainNavigator(title: "ListMaker")
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear {
                    setupDependencyInjection()
                }
        }
    }

    private func setupDependencyInjection() {
        DIContainer.shared.register(type: AuthenticationRepository.self, component: AuthenticationRepositoryImpl(authenticationService: AuthenticationServiceImpl()))
    }
}
