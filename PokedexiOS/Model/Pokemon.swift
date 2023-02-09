//
//  Pokemon.swift
//  PokedexiOS
//
//  Created by Andrew Acton on 2/8/23.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: SpriteObject
}

struct SpriteObject: Decodable {
    let classicSpriteURL: URL
    
    enum CodingKeys: String, CodingKey {
        case classicSpriteURL = "front_default"
    }
}
