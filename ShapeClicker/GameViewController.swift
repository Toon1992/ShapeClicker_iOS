//
//  GameController.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

internal class GameViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var lblFindElement: UILabel!
    
    @IBOutlet weak var stvUp: UIStackView!
    @IBOutlet weak var stvDown: UIStackView!
    
    private var game = Game()
    private var viewShapes = [ColorShape]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewShapes = game.getViewShapes()
        setLabel()
        fillStacks()
    }
    
    private func setLabel(){
        let colorShape = game.getFindShape()
        setLabelText(colorShape: colorShape)
        setLabelColor(colorShape: colorShape)
    }
    
    private func setLabelText(colorShape: ColorShape){
        switch colorShape.shape {
        case Shape.cirkel:
            lblFindElement.text = "Cirkel"
            break
        case Shape.rectangle:
            lblFindElement.text = "Rectangle"
            break
        case Shape.triangle:
            lblFindElement.text = "Triangle"
            break
        }
    }
    
    private func setLabelColor(colorShape: ColorShape){
        switch colorShape.color {
        case Color.blue:
            lblFindElement.textColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
            break
        case Color.red:
            lblFindElement.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            break
        case Color.green:
            lblFindElement.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            break
        case Color.yellow:
            lblFindElement.textColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            break
        case Color.purple:
            lblFindElement.textColor = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
            break
        }
    }
    
    private func fillStacks(){
        var flag = true
        var index = 0
        
        for shape in viewShapes{
            let image : UIImage = UIImage(named: shape.name)!
            let imagev = UIImageView(image: image)
            imagev.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            imagev.tag = index
            
            let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.tap))
            singleTap.numberOfTapsRequired = 1
            
            imagev.isUserInteractionEnabled = true
            imagev.addGestureRecognizer(singleTap)
            
            if index >= 3{
                flag = false
            }
            
            if flag {
                stvUp.addArrangedSubview(imagev)
            } else {
                stvDown.addArrangedSubview(imagev)
            }
            
            index += 1
        }
    }
    
    func tap(_ sender: UITapGestureRecognizer){
       let tag = sender.view!.tag
        
       let _ = game.checkIfCorrectShape(colorShape: viewShapes[tag])
       reset()
    }
    
    private func removeViewsFromStack(stack: UIStackView ){
        for view in stack.subviews{
            view.removeFromSuperview()
        }
        
    }
    
    private func reset(){
        removeViewsFromStack(stack: stvUp)
        removeViewsFromStack(stack: stvDown)
        viewShapes = game.getViewShapes()
        setLabel()
        fillStacks()
    }
    
    
}
