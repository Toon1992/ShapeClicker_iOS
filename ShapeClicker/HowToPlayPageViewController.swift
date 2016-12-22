//
//  HowToPlayPageViewController.swift
//  ShapeClicker
//
//  Created by Toon De True on 22/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

class HowToPlayPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    lazy var VCArr : [UIViewController] = {
        return [self.newPageController(controller: "Page1ViewController"), self.newPageController(controller: "Page2ViewController"), self.newPageController(controller: "Page3ViewController")]
    }()
    
    private func newPageController(controller: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: controller)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        if let firstViewController = VCArr.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl{
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return VCArr.last
        }
        
        guard VCArr.count > previousIndex else {
            return nil
        }
        
        return VCArr[previousIndex]
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let VCArrCount = VCArr.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard VCArrCount != nextIndex else {
            return VCArr.first
        }
        
        guard VCArrCount > nextIndex else {
            return nil
        }
        
        return VCArr[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
       return VCArr.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCArr.index(of: firstViewController) else{
            return 0
        }
        
        return firstViewControllerIndex
    }
 
}
