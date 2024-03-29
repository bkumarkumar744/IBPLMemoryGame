//
//  GameView.swift
//  IBPL-MemoryGame
//
//  Created by Lokesh Patil on 24/02/24.
//

import SwiftUI

struct GameView: View {
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
    @State var UserChoices = [Card]()
    @State var startGameTimer: Bool = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var showGameComplitionAlert = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader{geo in
            VStack {
                HStack {
                    if startGameTimer {
                        Text(String(format: "%02d:%02d", Int(elapsedTime / 60), Int(elapsedTime) % 60))
                            .font(.system(size: 40).bold())
                            .onAppear {
                                startTimer()
                            }
                    }
                    else {
                        Text("00:00")
                            .font(.system(size: 40).bold())
                    }
                    
                    Spacer()
                        
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray)
                        .frame(width: 100, height: 30)
                        .overlay {
                            Text("Stop")
                                .font(.system(size: 15).bold())
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            dismiss()
                        }
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: fourColumnGrid, spacing: 2.5) {
                    ForEach(cards){card in
                        CardView(
                            card: card,
                            width: Int(geo.size.width/4),
                            MatchedCards: $MatchedCards,
                            UserChoices: $UserChoices,
                            startGameTimer: $startGameTimer,
                            onAllCardsMatched: {
                                showGameComplitionAlert = true
                                stopTimer()
                            },
                            totalCardsCount: cards.count
                        )
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
            .alert(isPresented: $showGameComplitionAlert) {
                Alert(
                    title: Text("Congratulations!"),
                    message: Text("You've matched all the cards in \(String(format: "%02d:%02d", Int(elapsedTime / 60), Int(elapsedTime) % 60))."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            elapsedTime += 1
        }
    }
    
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    GameView()
}
