//
//  ActionButtonStyle.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 07-07-23.
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.95, green: 0.15, blue: 0.22))
            .cornerRadius(60)
    }
}
