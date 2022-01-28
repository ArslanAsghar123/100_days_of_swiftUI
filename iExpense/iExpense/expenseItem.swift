//
//  expenseItem.swift
//  iExpense
//
//  Created by Macbook Pro on 27/01/2022.
//

import Foundation


struct ExpeneItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
