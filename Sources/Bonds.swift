//
//  Bonds.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import Foundation

public enum LineViewBondType: Int{
    case singleBond = 1
    case doubleBond = 2
    case tripleBond = 3
}

public enum AtomBondType: String {
    case singleBond = "➡️"
    case doubleBond = "⏩"
    case tripleBond = "⏭"
    case notBonded = ""
    
    func convert() -> LineViewBondType{
        switch self {
        case .singleBond:
            return .singleBond
        case .doubleBond:
            return .doubleBond
        case .tripleBond:
            return .tripleBond
        case .notBonded:
            return LineViewBondType.init(rawValue: -1)!
        }
    }
}
