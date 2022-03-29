//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/29.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    
    func attachAddpaymentMethod()
    func detachAddpaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
}

protocol TopupInteractorDependency {
    var cardsOnFileRepository: CardOnFileRepository { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AdaptivePresentationControllerDelegate {
 
    
        weak var router: TopupRouting?
    weak var listener: TopupListener?
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy

    private let dependency: TopupInteractorDependency
    init(
        dependency: TopupInteractorDependency
    ) {
        self.dependency = dependency
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init()
        self.presentationDelegateProxy.delegate = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if dependency.cardsOnFileRepository.cardOnFile.value.isEmpty {
            // 카드 추가 화면
            router?.attachAddpaymentMethod()
        } else {
            // 금액 입력 화면
            router?.attachEnterAmount()
        }
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }
    
    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidTapClose() {
        router?.detachAddpaymentMethod()
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        
    }
    
    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }
}
