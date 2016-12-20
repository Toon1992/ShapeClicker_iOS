//
//  Game.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import Foundation

class Game{
    private let MAX_SHAPES = 6
    private var viewShapes : [ColorShape]
    private var findShape : ColorShape
    
    public func generateViewingShapes(){
        for _ in 0...MAX_SHAPES{
            viewShapes.append(generateShape())
        }
    }
    
    public func generateShape() -> ColorShape{
        let tempColor = Color(rawValue: arc4random_uniform(Color.purple.rawValue + 1))
        let tempShape = Shape(rawValue: arc4random_uniform(Shape.rectangle.rawValue + 1))
        
        return ColorShape(color: tempColor!, shape: tempShape!)
    }
    
    public func generateNewFindShape() -> ColorShape{
        findShape = generateShape()
        
        return findShape
    }
    
    init(){
        viewShapes = [ColorShape]()
        findShape = ColorShape()
        
        findShape = generateShape()
        generateViewingShapes()
    }
    
    
    public func getFindShape() -> ColorShape{
        return findShape
    }
    
    public func getViewShapes()->[ColorShape]{
        return viewShapes
    }
}
