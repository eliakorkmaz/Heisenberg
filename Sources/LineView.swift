//
//  LineView.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import UIKit

open class LineView: UIView{
    
    var bond: BondType
    var startPoint: CGPoint
    var endPoint: CGPoint
    var color: UIColor
    var itemSize: Int
    
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3)
        context?.setStrokeColor(color.cgColor)
            
        var points = [(startPoint: CGPoint, endPoint: CGPoint)]()
        
        switch bond {
        case .SingleBond:
            points.append((startPoint: CGPoint(x: 0, y: itemSize/2-1), endPoint: CGPoint(x: itemSize, y: itemSize/2-1)))
        case .DoubleBond:
            points.append((startPoint: CGPoint(x: 0, y: itemSize/2-4), endPoint: CGPoint(x: itemSize, y: itemSize/2-4)))
            points.append((startPoint: CGPoint(x: 0, y: itemSize/2+4), endPoint: CGPoint(x: itemSize, y: itemSize/2+4)))
        case .TripleBond:
            points.append((startPoint: CGPoint(x: 0, y: itemSize/2-6), endPoint: CGPoint(x: itemSize, y: itemSize/2-6)))
            points.append((startPoint: CGPoint(x: 0, y: itemSize/2), endPoint: CGPoint(x: itemSize, y: itemSize/2)))
            points.append((startPoint: CGPoint(x: 0, y: itemSize/2+6), endPoint: CGPoint(x: itemSize, y: itemSize/2+6)))
        }
        
        for point in points {
            
            context?.move(to: point.startPoint)
            context?.addLine(to: point.endPoint)
            
        }
        
        context?.strokePath()
    }
    
    
    
    private override init(frame: CGRect) {
        self.bond = .SingleBond
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 0, y: 0)
        self.color = UIColor.black
        self.itemSize = 40
        
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    public init(frame: CGRect, startPoint: CGPoint, endPoint: CGPoint, itemSize: Int, bond: BondType, color: UIColor?){
        
        self.bond = bond
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.color = color ?? UIColor.black
        self.itemSize = itemSize
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public enum BondType: Int{
        case SingleBond = 1
        case DoubleBond = 2
        case TripleBond = 3
    }

}
