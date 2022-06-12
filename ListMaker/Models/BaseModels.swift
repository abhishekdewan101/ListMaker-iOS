//
//  BaseModels.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/11/22.
//

import Foundation
import SwiftUI

enum ListType: String, CaseIterable {
    case Games
    case Movies
    case Books
}

extension String {
    func getListType() -> ListType? {
        return ListType(rawValue: self)
    }
}
