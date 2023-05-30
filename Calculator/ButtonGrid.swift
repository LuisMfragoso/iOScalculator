//
//  ButtonGrid.swift
//  Calculator
//
//  Created by Luis Fragoso on 15/05/23.
//

import SwiftUI

enum CalculatorMode {
    case notSet
    case addition
    case subtraction
    case multiplication
    case divide
    case percentage
    case change
}

struct ButtonGrid: View {
    @Binding  var currentValue: String
    @State var currentMode: CalculatorMode = .notSet
    @State var lastButtonWasMode = false
    @State var savedInt = 0
    @State var currentInt = 0
    var body: some View {
        Grid{
            GridRow {
                CalculatorButton(buttonText: "c",  action: clearWasPressed(button:))
                CalculatorButton(buttonText: "+/-", action: modeWasPressed(button:), mode: .change)
                CalculatorButton(buttonText: "%", action: modeWasPressed(button:), mode: .percentage)
                CalculatorButton(color: .orange, buttonText: "/", action: modeWasPressed(button:), mode:.divide)
            }
            GridRow {
                CalculatorButton(buttonText: "7", action: buttonWasPressed)
                CalculatorButton(buttonText: "8", action: buttonWasPressed)
                CalculatorButton(buttonText: "9", action: buttonWasPressed)
                CalculatorButton(color: .orange, buttonText: "*", action: modeWasPressed(button:), mode: .multiplication)
            }
                        GridRow{
                CalculatorButton(buttonText: "4", action: buttonWasPressed)
                CalculatorButton(buttonText: "5", action: buttonWasPressed)
                CalculatorButton(buttonText: "6", action: buttonWasPressed)
                            CalculatorButton(color: .orange, buttonText: "-", action: modeWasPressed(button:), mode:.subtraction)
            }
            GridRow{
                CalculatorButton(buttonText: "1", action: buttonWasPressed)
                CalculatorButton(buttonText: "2", action: buttonWasPressed)
                CalculatorButton(buttonText: "3", action: buttonWasPressed)
                CalculatorButton(color: .orange, buttonText: "+", action: modeWasPressed(button:), mode:.addition)
            }
            GridRow{
                CalculatorButton(width: 148, buttonText: "0", action: buttonWasPressed)
                    .gridCellColumns(2)
                CalculatorButton(color: .gray, buttonText: ".", action: buttonWasPressed)
                CalculatorButton(color: .orange, buttonText: "=", action: equalWasPressed)
            }
        
        }
    }
    
    func buttonWasPressed(button: CalculatorButton) {
        if lastButtonWasMode {
            lastButtonWasMode = false
            currentInt = 0
        }
        if let currentValueInt = Int("\(currentInt)" +
            button.buttonText) {
            currentInt = currentValueInt
            updateText()
        } else {
            currentValue = "Error"
            currentInt = 0
        }
            
    }
    
    func modeWasPressed(button: CalculatorButton) {
        currentMode = button.mode
        lastButtonWasMode = true
    }
    
    func clearWasPressed(button: CalculatorButton) {
        currentValue = "0"
        currentMode = .notSet
        lastButtonWasMode = false
        currentInt = 0
        savedInt = 0
    }
    
    func equalWasPressed(button: CalculatorButton) {
        if currentMode == .notSet || lastButtonWasMode{
            return
        }
        
        if currentMode == .addition {
            savedInt += currentInt
        } else if currentMode == .subtraction {
            savedInt -= currentInt
        } else if currentMode == .multiplication {
            savedInt *= currentInt
        } else if currentMode == .divide {
            savedInt /= currentInt
        }
        
        currentInt = savedInt
        updateText()
        lastButtonWasMode = true

    }
    
    func updateText() {
        if currentMode == .notSet {
            savedInt = currentInt
        }
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        currentValue = formater.string(for: currentInt) ?? "Error"
    }
    
}

struct ButtonGrid_Previews: PreviewProvider {
    @State static var currentValue = "1"
    static var previews: some View {
        ButtonGrid(currentValue: $currentValue)
    }
}
