//
//  SelectLavelView.swift
//  IBPL-MemoryGame
//
//  Created by Lokesh Patil on 24/02/24.
//

import SwiftUI

struct SelectLavelView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Go to Lavel 1") {
                    GameView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

#Preview {
    SelectLavelView()
}
