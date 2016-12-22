//
//  TutorialViewController.swift
//  ShapeClicker
//
//  Created by Toon De True on 22/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//
import UIKit

class TutorialViewController : UIViewController {
    //Properties
    @IBOutlet weak var pcPageControl: UIPageControl!
    @IBOutlet weak var cvContainer: UIView!
    
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
                tutorialPageViewController.tutorialDelegate = self
        }
    }
    
}

    extension TutorialViewController: TutorialPageViewControllerDelegate {
        
        func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                        didUpdatePageCount count: Int) {
            pcPageControl.numberOfPages = count
        }
        
        func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                        didUpdatePageIndex index: Int) {
            pcPageControl.currentPage = index
        }
        
    }


