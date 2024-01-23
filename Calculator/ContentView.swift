//
//  ContentView.swift
//  Calculator
//
//  Created by Maria Reyna on 12/29/23.
//

import SwiftUI

//repetitve code try and dumb it down to functions
struct ContentView: View {
    @ObservedObject var vm = CalculatorVM()
   
    var w = CGFloat(70)
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack(spacing: 12){
                    Spacer()
                    Text("\(vm.displayedValue)")
                        .bold()
                        .font(.system(size: vm.adjustFontSize(size: vm.displayedValue.count)))
                        .foregroundStyle(.white)
                        .padding()
                }
                .padding()
                ForEach(vm.diffbuttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                vm.self.didTap(butt: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .frame(width: vm.customWidth(butt: item), height: 85)
                                    .background(vm.switchColorButton(butt: item))
                                    .foregroundStyle(.white)
                                    .cornerRadius(70)
                                
                                
                            })
                        }
                    }
                }
            }
        }
    }
}
    #Preview {
        ContentView()
    }
