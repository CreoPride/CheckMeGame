    //
    //  OpaqueSlider.swift
    //  CheckMeGame
    //
    //  Created by Konstantin Fomenkov on 23.05.2022.
    //

import SwiftUI

struct OpaqueSlider: UIViewRepresentable {

    @Binding var sliderValue: Double
    
    let opaqueScore: Int

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()

        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.thumbTintColor = .red

        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged),
            for: .valueChanged
        )
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(sliderValue)
        uiView.thumbTintColor = uiView.thumbTintColor?.withAlphaComponent(CGFloat(opaqueScore) / 100)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(sliderValue: $sliderValue)
    }
}

extension OpaqueSlider {
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

struct OpaqueSlider_Previews: PreviewProvider {
    static var previews: some View {
        OpaqueSlider(sliderValue: .constant(9), opaqueScore: 10)
    }
}
