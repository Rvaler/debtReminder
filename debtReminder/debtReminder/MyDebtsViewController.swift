//
//  MyDebtsViewController.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/21/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import UIKit

class MyDebtsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //MARK: - Button Actions

    @IBAction func actionCreateNewDebt(sender: AnyObject) {
        
        performSegueWithIdentifier("segueCreateNewDebt", sender: self)
    }
    
    
    
    @IBAction func cancelNewDebtCreation(segue:UIStoryboardSegue){
    }
}
