//
//  PageControlManager.swift
//  PageCotrollerWithBckwardForwardButton
//
//  Created by Ashish on 7/20/18.
//  Copyright © 2018 Affle Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

class WalkthroughManager: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // MARK: - Private Constants and Variables
    private var pageCtrl:UIPageControl?
    
    // PageView identifier that we assigned it as Storyboard ID
    private let walkThroughIdentifier:String = "PageView"
    private let storyboardIdentifier:String = "Main"
    var pageController: PageViewController? = nil
    
    // MARK: - Custom Methods
    
    /**
     This method shows Walkthrough on view controller
     - Parameter viewController: UIViewController
     - Parameter pageControl: UIPageControl "pass nil if not want to show"
     - Parameter viewHeight: CGFloat "walkthrough will cover this height on view controller"
     */
    func showWalkthrough(onViewController viewController:UIViewController, withPageControl pageControl:UIPageControl?, withViewHeight viewHeight:CGFloat) {
        
        pageCtrl = pageControl
        
        pageController = PageViewController.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController?.view.isUserInteractionEnabled = false
        
        var frame:CGRect = viewController.view.bounds
        frame.size.height = viewHeight // WalkThrough will cover this height on ViewController"
        pageController?.view.frame = frame
        
        let PageView:PageView = self.viewControllerAtIndex(index: 0)
        let viewControllers:[PageView] = [PageView]
        
        pageController?.dataSource = self
        pageController?.delegate = self
        
        pageController?.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        viewController.addChildViewController(pageController!)
        viewController.view.addSubview((pageController?.view)!)
        
        if pageControl != nil {
            pageControl?.numberOfPages = PageView.pageArray.count
            viewController.view.bringSubview(toFront: pageControl!)
        }
    }
    /**
     This method returns instance of PageView
     - Parameter index: Int
     - Returns    childVC: PageView
     */
    private func viewControllerAtIndex(index:Int) -> PageView {
        // ByDefault Storyboard has name "Main" if we renamed it then we will pass that name.
        let strybrd:UIStoryboard = UIStoryboard(name: storyboardIdentifier, bundle: Bundle.main)
        let childVC = strybrd.instantiateViewController(withIdentifier: walkThroughIdentifier) as! PageView
        childVC.pageIndex = index
        
        return childVC
    }
    
    // MARK: - UIPageViewControllerDataSource Methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let PageView = viewController as? PageView
        
        var index = PageView?.pageIndex
        if index == 0 {
            return nil
        }
        index = index! - 1
        return self.viewControllerAtIndex(index: index!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let PageView = viewController as? PageView
        
        var index = PageView?.pageIndex
        let pageCount = PageView?.pageArray.count
        
        index = index! + 1
        
        if index == pageCount {
            return nil
        }
        return self.viewControllerAtIndex(index: index!)
    }
    
    // MARK: - UIPageViewControllerDelegate Method
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed {
            return
        }
        let childVC = pageViewController.viewControllers?.last as? PageView
        pageCtrl?.currentPage = (childVC?.pageIndex)!
    }
    
    func forward() {
        if (pageCtrl?.currentPage)! < 3 {
            pageController?.setViewControllers([viewControllerAtIndex(index: (pageCtrl?.currentPage)! + 1)], direction: .forward, animated: true, completion: nil)
            pageCtrl?.currentPage = (pageCtrl?.currentPage)! + 1
        }
    }
    
    func backward() {
        if (pageCtrl?.currentPage)! > 0 {
            pageController?.setViewControllers([viewControllerAtIndex(index: (pageCtrl?.currentPage)! - 1)], direction: .reverse, animated: true, completion: nil)
            pageCtrl?.currentPage = (pageCtrl?.currentPage)! - 1
        }
    }
}

class PageViewController: UIPageViewController {
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
