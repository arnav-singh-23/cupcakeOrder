//
//  Order.swift
//  cupcakeOrder
//
//  Created by ARNAV SINGH on 23/10/26.
//

import SwiftUI

@Observable
class Order : Codable{
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialReqEnabled = "specialReqEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetname = "streetname"
        case _zip = "zip"
    }
    
    static let types = ["vanilla" ,"butterscotch" ,  "strawberry" , "rainbow" , "chocolate"]
    
    var type = 0
    var quantity = 3
    
    var specialReqEnabled = false{
        didSet{
            if specialReqEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }}
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetname = ""
    var city = ""
    var zip = ""
    var hasValidAddress: Bool{
        if name.isEmpty || streetname.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost : Decimal {
        // cake
        var cost = Decimal(quantity)*50
         
        //flavour pricing
        cost += Decimal(type)*5
        
        //frosting
        if extraFrosting {
            cost += Decimal(quantity)*10
        }
        //sprinkles
        if addSprinkles {
            cost += Decimal(quantity)*5
        }
        return cost
        
    }
}

