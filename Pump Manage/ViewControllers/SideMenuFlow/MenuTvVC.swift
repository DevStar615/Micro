//
//  MenuTvVC.swift
//  Pump Manage
//
//  Created by mac on 23/08/18.
//

import UIKit
import InteractiveSideMenu

class MenuTvVC: MenuViewController {

    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var vwAvtar: UIView!
    @IBOutlet weak var imgAvtar: UIImageView!
    
    var arrMenu = ["Dashboard","Logout"]
    private var gradientLayer = CAGradientLayer()
    private var gradientApplied: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenu.register(UINib(nibName: "MenuTvCell", bundle: nil), forCellReuseIdentifier: "MenuTvCell")
        tblMenu.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        imgAvtar.layer.cornerRadius = imgAvtar.frame.size.width/2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let topColor = UIColor(red: 0.0/255.0, green: 52.0/255.0, blue: 100.0/255.0, alpha: 1.0)
        let bottomColor = UIColor(red: 0.0/255.0, green: 100.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    deinit{
        print()
    }
    
    //MARK:Memory Warning hu
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MenuTvVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTvCell = tblMenu.dequeueReusableCell(withIdentifier: "MenuTvCell", for: indexPath) as! MenuTvCell
        cell.lblMenuTitle.text = arrMenu[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(arrMenu[indexPath.row] == "Logout"){
            var viewController: UIViewController?
            viewController = LoginVC(nibName: "LoginVC", bundle: nil)
            let navigationController = UINavigationController(rootViewController: viewController!)
            navigationController.navigationBar.isHidden=true
            navigationController.navigationBar.isTranslucent = false
            appDelegate?.window?.rootViewController = navigationController
            appDelegate?.window?.makeKeyAndVisible()
            let appDomain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: appDomain)

        }else{
            guard let menuContainerViewController = self.menuContainerViewController else {
                return
            }
            menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
            menuContainerViewController.hideSideMenu()
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}

