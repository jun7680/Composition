import ModernRIBs

protocol FinanceHomeRouting: ViewableRouting {
    func attachSuperPayDashboard()
    func attachCardOnFileDashboard()
    func attaachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachTopup()
    func detachTopup()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
}

protocol FinanceHomeListener: AnyObject {
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>,
                                   FinanceHomeInteractable,
                                   FinanceHomePresentableListener, AdaptivePresentationControllerDelegate {
  
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FinanceHomePresentable) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init(presenter: presenter)
        presenter.listener = self
        self.presentationDelegateProxy.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        router?.attachSuperPayDashboard()
        router?.attachCardOnFileDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func presentationControllerDidDismiss() {
        router?.detachAddPaymentMethod()
    }
    
    // MARK: - CardOnFileDashboardListener
    func cardOnFileDashboardDidTapAddPaymentMethod() {
        router?.attaachAddPaymentMethod()
    }
    
    // MARK: - AddPaymentMethodListener
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        router?.detachAddPaymentMethod()
    }
    
    func superPayDashboardDidTapTopup() {
        router?.attachTopup()
    }
    
    func topupDidClose() {
        router?.detachTopup()
    }
}
