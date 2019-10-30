//
//  CustomViewConvertible.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import UIKit


// MARK: CustomViewConvertible Protocol
protocol CustomViewConvertible{
    associatedtype Value:Equatable
    
    func toView(with frame: CGRect, color: UIColor?, itemSize: Int) -> UIView
}
