//
//  HomeVC.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 20/08/18.
//

import UIKit
import InteractiveSideMenu

class HomeVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, SideMenuItemContent {
    
    @IBOutlet weak var btnChargeGasoline: UIButton!
    @IBOutlet weak var btnPromotion: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var tblViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMenu: UIView!
    
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblSeasons: UILabel!
    @IBOutlet weak var lblPromotions: UILabel!
    @IBOutlet weak var lblMyAccount: UILabel!
    @IBOutlet weak var lblNews: UILabel!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tblViewMenu: UITableView!
    let menuArr=[start, seasons, promotion, account, news, chargeGasoline]
    
    @IBOutlet weak var btnSeasons: UIButton!
    @IBOutlet weak var btnPromotions: UIButton!
    @IBOutlet weak var btnMyAccount: UIButton!
    @IBOutlet weak var btnNews: UIButton!
    
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myCell: UITableViewCell;
        if indexPath.row == 0
        {
            tableView.register(UINib(nibName: "menuFirstTblViewCell", bundle: nil), forCellReuseIdentifier: "menuFirstTblViewCell")
            myCell=tableView.dequeueReusableCell(withIdentifier: "menuFirstTblViewCell", for: indexPath) as! menuFirstTblViewCell
        }
        else if indexPath.row == 7
        {
            tableView.register(UINib(nibName: "menuLastTblViewCell", bundle: nil), forCellReuseIdentifier: "menuLastTblViewCell")
            myCell=tableView.dequeueReusableCell(withIdentifier: "menuLastTblViewCell", for: indexPath) as! menuLastTblViewCell
        }
        else
        {
            myCell=UITableViewCell()
            myCell.textLabel?.text=menuArr[indexPath.row-1]
            myCell.textLabel?.textColor=UIColor.white
        }
        myCell.backgroundColor=UIColor.gray.withAlphaComponent(0.5)
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row != 0 && indexPath.row != 7)
        {
            return 55
        }
        return 165
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    //MARK:- Button IBAction
    @IBAction func btnMenuOpen(_ sender: Any) {
        showSideMenu()
//        self.tblViewConstraint.constant = 0
//        UIView.animate(withDuration: 1) {
//            self.viewMenu.layoutIfNeeded()
//            self.viewMenu.isHidden = false
//        }
    }
    
    @IBAction func btnMenuClose(_ sender: Any) {
        viewMenu.isHidden=true
        self.tblViewConstraint.constant = -255
    }
    
    //MARK:- Custom Method
    func design() {
        lblStart.text = start
        lblSeasons.text = seasons
        lblPromotions.text = promotion
        lblMyAccount.text = account
        lblNews.text = news
        
        btnChargeGasoline.homePageButton(title: chargeGasoline, rect: btnChargeGasoline.frame)
        btnPromotion.homePageButton(title: promotion, rect: btnPromotion.frame)
        
        btnSeasons.imageView?.contentMode = UIViewContentMode.scaleAspectFill;
        btnSeasons.setImage(UIImage(named: "home2"), for: .normal)
    }
}
