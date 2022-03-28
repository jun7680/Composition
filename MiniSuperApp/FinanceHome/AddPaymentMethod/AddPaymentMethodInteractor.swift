//
//  AddPaymentMethodInteractor.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/28.
//

import ModernRIBs
import Combine

protocol AddPaymentMethodRouting: ViewableRouting {
    
}

protocol AddPaymentMethodPresentable: Presentable {
    var listener: AddPaymentMethodPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol AddPaymentMethodListener: AnyObject {
    func addPaymentMethodDidTapClose()
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod)
}

protocol AddPaymentMethodInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class AddPaymentMethodInteractor: PresentableInteractor<AddPaymentMethodPresentable>, AddPaymentMethodInteractable, AddPaymentMethodPresentableListener {

    weak var router: AddPaymentMethodRouting?
    weak var listener: AddPaymentMethodListener?
    
    private let dependency: AddPaymentMethodInteractorDependency
    private var cancelladbe: Set<AnyCancellable>

    init(
        presenter: AddPaymentMethodPresentable,
        dependency: AddPaymentMethodInteractorDependency
    ) {
        self.dependency = dependency
        self.cancelladbe = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapClose() {
        listener?.addPaymentMethodDidTapClose()
    }
    
    func didTapConfirm(with number: String, cvc: String, expire: String) {
        let info = AddPaymentMethodInfo(number: number, cvc: cvc, expire: expire)
        dependency.cardOnFileRepository.addCard(info: info).sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] method in
                self?.listener?.addPaymentMethodDidAddCard(paymentMethod: method)
            })
        .store(in: &cancelladbe)
    }
}
