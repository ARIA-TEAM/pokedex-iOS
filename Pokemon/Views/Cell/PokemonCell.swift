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
    @State private var isTapped = false // Track if the row is tapped
    @Binding var isShowingModal: Bool // Binding to control the visibility of the modal
    @Binding var selectedPokemon: Pokemon? // Binding to pass the selected Pokemon to the modal
        
    
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
                isTapped = true // Mark the row as tapped
                viewModel.toggleFavorite(for: pokemon) // Toggle the favorite state
            }
            
        }
        .padding()
        .frame(height: 60)
        .background(Color.white) // Give cell a background color
        .cornerRadius(10) // Round the corners for a card-like appearance
        .shadow(radius: 0.5) // Add a shadow for a slightly elevated effect
        .contentShape(Rectangle()) // Add a content shape to capture taps on the entire row
        .onTapGesture {
            if !isTapped { // Show the modal only if the row is not tapped on the star
                isShowingModal = true // Set the flag to show the modal
                selectedPokemon = pokemon // Pass the selected Pokemon to the modal
            } else {
                isTapped = false // Reset the tapped state
            }
        }
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: Pokemon(id: UUID(),
                                     name: "Pika",
                                     url: "",
                                     isFavorite: true),
                    viewModel: PokemonViewModel(),
                    isShowingModal: .constant(false),
                    selectedPokemon: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
