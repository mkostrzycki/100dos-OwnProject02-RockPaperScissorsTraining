//
//  ContentView.swift
//  RockPaperScissorsTraining
//
//  Created by MaćKo on 29/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var symbol = Int.random(in: 0..<3)
    @State private var goal = Bool.random()
    @State private var userPick = 0
    @State private var userWins = false
    @State private var roundFinished = false

    let symbols = ["🤜", "🫲", "✌️"]

    var body: some View {
        VStack {
            Spacer()

            Text("My symbol: ")
            Text("\(symbols[symbol])")
                .font(.system(size: 70))

            Text("Your goal is: ")
            Text("\(goal ? "to win" : "to lose")")

            Spacer()

            Text("Pick your symbol: ")
            HStack {
                ForEach(0..<3) { number in
                    Button {
                        symbolPicked(number)
                    } label: {
                        Text("\(symbols[number])")
                            .font(.system(size: 70))
                    }
                }
            }

            Spacer()
        }
        .alert("Round finished", isPresented: $roundFinished) {
            Button("Next round", action: newRound)
        } message: {
            Text(userWins ? "You achieved your goal!" : "You didn't achieve your goal")
        }
    }

    func symbolPicked(_ number: Int) {
        userPick = number

        // TODO: check result - paper beats rock etc.
        userWins = Bool.random()

        roundFinished = true
    }

    func newRound() {
        symbol = Int.random(in: 0..<3)
        goal = Bool.random()
        userPick = 0
        userWins = false
    }
}

#Preview {
    ContentView()
}
