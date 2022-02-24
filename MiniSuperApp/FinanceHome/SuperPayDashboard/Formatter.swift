//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by 옥인준 on 2022/02/24.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        return formatter
    }()
}
