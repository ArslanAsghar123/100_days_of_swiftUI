//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Macbook Pro on 12/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your type", selection: $order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.quantity)",value:$order.quantity,in: 3...20)
                }
                Section
                {
                    Toggle("Any special request",isOn:$order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting",isOn:$order.extraFrosting)
                        Toggle("Any extra sprinkle",isOn:$order.addSprinkles)

                    }
                }
                Section{
                    NavigationLink {
                        Data(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }.navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
