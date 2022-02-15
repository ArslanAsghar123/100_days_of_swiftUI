//
//  CheckOut.swift
//  CupcakeCorner
//
//  Created by Macbook Pro on 12/02/2022.
//

import SwiftUI

struct CheckOut: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
//    var name = { data in
//        
//        
//    }
    func placeOrder() async{
        guard let encode = try? JSONEncoder().encode(order) else{
            print("Failed to encode order")
               return
        }
        
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var req = URLRequest(url: url)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpMethod = "POST"
        
        do {
            let(data,_) = try await URLSession.shared.upload(for:req, from: encode)
            
            let decode = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decode.quantity)x \(Order.types[decode.type].lowercased()) cupcakes on the way"
            showingConfirmation = true
        }catch{
            print("CheckOut failed")
        }
    }
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),scale: 3)
                { p in
                    p
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }.frame(height: 233)
                 
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order"){
                    Task{
                        await placeOrder()
                        
                    }
                    
                }
                    .padding()
        }
        
    }.navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showingConfirmation) {
                Button("OK") { }
            } message: {
                Text(confirmationMessage)
            }
}
}
struct CheckOut_Previews: PreviewProvider {
    static var previews: some View {
        CheckOut(order: Order())
    }
}
