//
//  DataController.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ListsDB")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                // TODO: Do something useful here
                print("Core Data failed to load : \(error.localizedDescription)")
            }
        }
    }
}
