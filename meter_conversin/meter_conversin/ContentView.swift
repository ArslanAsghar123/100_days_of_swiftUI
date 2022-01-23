//
//  ContentView.swift
//  meter_conversin
//
//  Created by Macbook Pro on 21/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var convertedValue = 0.0
    @State private var SelectedUnit : String = ""
    @State private var finalUnit : String = ""
    @FocusState private var enableFocus : Bool
    
    
    let unitSelection = ["KM","MT","YD","FT"]
    let outputUnits = ["KM","MT","YD","FT"]

    var finalVal : Double {
        let value = Double(convertedValue)
        let getUnit = SelectedUnit
        let selectUnit = finalUnit
        
        if(getUnit == "KM"){
            if(selectUnit == "KM"){
                return value
            }else if(selectUnit == "MT"){
                return value * 1000
            }else if(selectUnit == "YD"){
                return value * 1094
            }else if (selectUnit == "FT"){
                return value * 3281
            }
            return value
        }else if(getUnit == "MT"){
            if(selectUnit == "KM"){
                return value / 1000
            }else if(selectUnit == "MT"){
                return value
            }else if(selectUnit == "YD"){
                return value * 1.094
            }else if (selectUnit == "FT"){
                return value / 1609
            }
            return value
        }else if(getUnit == "YD"){
            if(selectUnit == "KM"){
                return value / 1094
            }else if(selectUnit == "MT"){
                return value / 1.094
            }else if(selectUnit == "YD"){
                return value
            }else if (selectUnit == "FT"){
                return value * 3
            }
            return value
        
        }else if(getUnit == "FT"){
            if(selectUnit == "KM"){
                return value / 3281
            }else if(selectUnit == "MT"){
                return value / 3.281
            }else if(selectUnit == "YD"){
                return value / 3
            }else if (selectUnit == "FT"){
                return value
            }
             return value
        }
        return value
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter number", value: $convertedValue,format: .number).keyboardType(.decimalPad).focused($enableFocus)
                    Picker("Select Unit", selection: $SelectedUnit){
                        ForEach(unitSelection, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
            }
                Section{
                    Picker("Select Unit", selection: $finalUnit){
                        ForEach(outputUnits, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select the unit")
                }
                Section{
                    Text(finalVal,format: .number)
                }
        }.navigationTitle("unit")
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
