//
//  Card.swift
//  IBPL-MemoryGame
//
//  Created by Lokesh Patil on 24/02/24.
//

import Foundation
class Card: Identifiable, ObservableObject {
    var id = UUID()
    @Published var isFacedUp = false
    @Published var isMatched = false
    var text: String
    
    init(text: String){
        self.text = text
    }
    
    func turnOver(){
        self.isFacedUp.toggle()
    }
}

let cardValues: [String] = ["shape1", "shape2", "shape3", "shape4"]//, "shape5", "shape6", "shape7", "shape8"]//, "🐻‍❄️", "🐨", "🐯", "🦁"]

func createCardList() -> [Card] {
    var cardList = [Card]()
    
    for cardValue in cardValues {
        cardList.append(Card(text: cardValue))
        cardList.append(Card(text: cardValue))
    }
    return cardList
}

let faceDownCards = Card(text: "")
