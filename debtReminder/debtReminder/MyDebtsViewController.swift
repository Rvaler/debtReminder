//
//  MyDebtsViewController.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/21/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import UIKit

class MyDebtsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableViewAllDebts: UITableView!
    @IBOutlet weak var buttonLend: UIButton!
    @IBOutlet weak var buttonBorrow: UIButton!
    
    var myDebtsList : [AnyObject]?
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewAllDebts.dataSource = self
        self.tableViewAllDebts.delegate = self
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "loadTableViewData", forControlEvents: UIControlEvents.ValueChanged)
        self.tableViewAllDebts.addSubview(refreshControl)
        
        self.setViewLayout()
        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.loadTableViewData()
    }
    
    
    
    func setViewLayout()
    {
        self.navigationItem.title = "Lent Reminder"
        
        self.tableViewAllDebts.separatorColor = DBRColors.DBRBlackColor
        self.tableViewAllDebts.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = DBRColors.DBRGrayColor
        self.buttonBorrow.tintColor = DBRColors.DBRBlackColor
        self.buttonLend.tintColor = DBRColors.DBRBlackColor
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Table Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let debtsList = self.myDebtsList
        {
            return debtsList.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let debtsList = self.myDebtsList
        {
            if debtsList.count != 0
            {
                let debtObject: LendBorrow = debtsList[indexPath.row] as! LendBorrow
                let debtCell = tableViewAllDebts.dequeueReusableCellWithIdentifier("allDebtsCell") as! AllDebtsTableViewCell
                
                var debtDescriptionString : String!
                if(debtObject.debtFlag == true){
                    debtDescriptionString = "Borrowed"
                }else{
                    debtDescriptionString = "Lent"
                }
                
                //moneyObject
                if let moneyObject = debtObject.relationMoney
                {
                    let moneyValue = (moneyObject.value.stringValue as NSString).floatValue
                    let moneyText = String(format: "%.2f", moneyValue)
                    debtCell.labelDebtItem.text = "\(debtDescriptionString) $\(moneyText)"
                    if debtObject.debtFlag == true{
                        debtCell.imageViewDebtImage.image = UIImage(named: "image_RedMoney")
                    }else{
                        debtCell.imageViewDebtImage.image = UIImage(named: "image_GreenMoney")
                    }
                }
                    //itemObject
                else if let itemObject = debtObject.relationItem
                {
                    if let cellImage = itemObject.itemImage
                    {
                        debtCell.imageViewDebtImage.image = UIImage(data: cellImage)
                    }
                    debtCell.labelDebtItem.text = "\(debtDescriptionString) \(itemObject.itemName)"
                }
                
                debtCell.imageViewDebtImage.backgroundColor = UIColor.grayColor()
                debtCell.imageViewDebtImage.layer.cornerRadius = 10
                debtCell.imageViewDebtImage.clipsToBounds = true
                debtCell.labelInDebtPerson.text = debtObject.toFromWho
                return debtCell
            }else{
                // TODO: create empty debt cell
                let debtCell = tableViewAllDebts.dequeueReusableCellWithIdentifier("reuse identifier") as? UITableViewCell
                debtCell!.backgroundColor = UIColor.clearColor()
                return debtCell!
            }
        }else{
            
            let debtCell = tableViewAllDebts.dequeueReusableCellWithIdentifier("reuse identifier") as? UITableViewCell
            debtCell!.backgroundColor = UIColor.clearColor()
            return debtCell!
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            if let debtToDelete: AnyObject = myDebtsList?[indexPath.row]
            {
                LendBorrow.deleteDebt(debtToDelete as! LendBorrow)
                myDebtsList?.removeAtIndex(indexPath.row)
                tableViewAllDebts.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                self.tableViewAllDebts.reloadData()
            }
        }
    }
    
    func loadTableViewData()
    {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            self.myDebtsList = LendBorrow.loadDebts()
            dispatch_async(dispatch_get_main_queue()) {
                self.tableViewAllDebts.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    //MARK: - Button Actions

    @IBAction func actionLendSomething(sender: AnyObject) {
        performSegueWithIdentifier("segueCreateNewDebt", sender: sender)
    }
    
    @IBAction func actionBorrowSomething(sender: AnyObject) {
        performSegueWithIdentifier("segueCreateNewDebt", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender?.restorationIdentifier == "LendButton")
        {
            let viewController:NewDebtCreationViewController = segue.destinationViewController as! NewDebtCreationViewController
            viewController.debtFlag = false
        }else if (sender?.restorationIdentifier == "BorrowButton"){
            let viewController:NewDebtCreationViewController = segue.destinationViewController as! NewDebtCreationViewController
            viewController.debtFlag = true
        }
    }
    
    
    @IBAction func cancelNewDebtCreation(segue:UIStoryboardSegue){
    }
}
