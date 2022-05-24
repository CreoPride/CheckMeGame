    //
    //  TransparencyThumbSlider.swift
    //  CheckMeGame
    //
    //  Created by Konstantin Fomenkov on 23.05.2022.
    //

import SwiftUI

struct TransparencyThumbSlider: UIViewRepresentable {

    @Binding var sliderValue: Double
    
    let sliderColor: UIColor
    let sliderThumbTransparency: Int

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()

        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = sliderColor
        slider.minimumTrackTintColor = sliderColor

        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged
        )
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(sliderValue)
        uiView.thumbTintColor = sliderColor.withAlphaComponent(CGFloat(sliderThumbTransparency) / 100)
        uiView.minimumTrackTintColor = uiView.thumbTintColor
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $sliderValue)
    }
}

extension TransparencyThumbSlider {
    class Coordinator: NSObject {

        @Binding var sliderValue: Double

        init(sliderValue: Binding<Double>) {
            self._sliderValue = sliderValue
        }

        @objc func valueChanged(_ sender: UISlider) {
            sliderValue = Double(sender.value)
        }
    }
}

struct TransparencyThumbSlider_Previews: PreviewProvider {
    static var previews: some View {
        TransparencyThumbSlider(
            sliderValue: .constant(9),
            sliderColor: .red,
            sliderThumbTransparency: 10
        )
    }
}
