//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/29.
//

import ModernRIBs

protocol TopupDependency: Dependency {
    var topupBaseViewController: ViewControllable { get }
    var cardsOnFileRepository: CardOnFileRepository { get }
}

final class TopupComponent: Component<TopupDependency>,
                            TopupInteractorDependency,
                            AddPaymentMethodDependency,
                            EnterAmountDependency {
    var cardsOnFileRepository: CardOnFileRepository { dependency.cardsOnFileRepository }
    fileprivate var topupBaseViewController: ViewControllable { return dependency.topupBaseViewController }
}

// MARK: - Builder

protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> TopupRouting
}

final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {
    
    override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: TopupListener) -> TopupRouting {
        let component = TopupComponent(dependency: dependency)
        let interactor = TopupInteractor(dependency: component)
        interactor.listener = listener
        
        let addPaymentBuilder = AddPaymentMethodBuilder(dependency: component)
        let enterAmountBuilder = EnterAmountBuilder(dependency: component)
        return TopupRouter(
            interactor: interactor,
            viewController: component.topupBaseViewController,
            addPaymentMethodBuildable: addPaymentBuilder,
            enterAmountBuildable: enterAmountBuilder
        )
    }
}
