//
//  PaymentListView.swift
//  PaymentSample
//
//  Created by Venkata Sudhakar Reddy on 02/05/25.
//

import SwiftUI
import Combine

struct PaymentListView: View {
    
    @ObservedObject var model: PaymentViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            if model.isLoading {
                ProgressView("Loading...")
                    .padding()
            }else {
                List(model.filterPaymentTypes) { type in
                    HStack {
                        Text(type.name)
                        Spacer()
                        if model.selectedPaymentType?.id == type.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        model.selectPaymentType(type)
                    }
                }
                .refreshable {
                    model.getPaymentTypes()
                }
            }
        }
        .navigationTitle("Payment List")
        .searchable(text: $model.searchText, prompt: "Search Payment")
        .navigationBarItems(trailing:
                                Button("Done"){
            isPresented = false
        }.disabled(model.selectedPaymentType == nil)
        )
    }
}

