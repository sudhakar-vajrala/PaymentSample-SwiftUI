//
//  PaymentViewModel.swift
//  PaymentSample
//
//  Created by Venkata Sudhakar Reddy on 30/04/25.
//

import Foundation
import Combine

class PaymentViewModel: ObservableObject {
    
    @Published var paymentList: [PaymentType] = []
    @Published var isLoading: Bool = false
    @Published var cancellableTimer: AnyCancellable?
    @Published var remainingTime: Int
    @Published var isTimeUp: Bool = false
    @Published var searchText: String = ""
    @Published var selectedPaymentType: PaymentType?
    var repository: PaymentTypesRepository
    var cancellables: Set<AnyCancellable> = []
    
    
    
    init(repository: PaymentTypesRepository = PaymentTypesRepositoryImplementation()) {
        self.repository = repository
        self.remainingTime = 60
        startTimer()
        getPaymentTypes()
    }
    
    func startTimer() {
        cancellableTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingTime <= 0 {
                    isTimeUp = true
                }else{
                    self.remainingTime -= 1
                }
            }
    }
    
    func getPaymentTypes() {
        isLoading = true
        repository.fetchPaymentTypes { [weak self] results in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch results {
                case .success(let paymentTypes):
                    self?.paymentList = paymentTypes
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    var filterPaymentTypes: [PaymentType] {
        if searchText.isEmpty {
            return paymentList
        }else {
            return paymentList.filter{
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        
    }
    
    func selectPaymentType(_ paymentType: PaymentType) {
        selectedPaymentType = paymentType
    }
    
}
