//
//  ContentView.swift
//  Calculator
//
//  Created by Maria Reyna on 12/29/23.
//

import SwiftUI
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
struct ContentView: View {
    @State var currentOperation: Operation = .none
    @State var value = 0
    @State var nextNum = 0
    let diffbuttons: [[Calcbuttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .ad],
        [.zero, .decimal, .equal]
    ]
    var w = CGFloat(70)
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack(spacing: 12){
                    Spacer()
                    Text("\(value)")
                        .bold()
                        .font(.system(size: 60))
                        .foregroundStyle(.white)
                        .padding()
                }
                .padding()
                ForEach(diffbuttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(butt: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .frame(width: customWidth(butt: item), height: 85)
                                    .background(switchColorButton(butt: item))
                                    .foregroundStyle(.white)
                                    .cornerRadius(70)
                                    
                            })
                            
                        }
                        
                    }
                    
                }
            }
        }
    }
    func didTap(butt: Calcbuttons){
        switch butt{
        case .ad, .subtract, .multiply,.divide, .equal:
            if butt == .ad {
                self.currentOperation = .add
                self.nextNum = self.value
            }
            else if butt == .subtract{
                self.currentOperation = .sub
                self.nextNum = self.value
            }
            else if butt == .multiply{
                self.currentOperation = .mult
                self.nextNum = self.value
            }
            else if butt == .divide{
                self.currentOperation = .divide
                self.nextNum = self.value
            }else if butt == .equal {
                let nextValue = self.nextNum
                let currentValue = self.value
                switch self.currentOperation {
                case .add:
                    self.value = nextValue + currentValue
                    print(nextValue)
                    print(currentValue)
                case .sub:
                    self.value = nextValue - currentValue
                    print(nextValue)
                    print(currentValue)
                case .mult:
                    self.value = nextValue * currentValue
                    print(nextValue)
                    print(currentValue)
                case .divide:
                    if currentValue > 0 {
                        self.value = nextValue / currentValue
                    } else {
                        self.value = 0
                    }
                    print(nextValue)
                    print(currentValue)
                case .none:
                    break
                }
            }
            if butt != .equal {
                self.value = 0
            }
            
        case .clear:
            self.value = 0
        case .decimal:
           //  let newValue = Int(self.value + ".") ?? 0
            break
            
        case.negative,.percent:
            break
        default:
           let number = butt.rawValue
            if self.value == 0 {
                value = Int(number) ?? 0
            }else {
               // self.value = "\(self.value)\(number)"
                self.value = 0
            }
            
        }
    }
}

func ifOperationButtonPressed(but: Calcbuttons) -> Operation {
    switch but {
    case .zero, .one, .two, .three, .four,.five,.six,.seven,.eight,.nine, .decimal:
        // return the op for cals
        return .none
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
#Preview {
    ContentView()
}
