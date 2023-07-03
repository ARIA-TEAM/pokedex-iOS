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
    
    var body: some View {
        HStack {
            Text(pokemon.name)
                .font(.headline)
            
            Spacer()
            
//            Button(action: {
//                // Perform any other actions when the star is tapped
//                isStarred.toggle()
//            }) {
//                ZStack {
//                    Circle()
//                        .foregroundColor(.gray)
//                    
//                    Image(systemName: isStarred ? "star.fill" : "star")
//                        .foregroundColor(.yellow)
//                }
//                .frame(width: 30, height: 30)
//            }
        }
        .padding(.horizontal)
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: Pokemon(id: UUID(), name: "Pika", url: "", isStarted: false))
    }
}
