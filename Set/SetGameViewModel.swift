//
//  SetGameViewModel.swift
//  Set
//
//  Created by Bernard Laughlin on 12/30/21.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    typealias Card = SetGame<SetCard>.Card
    @Published private var model: SetGame<SetCard>
    
    
    init() {
        self.model = SetGameViewModel.createGame()
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var dealtCards: Array<Card> {
        return model.dealtCards
    }
    
    var score : Int {
        return model.score
    }
    
    
    static func createGame() -> SetGame<SetCard> {
        var cardDeck : [SetCard] = []
        let shapes = ["Diamond", "Squiggle", "Oval"]
        let colors = [Color.red, Color.green, Color.purple]
        let counts = [1,2,3]
        let shades = [0.1, 0.5, 1]
        for color in colors {
            for shape in shapes {
                for count in counts {
                    for shade in shades {
                        let card = SetCard.init(color: color, numberOfShapes: count, shape: shape, shading: shade)
                        cardDeck.append(card)
                    }
                }
            }
        }

        return SetGame<SetCard>(numberOfPairOfCards: cardDeck.count) {pairIndex in
            cardDeck[pairIndex]
        }
    }
    
    // Mark:= Intents(s)
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func addCards() {
        model.addCards()
    }
    
    func newGame() {
        model = SetGameViewModel.createGame()
    }
}
