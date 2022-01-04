//
//  SetGame.swift
//  Set
//
//  Created by Bernard Laughlin on 12/30/21.
//

import Foundation
import UIKit

struct SetGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var dealtCards: Array<Card>
    private(set) var score = 0
    private(set) var selectedCards = [Int]()
    
    init(numberOfPairOfCards: Int, creatrCardContent: (Int) -> CardContent) {
        cards = []
        dealtCards = [Card]()
        for pairIndex in 0..<numberOfPairOfCards {
            let content: CardContent = creatrCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex))
        }
        cards.shuffle()
        for _ in 0..<12 {
            if let dealtCard = cards.popLast(){
                self.dealtCards.append(dealtCard)
            }
        }
    }
    
    mutating func addCards() {
        if (dealtCards.filter{$0.isSelected == true}.count) == 3 {
            for _ in 0..<3{
                if let index = dealtCards.firstIndex(where: {$0.isSelected == true}){
                    self.dealtCards.remove(at: index)
                }
            }

        }
            for _ in 0..<3 {
                if let newDealtCard = cards.popLast() {
                    self.dealtCards.append(newDealtCard)
                }
            }
    }
    
    mutating func choose(_ card: Card){
        if selectedCards.count == 3 {
            deselectCards(cards: selectedCards)
            selectedCards = []
        }
        if let chosenIndex = dealtCards.firstIndex(where: {$0.id == card.id}), !dealtCards[chosenIndex].isMatched {
            if !dealtCards[chosenIndex].isSelected {
                selectedCards.append(dealtCards[chosenIndex].id)
            } else {
                selectedCards.removeLast()
            }
            dealtCards[chosenIndex].isSelected = !dealtCards[chosenIndex].isSelected
            print(selectedCards)
        }
        
        if selectedCards.count == 3 {
            if doesMatch(cards: selectedCards) {
                print("You got a match!")
                score += 10
                setMatch(cards: selectedCards)
            } else {
                print("Does not match")
                score -= 1
            }
        }
    }
    
    mutating func deselectCards(cards: [Int]) {
        for selectedId in cards {
            if let index = dealtCards.firstIndex(where: {$0.id == selectedId}) {
                dealtCards[index].isSelected = !dealtCards[index].isSelected
            }
        }
    }
    
    mutating func setMatch(cards: [Int]) {
        for selectedId in cards {
            if let index = dealtCards.firstIndex(where: {$0.id == selectedId}) {
                dealtCards[index].isMatched = !dealtCards[index].isMatched
            }
        }
    }
    
    
    func doesMatch(cards: [Int]) -> Bool {
        // Get card content from id in cards array
        if let card1 = dealtCards.first(where: { $0.id == cards[0]})?.content as? SetCard {
            if let card2 = dealtCards.first(where: { $0.id == cards[1]})?.content as? SetCard {
                if let card3 = dealtCards.first(where: { $0.id == cards[2]})?.content as? SetCard{
                    // Return true if shape, color, shade, and number are all different
                    if (card1.shape != card2.shape && card3.shape != card1.shape && card3.shape != card2.shape) &&
                        (card1.color != card2.color && card3.color != card1.color && card3.color != card2.color) &&
                        (card1.numberOfShapes != card2.numberOfShapes && card3.numberOfShapes != card1.numberOfShapes && card3.numberOfShapes != card2.numberOfShapes) &&
                        (card1.shading != card2.shading && card3.shading != card1.shading && card3.shading != card2.shading) {
                        return true
                    // Return true if shapes all the same and everything else is different
                    } else if (card1.shape == card2.shape && card3.shape == card1.shape && card3.shape == card2.shape) &&
                                (card1.color != card2.color && card3.color != card1.color && card3.color != card2.color) &&
                                (card1.numberOfShapes != card2.numberOfShapes && card3.numberOfShapes != card1.numberOfShapes && card3.numberOfShapes != card2.numberOfShapes) &&
                                (card1.shading != card2.shading && card3.shading != card1.shading && card3.shading != card2.shading) {
                        return true
                    // Return true if colors all the same and everything else is different
                    } else if (card1.shape != card2.shape && card3.shape != card1.shape && card3.shape != card2.shape) &&
                        (card1.color == card2.color && card3.color == card1.color && card3.color == card2.color) &&
                        (card1.numberOfShapes != card2.numberOfShapes && card3.numberOfShapes != card1.numberOfShapes && card3.numberOfShapes != card2.numberOfShapes) &&
                                (card1.shading != card2.shading && card3.shading != card1.shading && card3.shading != card2.shading) {
                        return true
                    // Return true if shape numbers all the same and everything else is different
                    } else if (card1.shape != card2.shape && card3.shape != card1.shape && card3.shape != card2.shape) &&
                                (card1.color != card2.color && card3.color != card1.color && card3.color != card2.color) &&
                                (card1.numberOfShapes == card2.numberOfShapes && card3.numberOfShapes == card1.numberOfShapes && card3.numberOfShapes == card2.numberOfShapes) &&
                                (card1.shading != card2.shading && card3.shading != card1.shading && card3.shading != card2.shading) {
                        return true
                    // Return true if shading all the same and everything else is different
                    } else if (card1.shape != card2.shape && card3.shape != card1.shape && card3.shape != card2.shape) &&
                                (card1.color != card2.color && card3.color != card1.color && card3.color != card2.color) &&
                                (card1.numberOfShapes != card2.numberOfShapes && card3.numberOfShapes != card1.numberOfShapes && card3.numberOfShapes != card2.numberOfShapes) &&
                                (card1.shading == card2.shading && card3.shading == card1.shading && card3.shading == card2.shading) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    
    struct Card: Identifiable {
        var isSelected = false
        var isMatched = false
        let content: CardContent
        let id : Int
    }
}





