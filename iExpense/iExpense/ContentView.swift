//
//  ContentView.swift
//  iExpense
//
//  Created by Macbook Pro on 26/01/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){ item in

                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name).font(.headline)
                            Text(item.type)
Spacer()
                            Text(item.amount,format: .currency(code: "USD"))
                        }
                    }
                }.onDelete(perform: delSelection)
            }.navigationTitle("IExpense")
                .toolbar {
                    Button {
                        showingAddExpense = true

                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }.sheet(isPresented: $showingAddExpense){
                    addExpense(expenses: expenses)
                }
        }
    }
    func delSelection(at offset: IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
