//
//  ContentView.swift
//  IBPL-MemoryGame
//
//  Created by Lokesh Patil on 24/02/24.
//

import SwiftUI

struct ContentView: View {
    private var fourColumnGrid = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
    
    private var SixColumnGrid = [ GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
    
    @State var cards = createCardList().shuffled()
    @State var MatchedCards = [Card]()
    @State var  UserChoices = [Card]()
    
    var body: some View {
        GeometryReader{geo in
            VStack {
                Spacer()
                
                LazyVGrid(columns: fourColumnGrid, spacing: 2.5) {
                    ForEach(cards){card in
                        CardView(card: card,
                                 width: Int(geo.size.width/4),
                                 MatchedCards: $MatchedCards,
                                 UserChoices: $UserChoices)
                    }
                }
            
                LazyVGrid(columns: SixColumnGrid, alignment: .center, spacing: 5) {
                    ForEach(cardValues, id:\.self){cardValue in
                        if !MatchedCards.contains(where: {$0.text == cardValue}){
                            Image(cardValue)
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .font(.system(size: 55))
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
