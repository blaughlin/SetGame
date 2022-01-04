//
//  SetApp.swift
//  Set
//
//  Created by Bernard Laughlin on 12/30/21.
//

import SwiftUI

@main
struct SetApp: App {
    private let game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(game : game)
        }
    }
}
