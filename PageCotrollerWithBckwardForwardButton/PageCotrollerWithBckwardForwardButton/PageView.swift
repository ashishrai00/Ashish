//
//  PageViewController.swift
//  PageCotrollerWithBckwardForwardButton
//
//  Created by Ashish on 7/20/18.
//  Copyright © 2018 Affle Pvt Ltd. All rights reserved.
//

import UIKit

class PageView: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imgViewWalkThrough: UIImageView!
    
    // MARK: - Global constants and variables
    let pageArray:[UIImage] = [#imageLiteral(resourceName: "walkThrough_1"), #imageLiteral(resourceName: "walkThrough_2"), #imageLiteral(resourceName: "walkThrough_3"), #imageLiteral(resourceName: "walkThrough_4")]
    var pageIndex:Int?
    
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
        if self.pageIndex != nil {
            let image:UIImage? = self.pageArray[self.pageIndex!]
            self.imgViewWalkThrough.image = image
        }
    }
    
}
