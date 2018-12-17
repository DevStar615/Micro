//
//  ApplyForLoanVC.swift
//  Pump Manage
//
//  Created by Mac2018_1 on 28/08/18.
//

import UIKit

class ApplyForLoanVC: BaseViewController {

    @IBOutlet weak var vwBottom: UIView!
    @IBOutlet weak var vwProgress: UIView!
    @IBOutlet weak var vwTitle: UIView!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLoan: UILabel!
    @IBOutlet weak var lbltotal: UILabel!
    @IBOutlet weak var lblIntrest: UILabel!
    @IBOutlet weak var lblLoanTtl: UILabel!
    @IBOutlet weak var lbltotalTtl: UILabel!
    @IBOutlet weak var lblIntrestTtl: UILabel!
    @IBOutlet weak var lblLoanTitle: UILabel!
    @IBOutlet weak var lblTimeTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAnnualRate: UILabel!
    @IBOutlet weak var lblAverageCat: UILabel!
    @IBOutlet weak var lblWithoutVat: UILabel!
    @IBOutlet weak var sliderLoan: CustomSlider!
    @IBOutlet weak var sliderTime: CustomSlider!
    @IBOutlet weak var btnApplyForLoan: UIButton!
    @IBOutlet weak var widthVwBottom: NSLayoutConstraint!
    
    var vwSlider: SliderThumb!
    var vwSliderTime: SliderThumb!
    var creditParam = NSDictionary()
    var interestRate:Float = 1

    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getCreditParam()
        sliderLoan.addTarget(self, action:#selector(changeValue), for: .valueChanged)
        sliderTime.addTarget(self, action:#selector(changeTimeValue), for: .valueChanged)
    }
    
    //MARK:- Custom Function
    func changeThumbView(){
        self.vwSlider = SliderThumb(frame: CGRect(), value: String("$ " + String(Int(sliderLoan.value))))
        let imgThumb = self.vwSlider.asImage()
        sliderLoan.setThumbImage(imgThumb, for: .normal)
        sliderLoan.setThumbImage(imgThumb, for: .highlighted)
    }
    
    func changeTimeThumbView(){
        self.vwSliderTime = SliderThumb(frame: CGRect(), value: String(String(Int(sliderTime.value)) + " " + days))
        let returnDate = Date().add(value: Int(sliderTime.value))
        lblDate.text = Date().stringFromDate(date: returnDate!, format: "EEEE MMM-dd yyyy")
        let imgThumb = self.vwSliderTime.asImage()
        sliderTime.setThumbImage(imgThumb, for: .normal)
        sliderTime.setThumbImage(imgThumb, for: .highlighted)
        calculateSimpleInterest()
    }
    
    @objc func changeTimeValue(){
        self.vwSliderTime.lblValue.text = String(String(Int(sliderTime.value)) + " " + days)
        let imgThumb = self.vwSliderTime.asImage()
        sliderTime.setThumbImage(imgThumb, for: .normal)
        sliderTime.setThumbImage(imgThumb, for: .highlighted)
        let returnDate = Date().add(value: Int(sliderTime.value))
        lblDate.text = Date().stringFromDate(date: returnDate!, format: "EEEE MMM-dd yyyy")
        calculateSimpleInterest()
    }
    
    @objc func changeValue(){
        let currValue = (Int(sliderLoan.value)/100) * 100
        self.vwSlider.lblValue.text = String("$ " + String(currValue))
        let imgThumb = self.vwSlider.asImage()
        sliderLoan.setThumbImage(imgThumb, for: .normal)
        sliderLoan.setThumbImage(imgThumb, for: .highlighted)
        calculateSimpleInterest()
    }
    
    func calculateSimpleInterest(){
        let currValue = (Int(sliderLoan.value)/100) * 100
        let currTimeValue = Int(sliderTime.value)
        let simpleIntrest:Float = (Float(currValue) * Float(interestRate) *  Float(currTimeValue)) / 100
        let total = simpleIntrest + Float(currValue)
        lblIntrest.text = String(format: "$ %.2f", simpleIntrest)
        lbltotal.text = String(format: "$ %.2f", total)
        lblLoan.text = String("$ " + String(currValue))
    }
    func configureView(){
        view.backgroundColor = AppColor.appColor
        vwTitle.backgroundColor = AppColor.backgroundColor
        lblTitle.setTitleLabel(title: creditSimulation)
        lblLoanTitle.setSubTitleLabel(title: loanAmount)
        lblTimeTitle.setSubTitleLabel(title: loanTime)
        lblLoanTtl.setMiniTitleLabel(title: loan)
        lblIntrestTtl.setMiniTitleLabel(title: interest)
        lbltotalTtl.setMiniTitleLabel(title: total)
        btnApplyForLoan.appButton(title: applyForLoan)
        if(UIDevice().currentDevice() == iPhone5s5c5SE){
            widthVwBottom.constant = 280
        }
        lblAnnualRate.text = simpleAnnualFixedRate
        lblAverageCat.text = averageCat
        lblWithoutVat.text = withoutVAT
    }
    
    //MARK:- IBAction Methods
    @IBAction func btnApplyForLoanClicked(_ sender: Any) {
        let loginVC = LoginVC(nibName: "LoginVC", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    //MARK:- Api Call
    func getCreditParam(){
        APIService.sharedInstance.makeCall(requestMethod: "GET", apiName: credit, params: NSMutableDictionary(), isTokenRequired: true, forSuccessionBlock: { (response, error) in
            DispatchQueue.main.async {
                if(error != nil) {
                    showToastMessage(error!)
                    self.vwMain.isHidden = true
                }else{
                    if(response != nil) {
                        let resAry = response as! NSArray
                        let creditArray = CreditModel().initCreditData(arrRes: resAry)
                        self.creditParam = creditArray as NSDictionary
                        if(self.creditParam.value(forKey: "MinimumAmount") != nil){
                            let minValue:String = self.creditParam.value(forKey: "MinimumAmount") as! String
                            self.sliderLoan.minimumValue = Float(minValue)!
                            self.sliderLoan.value = Float(minValue)!
                        }
                        if(self.creditParam.value(forKey: "MaximumAmount") != nil){
                            let maxValue:String = self.creditParam.value(forKey: "MaximumAmount") as! String
                            self.sliderLoan.maximumValue = Float(maxValue)!
                        }
                        if(self.creditParam.value(forKey: "MinimumPeriod") != nil){
                            let minPeriod:String = self.creditParam.value(forKey: "MinimumPeriod") as! String
                            self.sliderTime.maximumValue = Float(minPeriod)!
                            self.sliderTime.value = Float(minPeriod)!
                        }
                        if(self.creditParam.value(forKey: "MaximumPeriod") != nil){
                            let maxPeriod:String = self.creditParam.value(forKey: "MaximumPeriod") as! String
                            self.sliderTime.maximumValue = Float(maxPeriod)!
                        }
                        if(self.creditParam.value(forKey: "InterestRate") != nil){
                            let interest:String = self.creditParam.value(forKey: "InterestRate") as! String
                            self.interestRate = Float(interest)!
                        }
                        self.changeThumbView()
                        self.changeTimeThumbView()
                        self.vwMain.isHidden = false
                    }
                }
            }
        }) { (error) in
            self.vwMain.isHidden = false
            showToastMessage(serverError)
            print("Error in Credit Param %@",error)
        }
    }
    
    
    //MARK:-  Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
