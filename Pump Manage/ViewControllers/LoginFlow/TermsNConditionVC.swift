//
//  T&C.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 17/08/18.
//

import UIKit

class TermsNConditionVC: BaseViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var imgbackground: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var currentNum=1
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        designing()
    }
 
    // MARK:- Button IBAction
    @IBAction func btnNext(_ sender: Any) {
        switch(currentNum)
        {
        case 0:
            imgbackground.image=UIImage(named: "background1")
            currentNum += 1
            break
        case 1:
            imgbackground.image=UIImage(named: "background2")
            currentNum += 1
            break
        case 2:
            imgbackground.image=UIImage(named: "background1")
            currentNum += 1
            break
        default:
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController!.pushViewController(vc, animated: true)
        }
        pageController.currentPage = currentNum - 1
    }
    @IBAction func btnSkip(_ sender: Any) {
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    // MARK:- Custom Method
    func designing() {
       // btnNext.loginButton(title: nextStr, rect: btnNext.frame)
       // btnSkip.skipButton(title: skip, rect: btnSkip.frame)
    }
    
    // MARK:- Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
