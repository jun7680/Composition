//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/06.
//

import Foundation

protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}


final class CardOnFileRepositoryImp: CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "신한은행", digits: "2123", color: "#3478f6ff", isPrimary: false),
        PaymentMethod(id: "2", name: "카카오은행", digits: "1423", color: "#78c5f5ff", isPrimary: false),
        PaymentMethod(id: "3", name: "국민은행", digits: "5423", color: "#65c456ff", isPrimary: false),
        PaymentMethod(id: "4", name: "현대은행", digits: "6723", color: "#ffcc00ff", isPrimary: false)
    ])
}
