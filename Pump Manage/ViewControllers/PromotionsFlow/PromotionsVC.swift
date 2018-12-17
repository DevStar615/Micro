//
//  PromotionsVC.swift
//  Pump Manage
//
//  Created by mac on 22/08/18.
//

import UIKit
import InteractiveSideMenu

class PromotionsVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,SideMenuItemContent {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnCloseToYou: UIButton!
    @IBOutlet weak var btnTotam: UIButton!
    @IBOutlet weak var btnOfTheDay: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var tblPromotion: UITableView!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        tblPromotion.register(UINib(nibName: "PromotionTvCell", bundle: nil), forCellReuseIdentifier: "PromotionTvCell")
    }
    
    //MARK: Tableview Delgate & DataSource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PromotionTvCell = tblPromotion.dequeueReusableCell(withIdentifier: "PromotionTvCell", for: indexPath) as! PromotionTvCell
        return cell
    }
    
    //MARK: Button IBAction Method
    @IBAction func btnMenuClicked(_ sender: Any) {
       showSideMenu()
    }
    
    //MARK: Custom Method
    func configureView(){
        titleLabel.setTitleLabel(title: promotionTitle)
        btnCloseToYou.appButton(title: closeToYou)
        btnOfTheDay.appButton(title: ofTheDay)
        btnTotam.appButton(title: "Totam")
        btnMenu.imageView?.image = btnMenu.imageView?.image!.withRenderingMode(.alwaysTemplate)
        btnMenu.imageView?.tintColor = UIColor.white
    }

    //MARK: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
