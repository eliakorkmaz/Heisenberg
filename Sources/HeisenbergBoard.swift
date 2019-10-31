//
//  HeisenbergBoard.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import UIKit

// MARK: Heisenberg Board Definition

open class HeisenbergBoard<Value> where Value: Equatable{
    
    var boardItem: BoardItem
    var boardView: UIView
    var boardColor: UIColor
    var itemSize: Int
    
    public init(with boardStructure: BoardItem, with color: UIColor){
        self.boardItem = boardStructure
        self.boardView = UIView()
        self.boardColor = color
        self.itemSize = 0
    }
    
    
    public func drawBoard() -> UIView {
        
        
        switch boardItem {
        case _ as HeisenbergLinearStructure<Value>:
            let boardy = (self.boardItem as! HeisenbergLinearStructure<Value>)
            
            
            self.itemSize = boardy.itemSize
            
            boardView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: (boardy.generatePath(itemSize: itemSize).count * itemSize) + ((boardy.generatePath(itemSize: itemSize).count-1) * itemSize) ,
                                             height: itemSize))
            
            boardView.backgroundColor = self.boardColor
            boardView.layer.cornerRadius = 2
            
            
            for (_,item) in boardy.generatePath(itemSize: itemSize).enumerated(){
                
                let view = item.0.generateUI(with: CGFloat(itemSize))
                view.frame = CGRect(x: item.locationX, y: 0, width: itemSize, height: itemSize)
                view.backgroundColor = item.0.backgroundColor ?? .white
                
                boardView.addSubview(view)
                
                guard item.0.bondType != .notBonded else{
                    continue
                }
                    
                let bondView = LineView(frame: CGRect(x: item.locationX+itemSize, y: 0, width: itemSize, height: itemSize),
                                        startPoint: CGPoint(x: 0, y: itemSize / 2),
                                        endPoint: CGPoint(x: itemSize, y: itemSize / 2),
                                        itemSize: itemSize,
                                        bond: item.0.bondType.convert(),
                                        color: UIColor.black)

                boardView.addSubview(bondView)
            }
        case _ as HeisenbergDirectionalStructure<Value>:
                    boardView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                   boardView.layer.cornerRadius = 6
                   boardView.backgroundColor = self.boardColor
                   

                   let boardy = self.boardItem as! HeisenbergDirectionalStructure<Value>
                   self.itemSize = boardy.itemSize

                   boardy.calculateEdges()

                   for (_,item) in boardy.getCoordinates().enumerated() {
                       
                       let framey = CGRect(x: item.value.0 + abs(boardy.lowestX), y: item.value.1 + abs(boardy.lowestY)  , width: itemSize, height: itemSize)
                       let view = UIView(frame: CGRect(x: item.value.0  + abs(boardy.lowestX),
                                                       y: item.value.1 + abs(boardy.lowestY),
                                                       width: itemSize,
                                                       height: itemSize))
                       view.backgroundColor = UIColor.purple
                       view.layer.cornerRadius = 4
                       
                       let atomView = item.key.toView(with: framey, color: item.key.backgroundColor ?? UIColor.gray, itemSize: self.itemSize)
                       boardView.addSubview(atomView)

                   }
                   
