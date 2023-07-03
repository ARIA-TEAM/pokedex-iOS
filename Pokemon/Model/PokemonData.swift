//
//  PokemonData.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 02-07-23.
//

import Foundation

struct PokemonData: Codable {
    let weight: Float
    let height: Float
    let types: [PokemonType]?
}

struct PokemonType: Codable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Codable {
    let name: String
    let url: String
}
