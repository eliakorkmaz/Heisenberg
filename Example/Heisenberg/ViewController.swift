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
        simpleCrossTest()
    }

    func simpleCrossTest(){
        var ss = Atom(with: "T")
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
        boardView.frame.size = heisenberg.getSize()
        
        view.addSubview(boardView)
        boardView.center = view.center
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

