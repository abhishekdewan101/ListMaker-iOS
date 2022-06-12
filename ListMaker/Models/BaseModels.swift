//
//  BaseModels.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import Foundation
import SwiftUI

enum ListType {
    case games
    case movies
}

struct List: Hashable {
    let title: String
    let type: ListType
    let id: UUID
}
