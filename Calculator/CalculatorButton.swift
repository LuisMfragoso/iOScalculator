//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Luis Fragoso on 15/05/23.
//

import SwiftUI

struct CalculatorButton: View {
    var width: CGFloat = 70
    var color = Color(hue: 1.0, saturation: 0.0, brightness: 0.23)
    var buttonText = "1"
    var action: (CalculatorButton) -> Void = {_ in }
    var mode: CalculatorMode = .notSet
    var body: some View {
        Button {
            action(self)
        } label: {
            Text(buttonText)
                .font(.largeTitle)
                .frame(width: width, height: 70,
                       alignment: .center)
                .background(color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 50))
        }

    }
    
}


struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton()
    }
}
