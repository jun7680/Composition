//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/29.
//

import ModernRIBs

protocol TopupInteractable: Interactable,
                            AddPaymentMethodListener,
                            EnterAmountListener {
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol TopupViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    
    private var navigationControllable: NavigationControllerable?

    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?
    private let enterAmountBuildable: EnterAmountBuildable
    private var enterAmountRounting: Routing?
    
    init(
        interactor: TopupInteractable,
        viewController: ViewControllable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable,
        enterAmountBuildable: EnterAmountBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.enterAmountBuildable = enterAmountBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        if viewController.uiviewController.presentedViewController != nil, navigationControllable != nil {
            navigationControllable?.dismiss(completion: nil)
        }
    }
    
    func attachAddpaymentMethod() {
        if addPaymentMethodRouting != nil { return }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        
        presentinsideNavigation(router.viewControllable)
        attachChild(router)
        addPaymentMethodRouting = router
        
    }
    func detachAddpaymentMethod() {
        guard let router = addPaymentMethodRouting else { return }
        
        dismissPresentedNavigation(completion: nil)
        detachChild(router)
        addPaymentMethodRouting = nil
    }
    
    func attachEnterAmount() {
        if enterAmountRounting != nil { return }
        
        let router = enterAmountBuildable.build(withListener: interactor)
        
        presentinsideNavigation(router.viewControllable)
        attachChild(router)
        enterAmountRounting = router
    }
    
    func detachEnterAmount() {
        guard let router = enterAmountRounting else { return }
        
        dismissPresentedNavigation(completion: nil)
        detachChild(router)
        enterAmountRounting = nil
    }
    
    private func presentinsideNavigation(_ viewControllable: ViewControllable) {
        let navigation = NavigationControllerable(root: viewControllable)
        self.navigationControllable = navigation
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        viewController.present(navigation, animated: true, completion: nil)
    }

    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        viewController.dismiss(completion: nil)
        self.navigationControllable = nil
    }
    // MARK: - Private

    private let viewController: ViewControllable
}
