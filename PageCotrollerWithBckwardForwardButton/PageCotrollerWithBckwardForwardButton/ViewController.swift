//
//  ViewController.swift
//  PageCotrollerWithBckwardForwardButton
//
//  Created by Ashish on 7/20/18.
//  Copyright © 2018 Affle Pvt Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Private constants and variables
    private let wtManager:WalkthroughManager = WalkthroughManager()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    private func initializeView() {
        self.initializeWalkThrough()
    }
    
    private func initializeWalkThrough() {
        // Walkthrough will cover view's totalHeight - 100
        let walkThroughViewHeight = UIScreen.main.bounds.size.height - 100
        
        // if  you don't want to show pageControl then pass nil instead of self.pageControl
        wtManager.showWalkthrough(onViewController: self, withPageControl: self.pageControl, withViewHeight: walkThroughViewHeight)
    }
    
    @IBAction func actionForwardBackward(_ sender: UIButton) {
        if sender.tag == 11 {
            wtManager.backward()
        } else if sender.tag == 12 {
            wtManager.forward()
        }
    }
}

