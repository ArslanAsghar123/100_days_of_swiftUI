//
//  Dtaa.swift
//  CupcakeCorner
//
//  Created by Macbook Pro on 12/02/2022.
//

import SwiftUI

struct Data: View {
    @ObservedObject var order: Order
    var body: some View {
        
            Form{
                Section{
                    TextField("Name",text: $order.name)
                    TextField("Address",text: $order.address)
                    TextField("City", text: $order.city)
                    TextField("zipcode",text: $order.zipCode)
                }
                Section{
                    NavigationLink {
                        CheckOut(order: order)
                    } label: {
                        Text("Checkout")
                    }
                }.disabled(order.hasValidAddress == false)

            }
            .navigationTitle("Delivery details")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    
}

struct Data_Previews: PreviewProvider {
    static var previews: some View {
        Data(order: Order())
    }
}
