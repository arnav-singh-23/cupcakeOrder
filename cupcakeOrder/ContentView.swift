//
//  ContentView.swift
//  cupcakeOrder
//
//  Created by ARNAV SINGH on 23/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var order  = Order()
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("SELECT YOUR CUPCAKE TYPE" ,selection: $order.type) {
                        ForEach(Order.types.indices , id:\.self){
                            Text(Order.types[$0].capitalized)
                               
                        }
                    }
                    
                    Stepper("NO. OF CUPCAKES : \(order.quantity)" , value: $order.quantity , in: 1...20)
                }
                Section{
                    Toggle("ANY SPECIAL REQUESTS" , isOn: $order.specialReqEnabled.animation())
                    
                    if order.specialReqEnabled{
                        Toggle("ADD EXTRA FROSTING" , isOn: $order.extraFrosting)
                        
                        Toggle("ADD EXTRA SPRINKLES" , isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Delivery address") {
                        AddressView(order: order)
                    }
                } footer: {
                    Text("Total: \(order.cost, format: .currency(code: "INR").precision(.fractionLength(0)))")
                }
            }.navigationTitle("Cupcake Corner")
        }
        
        
    }
}

#Preview {
    ContentView()
}
