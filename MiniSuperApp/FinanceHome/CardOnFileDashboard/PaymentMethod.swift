//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/03/06.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
