    //
    //  ContentView.swift
    //  CheckMeGame
    //
    //  Created by Konstantin Fomenkov on 23.05.2022.
    //

import SwiftUI

struct ContentView: View {

    @State private var sliderValue = 50.0
    @State private var isPresented = false
    @State private var randomNumber = Int.random(in: 0...100)

    var body: some View {
        VStack( spacing: 20) {
            Text("Move the slider as close to \(randomNumber) as possible!")
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Text("0")
                TransparencyThumbSlider(
                    sliderValue: $sliderValue,
                    sliderColor: .red,
                    sliderThumbTransparency: computeScore()
                )
                Text("100")
            }

            Button("Check me!") {
                isPresented.toggle()
            }
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text("Your score:"),
                    message: Text("\(computeScore())"),
                    dismissButton: .cancel()
                )}

            Button("New start") {
                randomNumber = Int.random(in: 0...100)
            }
        }.padding()
    }

    private func computeScore() -> Int {
        let difference = abs(randomNumber - lround(sliderValue))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

