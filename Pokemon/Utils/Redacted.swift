//
//  Redacted.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 12-07-23.
//

import SwiftUI

extension View {
    @ViewBuilder
    func redacted(when condition: Bool) -> some View {
        if !condition {
            unredacted()
        } else {
            redacted(reason: .placeholder)
        }
    }
}

