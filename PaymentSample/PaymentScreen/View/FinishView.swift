//
//  FinishView.swift
//  PaymentSample
//
//  Created by Venkata Sudhakar Reddy on 02/05/25.
//

import SwiftUI

struct FinishView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
                
            Text("Payment Successful")
                .font(.largeTitle)
            Text("Thank you for your payment")
                .font(.headline)
        }
        .navigationBarBackButtonHidden(false)
    }
}
#Preview {
    FinishView()
}
