//
//  PumpDetailsVC.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 21/08/18.
//

import UIKit

class mobilePaymentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var btnLitros: UIButton!
    @IBOutlet weak var btnPesos: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var currentIndex = -1

    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        tblView.register(UINib(nibName: "mobilePaymentCell", bundle: nil), forCellReuseIdentifier: "mobilePaymentCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell=tableView.dequeueReusableCell(withIdentifier: "mobilePaymentCell") as! mobilePaymentCell
        view.backgroundColor=UIColor.white
        myCell.backgroundColor=UIColor.gray.withAlphaComponent(0)
//        myCell.selectionStyle = UITableViewCellSelectionStyle.none
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == currentIndex {
            return 200
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removeSubView()
        if currentIndex == indexPath.row
        {
            currentIndex = -1
        }
        else
        {
            currentIndex = indexPath.row
            AddSubView(indexPath)
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK:- Custom Method
    func design() {
       // btnLitros.skipButton(title: litros, rect: btnLitros.frame)
        //btnPesos.loginButton(title: pesos, rect: btnPesos.frame)
        //        btnLitros.mapDetailsButton(title: litros, rect: btnLitros.frame)
        //        btnPesos.mapDetailsButton(title: pesos, rect: btnPesos.frame)
    }

    func AddSubView(_ indexPath: IndexPath) {
        let cell = tblView.cellForRow(at: indexPath) as! mobilePaymentCell
        cell.expand()
    }
    func removeSubView()
    {
        if(currentIndex != -1)
        {
            let cell = tblView.cellForRow(at: IndexPath(row: currentIndex, section: 0)) as! mobilePaymentCell
            cell.collapse()
        }
    }
}
