//
//  CardDetailVC.swift
//  Pump Manage
//
//  Created by mac on 21/08/18.
//

import UIKit

let  MAX_BUFFER_SIZE = 3;
let  SEPERATOR_DISTANCE = 8;
let  TOPYAXIS = 75;
let  DEBITCREDIT = "DebitCredit"
let  LOYALTY = "Loyalty"

class CardDetailVC: UIViewController{
    
    @IBOutlet weak var vwSwipe: UIView!
    @IBOutlet weak var vwLoyaltySwipe: UIView!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var lblDebit: UILabel!
    @IBOutlet weak var lblLoyalty: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    
    
    var currentIndex = 0
    var currentLoayaltyIndex = 0
    var currentLoadedCardsArray = [TinderCard]()
    var currentLoadedLoyaltyCardsArray = [TinderCard]()
    var allCardsArray = [TinderCard]()
    var allLoyaltyCardsArray = [TinderCard]()
    var valueArray = ["credit1","credit2","credit3","credit4"]
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadCardValues(array: valueArray,type:DEBITCREDIT)
        loadCardValues(array: valueArray, type: LOYALTY)

    }
    
    //MARK: custom Methods
    func loadCardValues(array:Array<Any>,type:String) {
        var loadedArray =  [TinderCard]()
        if valueArray.count > 0 {
            let capCount = (array.count > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : array.count
            for (i,value) in array.enumerated() {
                let newCard = createTinderCard(at: i,value: value as! String,type:type)
                if(type == DEBITCREDIT){
                    allCardsArray.append(newCard)
                    if i < capCount {
                        currentLoadedCardsArray.append(newCard)
                    }
                }else if(type == LOYALTY){
                    allLoyaltyCardsArray.append(newCard)
                    if i < capCount {
                        currentLoadedLoyaltyCardsArray.append(newCard)
                    }
                }
            }
            loadedArray = type == DEBITCREDIT ? currentLoadedCardsArray : currentLoadedLoyaltyCardsArray
            let view:UIView = type == DEBITCREDIT ? vwSwipe : vwLoyaltySwipe
            
            for (i,_) in loadedArray.enumerated() {
                if i > 0 {
                    view.insertSubview(loadedArray[i], belowSubview: loadedArray[i - 1])
                }else {
                    view.addSubview(loadedArray[i])
                }
            }
            type == DEBITCREDIT ? animateCardAfterSwiping(type: DEBITCREDIT) : animateCardAfterSwiping(type: LOYALTY)
        }
    }
    
    func createTinderCard(at index: Int , value :String,type: String) -> TinderCard {
        let card = TinderCard(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40 , height: vwSwipe.frame.size.height) ,imgName : value, typeName: type)
        card.delegate = self
        return card
    }
    
    func animateCardAfterSwiping(type:String) {
        let loaderArray = type == DEBITCREDIT ? currentLoadedCardsArray : currentLoadedLoyaltyCardsArray
        for (i,card) in loaderArray.enumerated() {
            UIView.animate(withDuration: 0.5, animations: {
                if i == 0 {
                    card.isUserInteractionEnabled = true
                }
                var frame = card.frame
                frame.origin.y = CGFloat(i * SEPERATOR_DISTANCE)
                card.frame = frame
            })
        }
    }

    func removeObjectAndAddNewValues() {
        currentLoadedCardsArray.remove(at: 0)
        currentIndex = currentIndex + 1
        if (currentIndex + currentLoadedCardsArray.count) < allCardsArray.count {
            let card = allCardsArray[currentIndex + currentLoadedCardsArray.count]
            var frame = card.frame
            frame.origin.y = CGFloat(MAX_BUFFER_SIZE * SEPERATOR_DISTANCE)
            card.frame = frame
            currentLoadedCardsArray.append(card)
            vwSwipe.insertSubview(currentLoadedCardsArray[MAX_BUFFER_SIZE - 1], belowSubview: currentLoadedCardsArray[MAX_BUFFER_SIZE - 2])
        }
        print(currentIndex)
        animateCardAfterSwiping(type:DEBITCREDIT)
        if(currentIndex == valueArray.count){
            currentIndex = 0
            currentLoadedCardsArray = [TinderCard]()
            allCardsArray = [TinderCard]()
            loadCardValues(array: valueArray, type: DEBITCREDIT)
        }
    }
    
    func removeObjectAndAddValuesLoyalty(){
        currentLoadedLoyaltyCardsArray.remove(at: 0)
        currentLoayaltyIndex = currentLoayaltyIndex + 1
        if (currentLoayaltyIndex + currentLoadedLoyaltyCardsArray.count) < allLoyaltyCardsArray.count {
            let card = allLoyaltyCardsArray[currentLoayaltyIndex + currentLoadedLoyaltyCardsArray.count]
            var frame = card.frame
            frame.origin.y = CGFloat(MAX_BUFFER_SIZE * SEPERATOR_DISTANCE)
            card.frame = frame
            currentLoadedLoyaltyCardsArray.append(card)
            vwLoyaltySwipe.insertSubview(currentLoadedLoyaltyCardsArray[MAX_BUFFER_SIZE - 1], belowSubview: currentLoadedLoyaltyCardsArray[MAX_BUFFER_SIZE - 2])
        }
        print(currentIndex)
        animateCardAfterSwiping(type:LOYALTY)
        if(currentLoayaltyIndex == valueArray.count){
            currentLoayaltyIndex = 0
            currentLoadedLoyaltyCardsArray = [TinderCard]()
            allLoyaltyCardsArray = [TinderCard]()
            loadCardValues(array: valueArray, type: LOYALTY)
        }
    }
    
    func configureView(){
        self.view.backgroundColor = AppColor.appColor
        vwBackground.backgroundColor = AppColor.backgroundColor
        lblTitle.setTitleLabel(title: paymentMethod)
        lblDebit.setSubTitleLabel(title: debitCreditCards)
        lblLoyalty.setSubTitleLabel(title: loyaltyCard)
        btnConfirm.appButton(title: confirm)
    }
    
    //MARK: Button IBAction Method
    @IBAction func btnConfirmClicked(_ sender: Any) {
        let promotionVc = PromotionsVC(nibName: "PromotionsVC", bundle: nil)
        self.navigationController?.pushViewController(promotionVc, animated: true)
    }
    
    //MARK: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CardDetailVC : TinderCardDelegate{
    
    // action called when the card goes to the left.
    func cardGoesLeft(card: TinderCard) {
        card.type == DEBITCREDIT ?  removeObjectAndAddNewValues() : removeObjectAndAddValuesLoyalty()
    }
    // action called when the card goes to the right.
    func cardGoesRight(card: TinderCard) {
        card.type == DEBITCREDIT ?  removeObjectAndAddNewValues() : removeObjectAndAddValuesLoyalty()
    }
    func currentCardStatus(card: TinderCard, distance: CGFloat) {
    }
}
