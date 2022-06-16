//
//  AuthenticationModel.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/12/22.
//

import Foundation

struct Authentication: Codable, Equatable {
    var accessToken: String
    var expiresIn: Int
}
