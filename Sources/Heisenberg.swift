//
//  Heisenberg.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import UIKit


// MARK: - Description for BoardItem
public protocol BoardItem:class{}


// MARK: - Description of Heisenberg Linear Structure
public class HeisenbergLinearStructure<Value>: BoardItem{
    public typealias BoardValue = Value
    public typealias HeisenbergCompletion = (HeisenbergLinearStructure<Value>) -> ()
    
    var head: Atom<Value>?
    var tail: Atom<Value>?
    var itemSize: Int
    
    public init(with atom: Atom<Value>, itemSize: Int){
        self.head = atom
        self.tail = self.head
        self.itemSize = itemSize
    }
    
    @discardableResult public func linkTo(with atom: Atom<Value>?, with bond: Atom<Value>.BondType, completion: @escaping HeisenbergCompletion = { _ in }) -> Self {
        self.tail?.nextAtom = atom
        self.tail?.bondType = bond
        self.tail = self.tail?.nextAtom
        
        completion(self)
        
        return self
    }
    
    public func generatePath(itemSize: Int) -> [(Atom<Value>, locationX: Int)]{
        
        var pathArray: [(Atom<Value>, locationX: Int)] = []
        var initialLocation: Int = 0
        var iterator: Int = 1
        
        var tempNode = self.head
        
        while(tempNode != nil){
            
            initialLocation = (iterator - 1) * itemSize + (iterator - 1) * itemSize
            pathArray.append((tempNode!, locationX: initialLocation))
            tempNode = tempNode?.nextAtom
            iterator += 1
        }
        
        return pathArray
    }
}



// MARK: HeisenbergLinearStructure String Description
extension HeisenbergLinearStructure: CustomStringConvertible{
    public var description: String{
        var atomicDescription = ""
        var molecularDescription = ""

        var tempNode = self.head
        
        while(tempNode != nil){
            atomicDescription += "\(tempNode!.symbol) \(tempNode!.bondType.rawValue) "
            molecularDescription += "O\(tempNode!.bondType.rawValue)"

            tempNode = tempNode?.nextAtom
        }
        
        return atomicDescription
    }
}

extension HeisenbergLinearStructure: Representable{
    @discardableResult public func stringRepresent(completion: @escaping (String) -> () = { _ in} ) -> String{
        
        defer{
            completion(String(describing: self))
        }
        
        return String(describing: self)
    }
    
}



// MARK: - HeisenberDirectionalStructure Definition
public class HeisenbergDirectionalStructure<Value>: BoardItem where Value: Equatable{
    public typealias BoardValue = Value
    typealias Edge = ((from: DirectionalAtom<Value>,to: DirectionalAtom<Value>), StructuralWay,( startPoint: (x: Int, y: Int), endPoint: (x: Int, y: Int)), BondType,UIColor)
    public typealias HeisenbergCompletion = (HeisenbergDirectionalStructure) -> ()
    
    var headAtom: DirectionalAtom<Value>?
    var itemSize: Int
    
    public init(with atom: DirectionalAtom<Value>, itemSize: Int){
        self.headAtom = atom
        
        atomVertices.append(atom)
        coordinates[atom] = (0,0)
        self.itemSize = itemSize
    }
     
    @discardableResult public func linkWith(from: DirectionalAtom<Value>, to: DirectionalAtom<Value>,  way: StructuralWay, bond: BondType, bondColor: UIColor? = nil, completion: HeisenbergCompletion = { _ in } ) -> Self {
                
        atomEdges.append((from: from,
                          to: to,
                          bond: bond,
                          bondColor: bondColor ?? .black,
                          structureWay: way))
        
        if !atomVertices.contains(to){
            atomVertices.append(to)
        }
        
        completion(self)
        
        return self
    }
    

    private var atomVertices = [DirectionalAtom<Value>]()
    private var atomEdges = [(from: DirectionalAtom<Value>,to: DirectionalAtom<Value>, bond: BondType, bondColor: UIColor, structureWay: StructuralWay)]()
    
    private var coordinates = [DirectionalAtom<Value>: (Int,Int)]()
    private var edges = [Edge]()
    
    func getCoordinates() -> [DirectionalAtom<Value>: (Int,Int)] {
        return self.coordinates
    }
    
    public func getSize() -> CGSize {
        
        var lowestY: Int = 0
        var highestY: Int = 0
        
        for item in self.coordinates {
            
            if item.value.1 < lowestY {
                lowestY = item.value.1
            }
            
            if item.value.1 > highestY {
                highestY = item.value.1
            }
            
        }
        
        let frameHeight = abs(lowestY) + highestY + itemSize
        let frameWidth =  self.coordinates.map { (val) -> Int in
            val.value.0
        }.sorted().max()! + itemSize + abs(lowestX)
        
        
        return CGSize(width: frameWidth, height: frameHeight)
    }
    
