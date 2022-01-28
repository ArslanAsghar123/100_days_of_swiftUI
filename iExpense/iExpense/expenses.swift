//
//  expenses.swift
//  iExpense
//
//  Created by Macbook Pro on 27/01/2022.
//

import Foundation

class Expenses: ObservableObject{
    @Published var items = [ExpeneItem]()
    {
        didSet {
            if let eccode = try?JSONEncoder().encode(items){
                UserDefaults.standard.set(eccode, forKey: "Items")
            }
        }
    }
        init(){
            if let savedItem =  UserDefaults.standard.data(forKey: "Items"){
                if let decodeItems = try? JSONDecoder().decode([ExpeneItem].self, from: savedItem){
                    items = decodeItems
                    return
                }
            }
            items = []
    }
}
