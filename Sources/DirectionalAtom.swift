//
//  DirectionalAtom.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import UIKit


// MARK: - Definition of Directional Atom Class
open class DirectionalAtom<Value>: Atomable where Value: Equatable{
    public typealias AtomValue = Value
    
    open var atomicNumber: Int
    open var symbol: Value
    open var electronConfiguration: Value
    open var name: Value
    open var atomicWeight: Float
    open var backgroundColor: UIColor?
    open var textColor: UIColor?
    
    weak var nextAtom: DirectionalAtom<Value>?
    weak var upwardAtom: DirectionalAtom<Value>?
    weak var downwardAtom: DirectionalAtom<Value>?
    
    public init(with value: Value, color: UIColor? = nil, textColor: UIColor? = nil) {
        nextAtom = nil
        self.upwardAtom = nil
        self.downwardAtom = nil
        
        
        atomicNumber = 1
        symbol = value
        electronConfiguration = value
        name = value
        atomicWeight = 1.1
        backgroundColor = color
        self.textColor = textColor ?? .black
    }
    
}



// MARK:- DirectionalAtom Hashable Custom String Convertible

extension DirectionalAtom: Hashable{
    
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }

    public static func == (lhs: DirectionalAtom<Value>, rhs: DirectionalAtom<Value>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}

// MARK: - Extension of DirectionalAtom's Convertibless
extension DirectionalAtom: CustomStringConvertible{
    public var description: String{
        return "\(self.symbol)"
    }
}

extension DirectionalAtom: CustomViewConvertible{
    
    func toView(with frame: CGRect, color: UIColor?, itemSize: Int) -> UIView {
        
        let atomView = UIView(frame: frame)

        atomView.layer.cornerRadius = atomView.frame.width / 2.0
        atomView.layer.borderWidth = 2.0
        atomView.layer.borderColor = UIColor.black.cgColor
        atomView.backgroundColor = color ?? .white
            
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: itemSize, height: itemSize))
        label.textAlignment = .center
        label.text = "\(self.name)"
        label.textColor = textColor ?? .black
            
        let subView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: itemSize, height: itemSize))
        atomView.addSubview(subView)
        
        subView.addSubview(label)
        label.center = subView.center

        return atomView
    }

}

