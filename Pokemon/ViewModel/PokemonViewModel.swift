//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import Foundation

/**
 The `PokemonViewModel` class is responsible for fetching Pokemon data from the API
 and managing the search functionality.
 */
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = [] // List of pokemons
    @Published var searchText: String = ""
    @Published var pokemonData: PokemonData?
        
    /**
     Fetches Pokemon data from the API and populates the `pokemons` array.
     */
    func fetchData() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.pokemons = response.results.map({ pokemon in
                        Pokemon(id: UUID(), name: pokemon.name, url: pokemon.url)
                    })
                }
            }
        }.resume()
    }
    
    /**
     Fetches additional data for a given Pokemon using the provided URL.
     */
    func fetchPokemonData(for pokemon: Pokemon) {
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonData.self, from: data) {
                DispatchQueue.main.async {
                    self.pokemonData = response
                    dump(self.pokemonData)
                }
                
            }
        }.resume()
    }
}
