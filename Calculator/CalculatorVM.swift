//
//  CalculatorVM.swift
//  Calculator
//
//  Created by Maria Reyna on 1/23/24.
//

import Foundation
import SwiftUI
class CalculatorVM: ObservableObject {
    @Published var displayedValue = "0"
    @Published var tooManyNumbers = false
    @Published var firstDecimalNum = 0.0
    @Published var previousValue = 0
    @Published var selectedOperation = Operation.add
    let diffbuttons: [[Calcbuttons]] = [
    [.clear, .negative, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .subtract],
    [.one, .two, .three, .ad],
    [.zero, .decimal, .equal]
]
    enum Calcbuttons: String{
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ad = "+"
        case subtract = "-"
        case multiply = "x"
        case divide = "÷"
        case equal = "="
        case clear = "AC"
        case decimal = "."
        case percent = "%"
        case negative = "-/+"
    }
    enum Operation{
        case add,sub,mult,divide,none
    }
    
    func didTap(butt: Calcbuttons){
        switch butt{
        case .ad, .subtract, .multiply, .divide:
            let operation = operationSelected(butt: butt)
            self.selectedOperation = operation
            if displayedValue.contains(".") {
                firstDecimalNum = Double(displayedValue) ?? 0
            } else {
                self.previousValue = Int(self.displayedValue) ?? 0
            }
            displayedValue = "0"
        case .equal:
            doTheOperation()
            
        case .clear:
            self.displayedValue = "0"
        case .decimal:
            if !displayedValue.contains(".") {
                displayedValue += "."
            }
        case.negative,.percent:
            break
        default:
            let number = butt.rawValue
            if self.displayedValue == "0"{
                displayedValue = number
            }else {
                self.displayedValue = "\(self.displayedValue)\(number)"
            }
            
        }
    }

 func ifOperationButtonPressed(but: Calcbuttons) -> Operation {
     switch but {
     case .zero, .one, .two, .three, .four,.five,.six,.seven,.eight,.nine, .decimal:        return .none
     case .ad:
         return .add
     case .subtract:
         return .sub
     case .multiply:
         return .divide
     case .divide:
         return .divide
     case .equal:
         return .none
     case .clear:
         return .none
     case .percent:
         return .none
     case .negative:
         return .none
     }
 }
 
func operationSelected(butt: Calcbuttons) -> Operation {
    switch butt {
    case .ad: return .add
    case .subtract: return .sub
    case .multiply: return .mult
    case .divide: return .divide
    default: return .none
    }
}

    func doTheOperation(){

        let storedValue = self.previousValue
        let storedDecimalValue = firstDecimalNum
        let currentValue = Int(self.displayedValue) ?? 0
        let currentDecimalValue = Double(self.displayedValue) ?? 0.0
        
        switch self.selectedOperation {
        case .add:
            if displayedValue.contains(".") {
                self.displayedValue = "\(storedDecimalValue + currentDecimalValue)"
            } else {
                self.displayedValue = "\(storedValue + currentValue)"
            }
            print(storedValue)
            print(currentValue)
        case .sub:
            if displayedValue.contains(".") {
                self.displayedValue = "\(storedDecimalValue - currentDecimalValue)"
            } else {
                self.displayedValue = "\(storedValue - currentValue)"
            }
            print(storedValue)
            print(currentValue)
        case .mult:
            if displayedValue.contains(".") {
                self.displayedValue = "\(storedDecimalValue * currentDecimalValue)"
            } else {
                self.displayedValue = "\(storedValue * currentValue)"
            }
            print(storedValue)
            print(currentValue)
        case .divide:
            if displayedValue.contains(".") {
                self.displayedValue = "\(storedDecimalValue / currentDecimalValue)"
            } else {
                self.displayedValue = "\(storedValue / currentValue)"
            }
            print(storedValue)
            print(currentValue)
        case .none:
            break
        }
    }

    
    func customWidth(butt: Calcbuttons) -> CGFloat{
        switch butt{
        case .zero:
            return 180
        default:
            return 85
        }
    }
    func switchColorButton(butt: Calcbuttons) -> Color {
        switch butt {
        case .zero, .one, .two, .three, .four,.five,.six,.seven,.eight,.nine, .decimal:
            return .customBlack
        case .ad, .subtract, .multiply, .divide, .equal:
            return Color.orange
        case .clear, .percent, .negative:
            return .customGray
        }
    }
    
    func adjustFontSize(size: Int) -> CGFloat {
        if size > 6 {
            return 50
        } else if size > 9 {
            return 40
        } else {
            return 60
        }
    }
    
}
