//
//  DashboardVC.swift
//  Pump Manage
//
//  Created by mac on 07/09/18.
//

import UIKit
import InteractiveSideMenu

class DashboardVC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SideMenuItemContent {
    
    @IBOutlet var cvMenu: UICollectionView!
    @IBOutlet var vwTop: UIView!
    @IBOutlet var btnCapital:UIButton!
    
    let arrImages = ["Natural Gas","Gasoline","Fitness","Automobile","Waste","Food","Green Card","Electricity","Health","Water","Metro"]
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        cvMenu.register(UINib(nibName: "DashboardCVCell", bundle: nil), forCellWithReuseIdentifier: "DashboardCVCell")
    }
    
    //MARK:- CollectionView DataSource and Delegate Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DashboardCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCVCell", for: indexPath) as! DashboardCVCell
        if(indexPath.row == arrImages.count){
            let iconName = arrImages[indexPath.row - 1]
            cell.imgIcon.image = UIImage(named: iconName)
            cell.lblIcon.text = iconName
        }else if(indexPath.row == arrImages.count - 1){
            cell.imgIcon.image = nil
            cell.lblIcon.text = ""
        }else{
            let iconName = arrImages[indexPath.row]
            cell.imgIcon.image = UIImage(named: iconName)
            cell.lblIcon.text = iconName
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (cvMenu.frame.width - max(0, 2)*10)/3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let naturalGasVc = NaturalGasVC(nibName: "NaturalGasVC", bundle: nil)
        if(indexPath.row == arrImages.count){
             naturalGasVc.lblTitleText = arrImages[indexPath.row - 1]
             self.navigationController?.pushViewController(naturalGasVc, animated: true)
        }else if(indexPath.row == arrImages.count - 1){
        }else{
            naturalGasVc.lblTitleText = arrImages[indexPath.row ]
            self.navigationController?.pushViewController(naturalGasVc, animated: true)
        }
    }
    
    //MARK:- Custom Function
    func design(){
        vwTop.backgroundColor = AppColor.backgroundColor
        view.backgroundColor = AppColor.appColor
        let btnText = "$25 " + freeCapital
        btnCapital.appButton(title: btnText)
    }
    
    //MARK:- IBAction Method
    @IBAction func btnMenuClicked(_ sender: Any) {
        showSideMenu()
    }
    
    //MARK:- Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
