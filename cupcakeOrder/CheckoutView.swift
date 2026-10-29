//
//  CheckoutView.swift
//  cupcakeOrder
//
//  Created by ARNAV SINGH on 27/10/26.
//

import SwiftUI

struct CheckoutView : View {
    var order = Order()
    
    @State private var alertTitle = ""
    @State private var ConfirmationMsg = ""
    @State private var ShowingConfirmation = false
    var body: some View {
        ScrollView{
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("\(order.quantity) × \(Order.types[order.type].capitalized)")
                    .font(.headline)

                Text("Total: \(order.cost, format: .currency(code: "INR").precision(.fractionLength(0)))")
                    .font(.title)

                Button("Place order") {
                    Task { await placeOrder() }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
        }  .navigationTitle("CHECK OUT")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize )
            .alert("THANK YOU!!", isPresented: $ShowingConfirmation){
                Button("OK"){}
            } message: {
                 Text(ConfirmationMsg)
            }
        
        
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            alertTitle = "Oops!"
            ConfirmationMsg = "Couldn't prepare your order."
            ShowingConfirmation = true
            return
        }

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)

            alertTitle = "Thank you!"
            ConfirmationMsg = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
        } catch {
            alertTitle = "Checkout failed"
            ConfirmationMsg = error.localizedDescription
        }
        ShowingConfirmation = true
    }
}

#Preview {
    CheckoutView(order: Order())
}
