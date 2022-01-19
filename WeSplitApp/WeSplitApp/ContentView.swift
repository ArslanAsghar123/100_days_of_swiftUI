//
//  ContentView.swift
//  WeSplit
//
//  Created by Macbook Pro on 18/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var totalCost = 0.0
    @State private var totalPeople = 2
    @State private var tripPercentage = 20
    @FocusState private var enableFocus : Bool
    
    let tripSelection = [10,15,20,25,0]
    
    var totalSplit: Double{
        let totalPeoples = Double(totalPeople + 2)
        let tripPercent = Double(tripPercentage)
        
        
        let tipadded = totalCost * tripPercent / 100
        let costNow = tipadded + totalCost
        let totalDivide = costNow / totalPeoples
        return totalDivide
        
        
    }
    @State private var select = "Harry"
    var body: some View {
        NavigationView{
            Form{
                Section{   TextField("0.0",value: $totalCost,format: .currency(code: Locale.current.currencyCode ?? "USD")).keyboardType(.decimalPad).focused($enableFocus)
                  Picker("Number of people",selection: $totalPeople){
                    ForEach (2..<100){
                        Text("\($0) people")
                    }
                  }
                }
                Section{
                    Picker("TIP Percentage", selection: $tripPercentage){
                        ForEach(tripSelection, id: \.self){
                            Text("\($0)%")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("how much tip do you want to leave")
                }
                Section{
                    Text(totalSplit,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }
            }.navigationTitle("WeSplit")
                .toolbar{ ToolbarItemGroup(placement: .keyboard){
                    Button("Done") {
                                enableFocus = false
                    }
                }}
        }
    
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
