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
    
    /* indicates if lending or borrowing
    true = borrowing
    false = lending */
    var debtFlag : Bool?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.takePicture()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Responsive Methods
    
    @IBAction func segmentSelectedDebtValueChanged(sender: AnyObject) {
        
        switch segmentControlSelectedDebt.selectedSegmentIndex
        {
        case 0:
            // Money Debt Selected
            self.textFieldItemDescription.hidden = true
            self.imageViewItemImage.hidden = true
            self.textFieldDebtMoneyValue.hidden = false
            
        case 1:
            // Stuff Debt Selected
            self.textFieldDebtMoneyValue.hidden = true
            self.textFieldItemDescription.hidden = false
            self.imageViewItemImage.hidden = false
            
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
                let itemObject : Item = Item.createItemWithName(textFieldItemDescription.text, inImage: nil)
                LendBorrow.createDebtWithItem(itemObject, money: nil, inToFromWho: textFieldOtherPerson.text, inReminder: nil, inDebt: debtFlag!)
                
            default:
                break
            }
            
            self.performSegueWithIdentifier("unwindSegueToDebtsList", sender: self)
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
    
    func takePicture(){
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true) { () -> Void in
            //
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
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
