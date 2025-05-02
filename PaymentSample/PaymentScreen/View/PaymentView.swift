//
//  PaymentView.swift
//  PaymentSample
//
//  Created by Venkata Sudhakar Reddy on 30/04/25.
//

import SwiftUI

struct PaymentView: View {
    
    @StateObject var viewModel: PaymentViewModel = PaymentViewModel()
    @State var showPaymentList: Bool = false
    @State var showFinishPayment: Bool = false
    
    var body: some View {
        VStack{
            Text("Tou have only \(viewModel.remainingTime) seconds left to get the discount.")
                .font(.headline)
                .foregroundColor(viewModel.remainingTime > 10 ? .primary : .red)
            Button("Open Payment") {
                showPaymentList = true
            }
            if viewModel.selectedPaymentType != nil {
                Color.clear
                    .onAppear {
                        showFinishPayment = true
                    }
            }
//                    Button("Finish Payment") {
//                        showFinishPayment = true
//                    }
    }
            .sheet(isPresented: $showPaymentList){
                NavigationStack {
                    PaymentListView(model: viewModel, isPresented: $showPaymentList)
                }
            }
            .fullScreenCover(isPresented: $showFinishPayment) {
                FinishView()
            }
            .padding()
    }
}

#Preview {
    PaymentView()
}
