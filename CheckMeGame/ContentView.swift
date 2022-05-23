    //
    //  ContentView.swift
    //  CheckMeGame
    //
    //  Created by Konstantin Fomenkov on 23.05.2022.
    //

import SwiftUI

struct ContentView: View {

    @State private var sliderValue = 10.0
    @State private var isPresented = false
    @State private var randomNumber = Int.random(in: 0...100)

    @State private var score = 0

    var body: some View {
        VStack( spacing: 20) {
            Text("Move the slider as close to \(randomNumber) as possible!")

            HStack(spacing: 16) {
                Text("0")
                OpaqueSlider(
                    sliderValue: $sliderValue,
                    opaqueScore: computeScore(random: randomNumber, slider: sliderValue)
                )
                Text("100")
            }

            Button("Check me!") {
                isPresented.toggle()
                score = computeScore(random: randomNumber, slider: sliderValue)
            }
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text("Your score:"),
                    message: Text("\(score)"),
                    dismissButton: .cancel()
                )}

            Button("New start") {
                randomNumber = Int.random(in: 0...100)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func computeScore(random targetValue: Int, slider currentValue: Double) -> Int {
    let difference = abs(targetValue - lround(currentValue))
    return 100 - difference
}
