//
//  ContentView.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 29-06-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            WelcomeView()
                .preferredColorScheme(.light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
