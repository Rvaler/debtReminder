//
//  NewDebtCreationViewController.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/22/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import UIKit
import Foundation

class NewDebtCreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var segmentControlSelectedDebt: UISegmentedControl!
    @IBOutlet weak var textFieldOtherPerson: UITextField!
    @IBOutlet weak var textFieldItemDescription: UITextField!
    @IBOutlet weak var textFieldDebtMoneyValue: UITextField!
    @IBOutlet weak var imageViewItemImage: UIImageView!
    
    @IBOutlet weak var buttonPhotoPicker: UIButton!
    @IBOutlet weak var barButtonCancel: UIBarButtonItem!
    @IBOutlet weak var barButtonCreate: UIBarButtonItem!
    
    var itemDescriptionUnderline: CALayer?
    var debtMoneyValueUnderline: CALayer?
    var otherPersonUnderline: CALayer?
    
    /* indicates if lending or borrowing
    true = borrowing
    false = lending */
    var debtFlag : Bool?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewLayout(){
        barButtonCancel.tintColor = DBRColors.DBRRedColor
        barButtonCreate.tintColor = DBRColors.DBRGreenColor
        barButtonCreate.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18)!], forState: UIControlState.Normal)
        barButtonCancel.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Medium", size: 18)!], forState: UIControlState.Normal)
        segmentControlSelectedDebt.tintColor = DBRColors.DBRBlackColor
        
        textFieldDebtMoneyValue.textColor = DBRColors.DBRBlackColor
        textFieldItemDescription.textColor = DBRColors.DBRBlackColor
        textFieldOtherPerson.textColor = DBRColors.DBRBlackColor
        imageViewItemImage.layer.borderWidth = 0.5
        imageViewItemImage.layer.cornerRadius = 15
        imageViewItemImage.clipsToBounds = true
        
        buttonPhotoPicker.setBackgroundImage(UIImage(named: "image_Camera"), forState: UIControlState.Normal)
        
        otherPersonUnderline = DBRLayers.DBRcreateUnderline(textFieldOtherPerson, color: DBRColors.DBRBlackColor)
        self.setMoneyViewLayout()
        self.textFieldOtherPerson.becomeFirstResponder()
    }
    
    func setStuffViewLayout()
    {
        self.textFieldDebtMoneyValue.hidden = true
        self.textFieldItemDescription.hidden = false
        self.imageViewItemImage.hidden = false
        self.buttonPhotoPicker.hidden = false
        
        self.textFieldOtherPerson.tintColor = DBRColors.DBRBlackColor
        self.textFieldItemDescription.tintColor = DBRColors.DBRBlackColor
        
        if self.debtFlag == true{
            self.textFieldOtherPerson.placeholder = "From who are you borrowing?"
            self.textFieldItemDescription.placeholder = "What are you borrowing?"
        }else{
            self.textFieldOtherPerson.placeholder = "To whom are you lending?"
            self.textFieldItemDescription.placeholder = "What are you lending?"
        }
        
        itemDescriptionUnderline = DBRLayers.DBRcreateUnderline(self.textFieldItemDescription, color: DBRColors.DBRBlackColor)
        if let underlineDebtValue = self.debtMoneyValueUnderline
        {
            underlineDebtValue.backgroundColor = UIColor.clearColor().CGColor
        }
    }
    
    func setMoneyViewLayout()
    {
        self.textFieldItemDescription.hidden = true
        self.imageViewItemImage.hidden = true
        self.buttonPhotoPicker.hidden = true
        self.textFieldDebtMoneyValue.hidden = false
        
        self.textFieldDebtMoneyValue.tintColor = DBRColors.DBRBlackColor
        self.textFieldOtherPerson.tintColor = DBRColors.DBRBlackColor
        
        if self.debtFlag == true{
            self.textFieldOtherPerson.placeholder = "From who are you borrowing?"
        }else{
            self.textFieldOtherPerson.placeholder = "To whom are you lending?"
        }
        self.textFieldDebtMoneyValue.placeholder = "How much?"
        
        debtMoneyValueUnderline = DBRLayers.DBRcreateUnderline(textFieldDebtMoneyValue, color: DBRColors.DBRBlackColor)
        if let underlineItemDescription = itemDescriptionUnderline
        {
            underlineItemDescription.backgroundColor = UIColor.clearColor().CGColor
        }
    }
    
    // MARK: - Responsive Methods
    
    @IBAction func segmentSelectedDebtValueChanged(sender: AnyObject) {
        
        switch segmentControlSelectedDebt.selectedSegmentIndex
        {
        case 0:
            // Money Debt Selected
            self.setMoneyViewLayout()
        case 1:
            // Stuff Debt Selected
            self.setStuffViewLayout()
        default:
            break
        }

    }
    
    @IBAction func actionCreateNewDebt(sender: AnyObject) {
    
        if (self.checkFiledFields() == true)
        {
            switch segmentControlSelectedDebt.selectedSegmentIndex
            {
            case 0:
                // Money Debt Selected
                let moneyText = self.textFieldDebtMoneyValue.text as NSString
                let moneyObject: Money = Money.createMoneyWithValue(moneyText.floatValue)
                LendBorrow.createDebtWithItem(nil, money: moneyObject, inToFromWho: textFieldOtherPerson.text, inReminder: nil, inDebt: debtFlag!)
                
            case 1:
                // Stuff Debt Selected
                
                var itemObject : Item?
                if let imageItem = self.imageViewItemImage.image
                {
                    //let imageData : NSData = UIImagePNGRepresentation(imageItem)
                    let imageData:NSData = UIImageJPEGRepresentation(imageItem, 0.6)
                    itemObject = Item.createItemWithName(textFieldItemDescription.text, inImage: imageData)
                }else{
                    if self.debtFlag == true{
                        let imageData:NSData = UIImageJPEGRepresentation(UIImage(named: "image_RedNoImage"), 0.6)
                        itemObject = Item.createItemWithName(textFieldItemDescription.text, inImage: imageData)
                    }else{
                        let imageData:NSData = UIImageJPEGRepresentation(UIImage(named: "image_GreenNoImage"), 0.6)
                        itemObject = Item.createItemWithName(textFieldItemDescription.text, inImage: imageData)
                    }
                }
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                LendBorrow.createDebtWithItem(itemObject, money: nil, inToFromWho: self.textFieldOtherPerson.text, inReminder: nil, inDebt: self.debtFlag!)
                
            default:
                break
            }
            
            self.performSegueWithIdentifier("unwindSegueToDebtsList", sender: self)
        }
        
    }

    // choose item photo
    @IBAction func actionPickPhoto(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true) { () -> Void in
            //
        }
    }
    
    // returns true if everythings ok
    func checkFiledFields() -> Bool
    {
        switch segmentControlSelectedDebt.selectedSegmentIndex
        {
        case 0:
            // Money Debt Selected
            let moneyValue = textFieldDebtMoneyValue.text as NSString
            if (textFieldOtherPerson.text != "" && moneyValue.floatValue > 0)
            {
                return true
            }
            return false
            
        case 1:
            // Stuff Debt Selected
            if (textFieldOtherPerson.text != "" && textFieldItemDescription != "")
            {
                return true
            }
            return false
            
        default:
            return false
        }
    }
    
    
    //MAKE - camera methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        self.buttonPhotoPicker.setBackgroundImage(nil, forState: UIControlState.Normal)
        imageViewItemImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
