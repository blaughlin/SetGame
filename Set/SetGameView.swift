//
//  SetGameView.swift
//  Set
//
//  Created by Bernard Laughlin on 12/30/21.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text("Score: \(game.score)")
                        .padding(.leading)
                    Spacer()
                    Text("Set Game")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {game.newGame()}) { Text("New Game")}
                    .padding(.trailing)
                }
            }
            Spacer()
            AspectVGrid(items: game.dealtCards, aspectRatio: 2/3, content: { card in
                CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            })
            Button(action: {game.addCards()}) { Text("Deal 3 more cards")}.disabled(game.cards.count == 0)
            Spacer()
            Spacer()
        }.padding(.horizontal)
    }
}

struct CardView: View {
    let card : SetGameViewModel.Card
    var body: some View {
        ZStack{
            let cardShape = RoundedRectangle(cornerRadius: 10)
            let symbol = drawShape(shape: card.content.shape, shade: card.content.shading)
            cardShape.fill().foregroundColor(.white)
            if card.isSelected {
                cardShape.strokeBorder(lineWidth: 3)
            } else {
                cardShape.strokeBorder(lineWidth: 1)
            }
            if card.isMatched {
                cardShape.strokeBorder(Color.yellow, lineWidth: 5)
            }
            if card.content.numberOfShapes == 1 {
                VStack{
                    Spacer()
                    VStack{
                        symbol.foregroundColor(card.content.color).aspectRatio(2/1, contentMode: .fit)
                    }
                    Spacer()
                }.padding()
            } else if card.content.numberOfShapes == 2 {
                VStack {
                    symbol.foregroundColor(card.content.color).aspectRatio(2/1, contentMode: .fit)
                    symbol.foregroundColor(card.content.color).aspectRatio(2/1, contentMode: .fit)
                }.padding()
            } else if card.content.numberOfShapes == 3 {
                VStack {
                    symbol.foregroundColor(card.content.color).aspectRatio(2/1, contentMode: .fit)
                    symbol.foregroundColor(card.content.color).aspectRatio(2/1, contentMode: .fit)
                    symbol.foregroundColor(card.content.color).aspectRatio(2/1, contentMode: .fit)
                }.padding()
            }
 
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        return path
    }
}


@ViewBuilder
func drawShape(shape: String, shade: Double) -> some View {
    if shade == 0.1 {
        if shape == "Diamond" {
            Diamond().stroke(lineWidth: 2)
        } else if shape == "Squiggle" {
            Rectangle().strokeBorder(lineWidth: 2)
        } else if shape == "Oval" {
            Ellipse().strokeBorder(lineWidth: 2)
        }
    } else if shade == 0.5 {
        if shape == "Diamond" {
            Diamond().opacity(0.2)
        } else if shape == "Squiggle" {
            Rectangle().opacity(0.2)
        } else if shape == "Oval" {
            Ellipse().opacity(0.2)
        }
    } else {
        if shape == "Diamond" {
            Diamond().opacity(1)
        } else if shape == "Squiggle" {
            Rectangle().opacity(1)
        } else if shape == "Oval" {
            Ellipse().opacity(1)
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
