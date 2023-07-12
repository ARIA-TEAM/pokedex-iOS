//
//  WelcomeView.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showListView = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image("Pikachu")
                .resizable()
                .frame(width: 250, height: 200)
            
            Text("Welcome to Pokédex")
                .font(
                    Font.custom("Lato", size: 26)
                        .weight(.bold)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
            
            Text("The digital encyclopedia created by Professor Oak is an invaluable tool to Trainers in the Pokémon world.")
                .font(
                    Font.custom("Lato", size: 18)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.37, green: 0.37, blue: 0.37))
                .frame(width: 315, height: 82, alignment: .top)
            
            NavigationLink(
                destination: ListView(),
                isActive: $showListView,
                label: {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(Color(red: 0.95, green: 0.15, blue: 0.22))
                        .cornerRadius(26)
                }
            )
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
