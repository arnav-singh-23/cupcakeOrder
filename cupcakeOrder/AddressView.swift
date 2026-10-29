//
//  AddressView.swift
//  cupcakeOrder
//
//  Created by ARNAV SINGH on 23/10/26.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order = Order()
    var body: some View {
        Form{
            Section {
                TextField("Name", text: $order.name)
                    .textContentType(.name)
                TextField("Street", text: $order.streetname)
                    .textContentType(.streetAddressLine1)
                TextField("City", text: $order.city)
                    .textContentType(.addressCity)
                TextField("PIN code", text: $order.zip)
                    .textContentType(.postalCode)
                    .keyboardType(.numberPad)
            }
            Section{
                NavigationLink("CHECK OUT"){
                    CheckoutView(order: order)
                }
            }.disabled(order.hasValidAddress == false)
            
        }.navigationTitle("DELIVERY DETAILS")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
