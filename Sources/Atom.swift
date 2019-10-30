//
//  Atom.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import UIKit


// MARK: - Definition of Atom class
public class Atom<Value>: Atomable{
    public typealias AtomValue = Value
    
    public var atomicNumber: Int
    public var symbol: AtomValue
    public var electronConfiguration: AtomValue
    public var name: AtomValue
    public var atomicWeight: Float
    public var backgroundColor: UIColor?
    
    var nextAtom: Atom?
    var bondType: BondType
    
    public init(with value: Value, color: UIColor? = nil){
        self.bondType = .NotBonded
        self.atomicNumber = 1
        self.symbol = value
        self.name = value
        self.atomicWeight = 55.123
        self.electronConfiguration = value
        self.backgroundColor = color
    }

    public enum BondType: String {
        case SingleBond = "➡️"
        case DoubleBond = "⏩"
        case TripleBond = "⏭"
        case NotBonded = ""
        
        func convert() -> LineView.BondType{
            switch self {
            case .SingleBond:
                return LineView.BondType(rawValue: 1)!
            case .DoubleBond:
                return LineView.BondType(rawValue: 2)!
            case .TripleBond:
                return LineView.BondType(rawValue: 3)!
            default:
                return LineView.BondType(rawValue: 0)!
            }
        }
    }
    
    func generateUI(with itemSize: CGFloat) -> UIView {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: itemSize, height: itemSize))
        containerView.layer.cornerRadius = itemSize / 2
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 2.5
        
        let symbolLabel = UILabel(frame: CGRect(x: 0, y: 0, width: itemSize, height: itemSize))
        symbolLabel.textAlignment = .center
        symbolLabel.font = UIFont.boldSystemFont(ofSize: 18)
        symbolLabel.text = "\(symbol)"
        containerView.addSubview(symbolLabel)
        symbolLabel.center = containerView.center
        
        return containerView
    }
    
}




extension Atom: CustomStringConvertible{
    public var description: String{
        return "\(self.symbol)"
    }
}
