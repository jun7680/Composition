import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashBoard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashboardBuildable
    private var superPayRouting: Routing?
    
    private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    private var cardOnFileRouting: Routing?
    
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashboardBuildable: SuperPayDashboardBuildable,
        cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuildable = cardOnFileDashboardBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        if superPayRouting != nil { return }
        let router = superPayDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        viewController.addDashBoard(dashboard)
        
        self.superPayRouting = router
        attachChild(router)
    }
    
    func attachCardOnFileDashboard() {
        if cardOnFileRouting != nil { return }
        let rounter = cardOnFileDashboardBuildable.build(withListener: interactor)
        
        let dashboard = rounter.viewControllable
        viewController.addDashBoard(dashboard)
        
        self.cardOnFileRouting = rounter
        attachChild(rounter)
    }
}