                   for item in boardy.getEdges() {
                       
                       var lineView: DirectionalLineView!
                       
                       if item.1 == .next {

                           lineView = DirectionalLineView(frame: CGRect(x: item.2.startPoint.x + itemSize,
                                                                        y: item.2.startPoint.y,
                                                                        width: itemSize,
                                                                        height: itemSize),
                                               start: CGPoint(x: 0, y: itemSize / 2),
                                               end: CGPoint(x: itemSize, y: itemSize / 2),
                                               lineColor: item.4,
                                               lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                               structure: item.1,
                                               sizeOfItem: boardy.itemSize)
                           
                           
                           boardView.addSubview(lineView)
                       }else if item.1 == .downward {
                           
                           lineView = DirectionalLineView(frame: CGRect(x: item.2.startPoint.x,
                                                                        y: item.2.startPoint.y + itemSize,
                                                                        width: itemSize,
                                                                        height: itemSize),
                                               start: CGPoint(x: itemSize / 2, y: 0),
                                               end: CGPoint(x: itemSize / 2, y: itemSize),
                                               lineColor: item.4,
                                               lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                               structure: item.1,
                                               sizeOfItem: boardy.itemSize)
            
                       
                           
                           boardView.addSubview(lineView)
                       }else if item.1 == .upward {
                           
                           lineView = DirectionalLineView(frame: CGRect(x: item.2.startPoint.x,
                                                                        y: item.2.startPoint.y - itemSize,
                                                                        width: itemSize,
                                                                        height: itemSize),
                                                          start: CGPoint(x: itemSize / 2, y: 0),
                                                          end: CGPoint(x: itemSize / 2, y: itemSize),
                                                          lineColor: item.4,
                                                          lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                                          structure: item.1,
                                                          sizeOfItem: boardy.itemSize)

                           boardView.addSubview(lineView)
                       }else if item.1 == .angular{
                           
                           lineView = DirectionalLineView(frame: CGRect(x: item.2.endPoint.x,
                                                                        y: item.2.endPoint.y,
                                                                        width: abs(item.2.endPoint.x-item.2.startPoint.x),
                                                                        height:     abs(item.2.endPoint.y-item.2.startPoint.y)),
                                                                        start: CGPoint(x: item.2.startPoint.x, y: item.2.startPoint.y + itemSize / 2),
                                                                        end: CGPoint(x: item.2.endPoint.x + itemSize / 2 + 1, y: item.2.endPoint.y),
                                                                        lineColor: item.4,
                                                                        lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                                                        structure: item.1,
                                                                        sizeOfItem: boardy.itemSize)
                           
                           boardView.addSubview(lineView)
                       }else if item.1 == .crossUpForward{
                           
                           lineView = DirectionalLineView(frame: CGRect(x: item.2.endPoint.x - 2*itemSize + itemSize/2,
                                                                        y: item.2.endPoint.y + itemSize / 2,
                                                                        width: abs(item.2.endPoint.x-item.2.startPoint.x),
                                                                        height: abs(item.2.endPoint.y-item.2.startPoint.y)),
                                                                        start: CGPoint(x: itemSize / 2, y: 2 * itemSize),
                                                                        end: CGPoint(x: 2 * itemSize, y: itemSize / 2),
                                                                        lineColor: item.4,
                                                                        lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                                                        structure: item.1,
                                                                        sizeOfItem: boardy.itemSize)
                           
                           boardView.addSubview(lineView)
                       }else if item.1 == .crossDownForward{
                           
                           var lineFrame: CGRect
                           var lineStart: CGPoint
                           var lineEnd: CGPoint
                           
                           lineFrame = CGRect(x: item.2.startPoint.x + itemSize,
                                              y: item.2.startPoint.y,
                                              width: abs(item.2.endPoint.x-item.2.startPoint.x),
                                              height: abs(item.2.endPoint.y-item.2.startPoint.y))
                           lineStart = CGPoint(x: 0, y: itemSize/2)
                           lineEnd = CGPoint(x: lineFrame.width - CGFloat(itemSize / 2), y: lineFrame.height)
                           
                           
                           lineView = DirectionalLineView(frame: lineFrame,
                                                          start: lineStart,
                                                          end: lineEnd,
                                                          lineColor: item.4,
                                                          lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                                          structure: item.1,
                                                          sizeOfItem: boardy.itemSize)
                           boardView.addSubview(lineView)
                           
                       }else if item.1 == .crossUpBackward{
                           
                           var lineFrame: CGRect
                           var lineStart: CGPoint
                           var lineEnd: CGPoint
                           
                           lineFrame = CGRect(x: item.2.startPoint.x - 2*itemSize,
                                              y: item.2.startPoint.y - itemSize,
                                              width: abs(item.2.endPoint.x-item.2.startPoint.x),
                                              height: abs(item.2.endPoint.y-item.2.startPoint.y))
                           lineStart = CGPoint(x: itemSize / 2, y: 0)
                           lineEnd = CGPoint(x: 2 * itemSize, y: itemSize + itemSize / 2)

                           lineView = DirectionalLineView(frame: lineFrame,
                                                                        start: lineStart,
                                                                        end: lineEnd,
                                                                        lineColor: item.4,
                                                                        lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                                                        structure: item.1,
                                                                        sizeOfItem: boardy.itemSize)

                           boardView.addSubview(lineView)
                           
                           
                       }else if item.1 == .crossDownBackward{
                           
                           var lineFrame: CGRect
                           var lineStart: CGPoint
                           var lineEnd: CGPoint
                           
                           lineFrame = CGRect(x: item.2.startPoint.x - 2 * itemSize,
                                              y: item.2.startPoint.y + itemSize - itemSize / 2,
                                              width: abs(item.2.endPoint.x-item.2.startPoint.x),
                                              height: abs(item.2.endPoint.y-item.2.startPoint.y))
                           lineStart = CGPoint(x: 2 * itemSize, y: 0)
                           lineEnd = CGPoint(x: itemSize / 2, y: 2 * itemSize - itemSize / 2)
                           
                           lineView = DirectionalLineView(frame: lineFrame,
                                                                        start: lineStart,
                                                                        end: lineEnd,
                                                                        lineColor: item.4,
                                                                        lineBond: LineViewBondType(rawValue: item.3.rawValue)!,
                                                                        structure: item.1,
                                                                        sizeOfItem: boardy.itemSize)
                           
                           boardView.addSubview(lineView)
                           
                       }
                   
                       lineView.backgroundColor = .clear
                       boardView.frame.size = boardy.getSize()
            }
            
        default:
                fatalError("There's a variable that not implemented for drawBoard(itemSize:) method. Please add completipties.")
        }

        return boardView
    }

}

// MARK: - Extension for Custom String Convertible
extension HeisenbergBoard: CustomStringConvertible{
    
    public var description: String{

        if self.boardItem is HeisenbergLinearStructure<Value>{
            return "linear"
        }else if self.boardItem is HeisenbergDirectionalStructure<Value>{
            return "directional"
        }else{
            return "not_supported"
        }
    }

}






