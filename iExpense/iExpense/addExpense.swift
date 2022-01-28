//
//  addExpense.swift
//  iExpense
//
//  Created by Macbook Pro on 29/01/2022.
//

import SwiftUI

struct addExpense: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var expense = 0.0
    @State private var type = "Expensive"
    
    let types = ["Buisness","Personal"]
    var body: some View {
        
        NavigationView{
            Form{
                TextField("Name",text: $name)
                
                Picker("Type",selection: $type){
                    ForEach(types, id:\.self){
                        Text($0)
                    }
                }
                TextField("Enter Amounr",value: $expense,format: .currency(code: "USD")).keyboardType(.decimalPad)
                
                
            }.navigationTitle("Add New Expense")
                .toolbar{
                    Button("Save") {
                        let item = ExpeneItem(name: name, type: type, amount: expense)
                        expenses.items.append(item)
                        dismiss()
                    }
            }
        }
    }
}

struct addExpense_Previews: PreviewProvider {
    static var previews: some View {
        addExpense(expenses: Expenses())
    }
}