    var lowestY: Int{
        var _lowestY: Int = 0
        
        for item in self.coordinates {
            
            if item.value.1 < _lowestY {
                _lowestY = item.value.1
            }

        }
        
        return _lowestY
    }
    
    var lowestX: Int{
        var _lowestX: Int = 0
        
        for item in self.coordinates {
            
            if item.value.0 < _lowestX {
                _lowestX = item.value.0
            }

        }
        
        return _lowestX
    }
    
    func getEdges() -> [Edge]{
        return edges
    }
    
    func calculateEdges(){
        
        for item in atomEdges{

            switch item.structureWay {
                            
            case .downward:
                self.coordinates[item.to] = (coordinates[item.from]!.0, coordinates[item.from]!.1 + self.itemSize * 2)
            case .next:
                self.coordinates[item.to] = (coordinates[item.from]!.0 + self.itemSize * 2, coordinates[item.from]!.1)
            case .upward:
                self.coordinates[item.to] = (coordinates[item.from]!.0, coordinates[item.from]!.1 - self.itemSize * 2)
            case .angular:
                self.coordinates[item.to] = (coordinates[item.to]!.0, coordinates[item.to]!.0 )
            case .crossUpForward:
                self.coordinates[item.to] = (coordinates[item.from]!.0 + self.itemSize * 2, coordinates[item.from]!.1 - self.itemSize * 2 )
            case .crossDownForward:
                self.coordinates[item.to] = (coordinates[item.from]!.0 + self.itemSize * 2, coordinates[item.from]!.1 + self.itemSize * 2 )
            case .crossDownBackward:
                self.coordinates[item.to] = (coordinates[item.from]!.0 - self.itemSize * 2, coordinates[item.from]!.1 + self.itemSize * 2 )
            case .crossUpBackward:
                self.coordinates[item.to] = (coordinates[item.from]!.0 - self.itemSize * 2, coordinates[item.from]!.1 - self.itemSize * 2 )
            }
                
            edges.append(((from: item.from, to: item.to),
                          item.structureWay,
                          (startPoint: (x: coordinates[item.from]!.0, y: coordinates[item.from]!.1),endPoint: (x: coordinates[item.to]!.0, y: coordinates[item.to]!.1)),
                          item.bond,
                          item.bondColor))
        }
        
        var newCoordinates: [DirectionalAtom<Value>: (Int,Int)] = [DirectionalAtom<Value>: (Int,Int)]()
        
        for item in coordinates{
            newCoordinates[item.key] = (item.value.0 + abs(lowestX) ,item.value.1 + abs(lowestY))
        }

        coordinates = newCoordinates
        edges = []
        
        
        for item in atomEdges{
            
            switch item.structureWay {
                case .downward:
                    self.coordinates[item.to] = (coordinates[item.from]!.0, coordinates[item.from]!.1 + self.itemSize * 2)
                case .next:
                    self.coordinates[item.to] = (coordinates[item.from]!.0 + self.itemSize * 2, coordinates[item.from]!.1)
                case .upward:
                    self.coordinates[item.to] = (coordinates[item.from]!.0, coordinates[item.from]!.1 - self.itemSize * 2)
                case .angular:
                    self.coordinates[item.to] = (coordinates[item.to]!.0, coordinates[item.to]!.0 )
                case .crossUpForward:
                    self.coordinates[item.to] = (coordinates[item.from]!.0 + self.itemSize * 2, coordinates[item.from]!.1 - self.itemSize * 2 )
                case .crossDownForward:
                    self.coordinates[item.to] = (coordinates[item.from]!.0 + self.itemSize * 2, coordinates[item.from]!.1 + self.itemSize * 2 )
                case .crossDownBackward:
                    self.coordinates[item.to] = (coordinates[item.from]!.0 - self.itemSize * 2, coordinates[item.from]!.1 + self.itemSize * 2 )
                case .crossUpBackward:
                    self.coordinates[item.to] = (coordinates[item.from]!.0 - self.itemSize * 2, coordinates[item.from]!.1 - self.itemSize * 2 )
                }
                
                edges.append(((from: item.from, to: item.to),
                              item.structureWay,
                              (startPoint: (x: coordinates[item.from]!.0, y: coordinates[item.from]!.1),endPoint: (x: coordinates[item.to]!.0, y: coordinates[item.to]!.1)),
                              item.bond,
                              item.bondColor))
        }
    }
    
    public enum BondType: Int {
        case singleBond = 1
        case doubleBond = 2
        case tripleBond = 3
    }
    
}

// MARK: - Heisenberg Directional Structure
extension HeisenbergDirectionalStructure: CustomStringConvertible {
    
    public var description: String{

        return ""
    }
    
}

