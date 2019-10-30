//
//  ViewController.swift
//  Heisenberg
//
//  Created by eliakorkmaz on 10/31/2019.
//  Copyright (c) 2019 eliakorkmaz. All rights reserved.
//

import UIKit
import Heisenberg

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func simpleCrossTest(){
        let firstAtom = DirectionalAtom(with: "A", color: .blue, _textColor: .white)
        let secondAtom = DirectionalAtom(with: "B", color: .white)
        let thirdAtom = DirectionalAtom(with: "C", color: .white)
        let fourthAtom = DirectionalAtom(with: "D", color: .white)
        let fifthAtom = DirectionalAtom(with: "E", color: .white)
        
        let heisenberg = HeisenbergDirectionalStructure(with: firstAtom, itemSize: 40)
        heisenberg.linkWith(from: firstAtom, to: secondAtom, way: .crossUpBackward, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: firstAtom, to: thirdAtom, way: .crossDownBackward, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: firstAtom, to: fourthAtom, way: .crossUpForward, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: firstAtom, to: fifthAtom, way: .crossDownForward, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }
        
        
        let heisenbergBoard = HeisenbergBoard<String>.init(with: heisenberg, with: .lightGray)
        let boardView = heisenbergBoard.drawBoard()
        
        view.addSubview(boardView)
        boardView.center = view.center
        
    }
    
    func backwardTest(){
        let firstAtom = DirectionalAtom(with: "A", color: .blue)
        let secondAtom = DirectionalAtom(with: "B", color: .green)
        let thirdAtom = DirectionalAtom(with: "C", color: .orange)
        let fourthAtom = DirectionalAtom(with: "T", color: .brown)
        
        let heisenberg = HeisenbergDirectionalStructure(with: firstAtom, itemSize: 50)
        heisenberg.linkWith(from: firstAtom, to: secondAtom, way: .crossUpBackward, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: firstAtom, to: thirdAtom, way: .crossDownBackward, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: firstAtom, to: fourthAtom, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }
        
        
        let heisenbergBoard = HeisenbergBoard<String>(with: heisenberg, with: .lightGray)
        let boardView = heisenbergBoard.drawBoard()
        view.addSubview(boardView)
        boardView.center = view.center
        
    }
    
    
    func testNH3(){
        let cAtom = DirectionalAtom(with: "C", color: .magenta)
        let nAtom = DirectionalAtom(with: "N", color: .blue)
        let h1Atom = DirectionalAtom(with: "H", color: .brown)
        let h2Atom = DirectionalAtom(with: "H", color: .green)
        let h3Atom = DirectionalAtom(with: "H", color: .cyan)
        let loveAtom = DirectionalAtom(with: "❤️", color: .white)
        
        
        let directional = HeisenbergDirectionalStructure(with: cAtom, itemSize: 50)
        directional.linkWith(from: cAtom, to: nAtom, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: nAtom, to: h1Atom, way: .crossUpForward, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: nAtom, to: h3Atom, way: .crossDownForward, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: nAtom, to: h2Atom, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: cAtom, to: loveAtom, way: .downward, bond: .TripleBond, bondColor: .darkGray) { (structure) in
            //
        }
        
        let board = HeisenbergBoard<String>(with: directional, with: .lightGray)
        let boardView = board.drawBoard()
        
        
        boardView.frame.size = CGSize(width: directional.getSize().width, height: directional.getSize().height)
        view.addSubview(boardView)
        boardView.center = view.center
        
    
    
    }
    
    
    func testDirectional(){
        let hAtom = DirectionalAtom(with: "H", color: .orange)
        let oAtom = DirectionalAtom(with: "O", color: .blue)
        let hAtom2 = DirectionalAtom(with: "H", color: .brown)
        
        
        let directional = HeisenbergDirectionalStructure<String>(with: hAtom, itemSize: 50)
        directional.linkWith(from: hAtom, to: oAtom, way: .next, bond: .DoubleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: oAtom, to: hAtom2, way: .next, bond: .TripleBond, bondColor: .black) { (structure) in
            
        }
        
        let board = HeisenbergBoard<String>(with: directional, with: .lightGray)
        let boardView = board.drawBoard()
        
        
        boardView.frame.size = CGSize(width: directional.getSize().width, height: directional.getSize().height)
        view.addSubview(boardView)
        boardView.center = view.center
        
    }
    
    
    func linear(){
        let h1 = Atom(with: "H", color: .blue)
        let h2 = Atom(with: "H", color: .orange)
        let o = Atom(with: "O", color: .cyan)
        let c = Atom(with: "C", color: .green)
        
        let linear = HeisenbergLinearStructure<String>(with: h1, itemSize: 50)
        linear.linkTo(with: o, with: .DoubleBond) { (structure) in
            
        }.linkTo(with: h2, with: Atom<String>.BondType.TripleBond) { (structure) in
            
        }.linkTo(with: c, with: Atom<String>.BondType.SingleBond) { (structure) in
            
        }
        
        let board = HeisenbergBoard<String>(with: linear, with: .lightGray)
        let boardView = board.drawBoard()
        
        view.addSubview(boardView)
        boardView.center = view.center
    }
    
    func testLinear(){
        
        let h1 = Atom(with: "H", color: .blue)
        let h2 = Atom(with: "H", color: .orange)
        let o = Atom(with: "O", color: .cyan)
        
        let linear = HeisenbergLinearStructure<String>(with: h1, itemSize: 40)
        linear.linkTo(with: o, with: .TripleBond) { (structure) in
            
        }.linkTo(with: h2, with: Atom<String>.BondType.SingleBond) { (structure) in
            
        }
        
        let board = HeisenbergBoard<String>(with: linear, with: .white)
        let boardView = board.drawBoard()
        view.addSubview(boardView)
        boardView.center = view.center
        
        
    }
    
    func testCH4(){
        let c1 = DirectionalAtom(with: "H", color: .blue)
        let c2 = DirectionalAtom(with: "H", color: .red)
        let c3 = DirectionalAtom(with: "H", color: .gray)
        let c4 = DirectionalAtom(with: "H", color: .green)
        let h = DirectionalAtom(with: "C", color: .orange)
        
        let heisenberg = HeisenbergDirectionalStructure<String>(with: c1, itemSize: 40)
        heisenberg.linkWith(from: c1, to: h, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: h, to: c2, way: .upward, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: h, to: c3, way: .downward, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }.linkWith(from: h, to: c4, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in
            
        }
        
        
        let board = HeisenbergBoard<String>(with: heisenberg, with: .cyan)
        let boardView = board.drawBoard()
        
        view.addSubview(boardView)
        boardView.center = view.center
        

        
    }
    
    func testLove(){
        let hAtom1 = DirectionalAtom(with: "H", color: UIColor.white)
        let hAtom2 = DirectionalAtom(with: "H", color: UIColor.blue)
        let hAtom3 = DirectionalAtom(with: "H", color: UIColor.red)
        let hAtom4 = DirectionalAtom(with: "H", color: UIColor.brown)
        let hAtom5 = DirectionalAtom(with: "H", color: UIColor.yellow)
        let hAtom6 = DirectionalAtom(with: "H", color: UIColor.green)
        let hAtom7 = DirectionalAtom(with: "H", color: UIColor.purple)
        let hAtom8 = DirectionalAtom(with: "H", color: UIColor.cyan)
        let hAtom9 = DirectionalAtom(with: "❤️", color: UIColor.blue)

        let heisenberg = HeisenbergDirectionalStructure(with: hAtom1, itemSize: 40)
        heisenberg.linkWith(from: hAtom1, to: hAtom2, way: .crossUpForward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom2, to: hAtom3, way: .crossDownForward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom3, to: hAtom4, way: .crossUpForward, bond: .TripleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom4, to: hAtom5, way: .crossDownForward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom5, to: hAtom6, way: .crossDownBackward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom6, to: hAtom7, way: .crossDownBackward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom7, to: hAtom8, way: .crossUpBackward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }.linkWith(from: hAtom8, to: hAtom9, way: .crossUpBackward, bond: .DoubleBond, bondColor: UIColor.black) { (board) in

        }

        let board = HeisenbergBoard<String>(with: heisenberg, with: .lightGray)
        let boardView = board.drawBoard()
        view.addSubview(boardView)
        boardView.center = view.center

    }

    func crossTest(){
        let hAtom = DirectionalAtom(with: "H", color: UIColor.white)
        let pAtom = DirectionalAtom(with: "P", color: UIColor.black, _textColor: .white)
        let qAtom = DirectionalAtom(with: "Q", color: UIColor.purple)
        let oAtom = DirectionalAtom(with: "O", color: UIColor.brown, _textColor: .white)

        let heisenberg = HeisenbergDirectionalStructure(with: hAtom, itemSize: 40)
        heisenberg.linkWith(from: hAtom, to: pAtom, way: .crossUpForward, bond: .TripleBond) { (heisenberg) in

        }.linkWith(from: pAtom, to: qAtom, way: .crossDownForward, bond: .TripleBond) { (str) in

        }.linkWith(from: qAtom, to: oAtom, way: .crossDownBackward, bond: .TripleBond) { (heisenberg) in
            //
        }.linkWith(from: oAtom, to: hAtom, way: .crossUpBackward, bond: .TripleBond)


        let board = HeisenbergBoard<String>(with: heisenberg, with: .lightGray)
        let boardView = board.drawBoard()
        view.addSubview(boardView)
        boardView.center = view.center
        
    }
        
   
    func test1(){
        let firstDirectionalAtom = DirectionalAtom(with: "1")
        let secondDirectionalAtom = DirectionalAtom(with: "2")
        let thirdDirectionalAtom = DirectionalAtom(with: "3")
        let fourthDirectionalAtom = DirectionalAtom(with: "4")
        let fifthDirectionalAtom = DirectionalAtom(with: "5")


        let numerical = HeisenbergDirectionalStructure<String>(with: firstDirectionalAtom, itemSize: 40)
        numerical.linkWith(from: firstDirectionalAtom, to: secondDirectionalAtom, way: .next, bond: .SingleBond) { _ in

        }.linkWith(from: secondDirectionalAtom, to: thirdDirectionalAtom, way: .next, bond: .SingleBond) { _ in

        }.linkWith(from: secondDirectionalAtom, to: fourthDirectionalAtom, way: .upward, bond: .SingleBond) { _ in

        }.linkWith(from: secondDirectionalAtom, to: fifthDirectionalAtom, way: .downward, bond: .SingleBond) { _ in

        }

        let viewy = HeisenbergBoard<String>(with: numerical, with: .brown)
        let vies = viewy.drawBoard()
        view.addSubview(vies)
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }

    
}

