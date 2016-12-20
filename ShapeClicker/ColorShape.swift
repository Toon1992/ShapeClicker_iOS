//
//  ColorShape.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import Foundation

class ColorShape {
    let color : Color
    let shape : Shape
    
    init(color: Color, shape: Shape){
        self.color = color
        self.shape = shape
    }
    
    init(){
        self.color = Color.blue
        self.shape = Shape.cirkel
    }
}

extension ColorShape{
    
    
    static func ==(lhs: ColorShape, rhs: ColorShape) -> Bool{
        return lhs.color == rhs.color && lhs.shape == rhs.shape
    }
    
}
