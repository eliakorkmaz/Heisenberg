//
//  Atomable.swift
//  Heisenberg
//
//  Created by Emrah Korkmaz on 10/31/19.
//

import Foundation

// MARK: Definition of Atom & Atomable
public protocol Atomable{
    associatedtype AtomValue

    var atomicNumber: Int { get }
    var symbol: AtomValue { get }
    var electronConfiguration: AtomValue { get }
    var name: AtomValue { get }
    var atomicWeight: Float { get }
}
