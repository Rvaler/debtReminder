//
//  NewDebtCreationViewController.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/22/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import UIKit
import Foundation

class NewDebtCreationViewController: UIViewController {

    @IBOutlet weak var segmentControlSelectedDebt: UISegmentedControl!
    @IBOutlet weak var textFieldOtherPerson: UITextField!
    @IBOutlet weak var textFieldItemDescription: UITextField!
    @IBOutlet weak var textFieldDebtMoneyValue: UITextField!
    @IBOutlet weak var imageViewItemImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        switch segmentControlSelectedDebt.selectedSegmentIndex
        {
        case 0:
            // Money Debt Selected
            let moneyText = self.textFieldDebtMoneyValue.text as NSString
            let moneyObject: Money = Money.createMoneyWithValue(moneyText.floatValue)
            LendBorrow.createDebtWithItem(nil, money: moneyObject, inToFromWho: textFieldOtherPerson.text, inReminder: nil)
            
        case 1:
            // Stuff Debt Selected
            let itemObject : Item = Item.createItemWithName(textFieldItemDescription.text, inImage: nil)
            LendBorrow.createDebtWithItem(itemObject, money: nil, inToFromWho: textFieldOtherPerson.text, inReminder: nil)
        
        default:
            break
        }
        
        self.performSegueWithIdentifier("unwindSegueToDebtsList", sender: self)
        
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
