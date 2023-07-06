//
//  PokemonData.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 02-07-23.
//

import Foundation

struct PokemonData: Codable {
    let weight: Double
    let height: Double
    let types: [PokemonType]?
    let sprites: Sprite?
}

struct PokemonType: Codable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Codable {
    let name: String
    let url: String
}

struct Sprite: Codable {
    let other: Other?
}

struct Other: Codable {
    let dream_world: DreamWorld?
}

struct DreamWorld: Codable {
    let front_default: URL?
}
