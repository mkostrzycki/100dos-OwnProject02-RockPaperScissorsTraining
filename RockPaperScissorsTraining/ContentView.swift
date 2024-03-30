//
//  ContentView.swift
//  RockPaperScissorsTraining
//
//  Created by MaćKo on 29/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var gamesChoice = Int.random(in: 0..<3)
    @State private var playersChoice = 0
    @State private var goal = Int.random(in: 0..<2) // 0 or 1 - win or lose
    @State private var goalAchieved = false

    @State private var score = 0
    @State private var roundResult = 0
    @State private var roundFinished = false
    let numberOfRounds = 10
    @State private var currentRound = 1
    @State private var isGameOver = false

    let symbols = ["🤜", "🫲", "✌️"]
    let results = ["win", "lose", "tie"]
    let win = 0
    let lose = 1
    let tie = 2

    var body: some View {
        VStack {
            Spacer()

            VStack {
                Text("My symbol: ")
                Text("\(symbols[gamesChoice])")
                    .font(.system(size: 70))

                Text("Your goal is to: ")
                Text("\(results[goal])")
            }

            Spacer()

            VStack {
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
            }

            Spacer()

            VStack {
                Text("Score: \(score)")
                Text("Round: \(currentRound) of \(numberOfRounds)")
            }

            Spacer()
        }
        .alert("Round finished", isPresented: $roundFinished) {
            Button("Next round", action: newRound)
        } message: {
            let result = "Your goal was to \(results[goal])\nand You \(results[roundResult])\n\n"
            let message = goalAchieved ? "You achieved your goal!" : "You didn't achieve your goal"
            Text(result + message)
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("New Game", action: resetGame)
        } message: {
            Text("You finished \(numberOfRounds) round.\nYour final score is \(score).")
        }
    }

    func symbolPicked(_ number: Int) {
        playersChoice = number

        roundResult = calculateResult()
        goalAchieved = goal == roundResult

        if goalAchieved {
            score += 1
        } else {
            score = [0, score - 1].max() ?? 0
        }

        roundFinished = true
    }

    func calculateResult() -> Int {
        switch true {
        // tie
        case gamesChoice == playersChoice:
            return tie
        // player wins
        case (playersChoice == 0 && gamesChoice == 2) || (playersChoice == 1 && gamesChoice == 0) || (playersChoice == 2 && gamesChoice == 1):
            return win
        // in other cases, game wins
        default:
            return lose
        }
    }

    func newRound() {
        gamesChoice = Int.random(in: 0..<3)
        playersChoice = 0
        goal = Int.random(in: 0..<2)
        goalAchieved = false

        if currentRound < numberOfRounds {
            currentRound += 1
        } else {
            isGameOver = true
        }
    }

    func resetGame() {
        score = 0
        currentRound = 1
    }
}

#Preview {
    ContentView()
}
