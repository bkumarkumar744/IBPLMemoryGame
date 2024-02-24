//
//  CardView.swift
//  IBPL-MemoryGame
//
//  Created by Lokesh Patil on 24/02/24.
//


import SwiftUI

struct CardView: View {
    @ObservedObject var card: Card
    let width: Int
    @Binding var MatchedCards: [Card]
    @Binding var UserChoices: [Card]
    
    // New state variable to control face-up state
    @State private var showCards = true
    
    var body: some View {
        VStack {
            if showCards || card.isFacedUp || MatchedCards.contains(where: { $0.id == card.id }) {
                Image(card.text)
                    .resizable()
                    .font(.system(size: 50))
                    .padding()
                    .frame(width: CGFloat(width), height: CGFloat(width))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 1))
                    .onAppear {
                        // Use onAppear to trigger the animation when the view appears
                        if showCards {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                withAnimation(.smooth) {
                                    self.showCards = false
                                }
                            }
                        }
                    }
            } else {
                Text("")
                    .font(.system(size: 50))
                    .padding()
                    .frame(width: CGFloat(width), height: CGFloat(width))
                    .background(Color.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.gray, lineWidth: 1))
                    .onTapGesture {
                        if UserChoices.count == 0 {
                            card.turnOver()
                            UserChoices.append(card)
                        } else if UserChoices.count == 1 {
                            card.turnOver()
                            UserChoices.append(card)
                            withAnimation(Animation.bouncy.delay(1)) {
                                for thisCard in UserChoices {
                                    thisCard.turnOver()
                                }
                            }
                            checkForMatch()
                        }
                    }
            }
        }
    }
    
    func checkForMatch() {
        if UserChoices[0].text == UserChoices[1].text {
            MatchedCards.append(UserChoices[0])
            MatchedCards.append(UserChoices[1])
        }
        UserChoices.removeAll()
    }
}
