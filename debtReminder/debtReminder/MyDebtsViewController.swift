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
    
    var myDebtsList : NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableViewData()
        
        self.tableViewAllDebts.dataSource = self
        self.tableViewAllDebts.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let debtsList = self.myDebtsList
        {
            let debtObject: LendBorrow? = myDebtsList?.objectAtIndex(indexPath.row) as? LendBorrow
            let debtCell = tableViewAllDebts.dequeueReusableCellWithIdentifier("allDebtsCell") as! AllDebtsTableViewCell
            
            //moneyObject
            if let moneyObject = debtObject?.relationMoney
            {
                debtCell.labelDebtItem.text = moneyObject.value.stringValue
            }
            //itemObject
            else if let itemObject = debtObject?.relationItem
            {
                debtCell.labelDebtItem.text = itemObject.itemName
            }
            
            
            debtCell.labelInDebtPerson.text = debtObject?.toFromWho
            return debtCell
        }else{
            
            let debtCell = tableViewAllDebts.dequeueReusableCellWithIdentifier("reuse identifier") as! AllDebtsTableViewCell
            return debtCell
        }
    }
    
    func loadTableViewData()
    {
        self.myDebtsList = LendBorrow.loadDebts()
        self.tableViewAllDebts.reloadData()
    }
    
    //MARK: - Button Actions

    @IBAction func actionCreateNewDebt(sender: AnyObject) {
        
        performSegueWithIdentifier("segueCreateNewDebt", sender: self)
    }
    
    
    
    @IBAction func cancelNewDebtCreation(segue:UIStoryboardSegue){
    }
}
