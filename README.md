# Heisenberg

[![CI Status](https://img.shields.io/travis/eliakorkmaz/Heisenberg.svg?style=flat)](https://travis-ci.org/eliakorkmaz/Heisenberg)
[![Version](https://img.shields.io/cocoapods/v/Heisenberg.svg?style=flat)](https://cocoapods.org/pods/Heisenberg)
[![License](https://img.shields.io/cocoapods/l/Heisenberg.svg?style=flat)](https://cocoapods.org/pods/Heisenberg)
[![Platform](https://img.shields.io/cocoapods/p/Heisenberg.svg?style=flat)](https://cocoapods.org/pods/Heisenberg)

```Heisenberg``` is an ```iOS``` UI library for creating / using chemical structures with written in ```Swift```. It represent directional structures as using ```HeisenbergDirectionalStructure``` and just linear structures as using ```HeisenbergLinearStructure```. You can change bonds between two elements as ```SingleBond```, ```DoubleBond``` or ```TripleBond```

```HeisenbergDirectionalStructure``` is based on ```Graph```and ```HeisenbergLinearStructure``` is based on ```SinglyLinkedList``` . You can create just x-axis linear structure with ```HeisenbergLinearStructure``` but with ```HeisenbergDirectionalStructure``` you can create / build what a ```Graph``` can do it.

## HeisenbergLinearStructure

```swift
let heisenberg = HeisenbergLinearStructure(with: hidyrogen1, itemSize: 40)
heisenberg.linkTo(with: oxgen, with: .SingleBond) { (structure) in
    // structure callback
}.linkTo(with: hidyrogen2, with: .TripleBond) { (structure) in
       
}.linkTo(with: tAtom, with: .TripleBond) { (structure) in
   
}.linkTo(with: babyAtom, with: .TripleBond) { (structure) in

}
let board = HeisenbergBoard<String>(with: heisenberg, with: .cyan)
let boardView =  board.drawBoard()
view.addSubview(boardView)
```
![Linear Structure](https://i.ibb.co/fGXKsJn/Screen-Shot-2019-10-31-at-12-38-30-AM.png)


## HeisenbergDirectionalStructure

```swift
let directional = HeisenbergDirectionalStructure(with: cAtom, itemSize: 50)
directional.linkWith(from: cAtom, to: nAtom, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in

}.linkWith(from: nAtom, to: h1Atom, way: .crossUpForward, bond: .SingleBond, bondColor: .black) { (structure) in

}.linkWith(from: nAtom, to: h3Atom, way: .crossDownForward, bond: .SingleBond, bondColor: .black) { (structure) in

}.linkWith(from: nAtom, to: h2Atom, way: .next, bond: .SingleBond, bondColor: .black) { (structure) in

}.linkWith(from: cAtom, to: loveAtom, way: .downward, bond: .TripleBond, bondColor: .darkGray) { (structure) in

}

let board = HeisenbergBoard<String>(with: directional, with: .lightGray)
let boardView = board.drawBoard()
view.addSubview(boardView)
```



![CH4](https://i.ibb.co/hK05jDv/Screen-Shot-2019-10-31-at-12-39-10-AM.png)   ![Directional](https://i.ibb.co/MZdZ083/Screen-Shot-2019-10-31-at-12-39-34-AM.png)

![Directional](https://i.ibb.co/kSksJXr/Screen-Shot-2019-10-31-at-12-40-00-AM.png)  ![Directional](https://i.ibb.co/DfbNDN5/Screen-Shot-2019-10-31-at-12-40-15-AM.png)

![Directional](https://i.ibb.co/kDt8dGc/Screen-Shot-2019-10-31-at-12-38-51-AM.png)  ![Directional](https://i.ibb.co/QJgFq6y/Screen-Shot-2019-10-31-at-12-38-41-AM.png)

## Bonding Between Atoms 

You can tie two or more atoms with elements bonds. There's a list for bond way.

```swift
public enum StructuralWay: String{
    case upward = "up"
    case downward = "down"
    case next = "next"
    case angular = "angular"
    case crossDownForward = "cross_down_forward"
    case crossUpForward = "cross_up_forward"
    case crossDownBackward = "cross_back_down"
    case crossUpBackward = "cross_back_up"
}
```


## HeisenbergBoard

```HeisenbergBoard``` is a class for creating board to handle UI structure of chemical structures. You can pass any ```HeisenbergLinearStructure``` or ```HeisenbergDirectionalStructure``` and you must select a ```backgroundColor``` of the board. Then method ```drawBoard()``` returns a ```UIView``` for your structure.

```swift
let board = HeisenbergBoard<String>(with: directional, with: .lightGray)
let boardView = board.drawBoard()
```

## Example

I've added bunch of test functions to generate a ```Heisenberg```. You can check it out.
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Heisenberg is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Heisenberg'
```

## Author

eliakorkmaz, emrahkrkmz1@gmail.com

## License

Heisenberg is available under the MIT license. See the LICENSE file for more info.


