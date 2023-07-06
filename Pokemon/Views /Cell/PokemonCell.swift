//
//  PokemonCell.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import SwiftUI

struct PokemonCell: View {
    var pokemon: Pokemon
    @State private var isStarred: Bool = false
    @ObservedObject var viewModel: PokemonViewModel
    
    var capitalizedPokemonName: String {
        let name = pokemon.name
        return name.capitalized
    }
    
    var body: some View {
        HStack {
            Text(capitalizedPokemonName)
                .font(.headline)
            
            Spacer()
            
            Button(action: {
                isStarred.toggle()
                if let index = viewModel.pokemons.firstIndex(of: pokemon) {
                    viewModel.pokemons[index].isFavorite = isStarred
                }
            }) {
                Image(systemName: isStarred ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isStarred ? .yellow : .gray)
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .onTapGesture {
                isStarred.toggle()
            }
            
        }
        .padding(.horizontal)
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: Pokemon(id: UUID(), name: "Pika", url: "", isFavorite: true), viewModel: PokemonViewModel())
    }
}
