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
    let dreamWorld: DreamWorld?
    let officialArtwork: OficialArtWork?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

struct DreamWorld: Codable {
    let frontDefault: URL?
        
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct OficialArtWork: Codable {
    let frontDefault: String
        
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
