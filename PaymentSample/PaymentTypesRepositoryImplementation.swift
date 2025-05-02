//
//  PaymentTypesRepositoryImplementation.swift
//  PaymentSample
//
//  Created by Venkata Sudhakar Reddy on 27/04/25.
//

import Foundation

struct PaymentType: Identifiable {
    var id: String = UUID().uuidString
    var name: String
}

enum PaymentError: Error {
    case timeout
}

protocol PaymentTypesRepository {
    func fetchPaymentTypes(completion: @escaping (Swift.Result<[PaymentType], PaymentError>) -> Void)
}
class PaymentTypesRepositoryImplementation: PaymentTypesRepository {
    func fetchPaymentTypes(completion: @escaping (Result<[PaymentType], PaymentError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(self.fetchPaymentTypes()))
        }
    }
    
    func fetchPaymentTypes() -> [PaymentType] {
        return [
            PaymentType(name: "Apple Pay"),
            PaymentType(name: "Visa"),
            PaymentType(name: "Master Card"),
            PaymentType(name: "Google Pay"),
            PaymentType(name: "maestro"),
            PaymentType(name: "PayPal"),
        ]
    }
}

