//
//  Order.swift
//  CupcakeCorner
//
//  Created by Macbook Pro on 12/02/2022.
//

import Foundation


class Order: ObservableObject,Codable {
    
    enum CodingKeys: CodingKey{
        case type,quantity,extraFrosting,addSprinkles,name,address,city,zipCode
    }
    static let types = ["Vanila","Strawberry","Chocolate","Cherry","Mango"]
    
    @Published var type = 0
    @Published var quantity = 0
    
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zipCode = ""
    
    var hasValidAddress : Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }
        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double()/2)
        
        
        // $1/per cake for extra frosty

        if extraFrosting{
            cost += Double(quantity)
        }
        
        // $0.5/per cake for extra frosty

        if addSprinkles{
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    init(){ }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zipCode, forKey: .zipCode)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        zipCode = try container.decode(String.self, forKey: .zipCode)
    }
    
}
