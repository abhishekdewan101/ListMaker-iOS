//
//  Game.swift
//  ListMaker
//
//  Created by Abhishek Dewan on 6/15/22.
//

import Foundation

struct Game: Decodable {
    let name: String
    let cover: GameImage?
    let id: Int
}

struct GameImage: Decodable {
    let id: Int
    let imageId: String
    var qualifiedUrl: String {
        "https://images.igdb.com/igdb/image/upload/t_720p/\(imageId).png"
    }
}
