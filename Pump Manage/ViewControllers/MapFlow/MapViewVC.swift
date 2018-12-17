//
//  MapViewVC.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 20/08/18.
//

import UIKit
import MapKit

class MapViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var tblViewMain: UITableView!
    @IBOutlet weak var viewSub: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tblViewSub: UITableView!
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        // Main TableView Cell
        tblViewMain.register(UINib(nibName: "mapTblViewCell", bundle: nil), forCellReuseIdentifier: "mapTblViewCell")
        // Sub TableView Cell
        tblViewSub.register(UINib(nibName: "pumpDetailsTblCellLike", bundle: nil), forCellReuseIdentifier: "pumpDetailsTblCellLike")
        tblViewSub.register(UINib(nibName: "pumpDetailsTblCellServices", bundle: nil), forCellReuseIdentifier: "pumpDetailsTblCellServices")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Tableview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tblViewMain == tableView
        {
            return 5
        }
        else
        {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewMain
        {
            let myCell=tableView.dequeueReusableCell(withIdentifier: "mapTblViewCell", for: indexPath) as! mapTblViewCell
            myCell.backgroundColor=UIColor.gray.withAlphaComponent(0)
            return myCell
        }
        else
        {
            var myCell: UITableViewCell
            switch(indexPath.row)
            {
            case 0:
                myCell = tableView.dequeueReusableCell(withIdentifier: "pumpDetailsTblCellLike", for: indexPath) as! pumpDetailsTblCellLike
                break
            case 1:
                myCell = tableView.dequeueReusableCell(withIdentifier: "pumpDetailsTblCellServices", for: indexPath) as! pumpDetailsTblCellServices
                break
            default:
                myCell = UITableViewCell()
            }
            myCell.backgroundColor=UIColor.gray.withAlphaComponent(0)
            return myCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblViewMain
        {
            return 96
        }
        else
        {
            return 107
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tblViewMain == tableView
        {
            UIView.animate(withDuration: 1, animations: {
                self.tblViewMain.isHidden = true
                self.mapView.frame = CGRect(x: self.mapView.frame.origin.x, y: self.mapView.frame.origin.y, width: self.mapView.frame.size.width, height: 183)
                self.viewSub.frame = CGRect(x: 0, y: self.mapView.frame.origin.y + 183, width: self.viewSub.frame.size.width, height: self.viewSub.frame.size.height)
            }, completion: nil)
        }
    }
    
    // MARK:- Custom Method
    func design() {
        lblStart.text = start
    }
}
