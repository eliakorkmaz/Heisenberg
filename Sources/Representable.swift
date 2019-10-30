//
//  Representable.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import Foundation

// MARK: - Definition of Representer Protocol
public protocol Representable{
    @discardableResult func stringRepresent(completion: @escaping (String) -> ()) -> String
}

