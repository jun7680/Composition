//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/06.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {

    weak var listener: CardOnFileDashboardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "카드 및 계좌"
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let cardonFileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var addMethodButton: AddPaymentMethodButton = {
        let button = AddPaymentMethodButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners()
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(headerStackView)
        view.addSubview(cardonFileStackView)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(seeAllButton)
        
        let paymentView = PaymentMethodView()
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        
        cardonFileStackView.addArrangedSubview(paymentView)
        cardonFileStackView.addArrangedSubview(addMethodButton)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardonFileStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            cardonFileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardonFileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardonFileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addMethodButton.heightAnchor.constraint(equalToConstant: 60),
            paymentView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    @objc
    private func seeAllButtonTapped() {
        
    }
    
    @objc
    private func addButtonDidTap() {
        
    }
}
