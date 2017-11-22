//
//  DateBeforeViewController.swift
//  Practica5
//
//  Created by Roberto Llop Cardenal on 22/11/17.
//  Copyright © 2017 IWEB. All rights reserved.
//

import UIKit

class DateBeforeViewController: UIViewController {

    var beforeDate: Date!
    
    var def: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var beforeDatePicker: UIDatePicker!
    
    var completionHandlerBeforeDate: ((Date) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beforeDatePicker.date = beforeDate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        completionHandlerBeforeDate?(beforeDatePicker.date)
    }
    
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backBefore" {
            def.set(beforeDatePicker.date, forKey:  "beforeDate")
            if let mvc = segue.destination as? MainViewController {
                mvc.dateBefore = beforeDatePicker.date
            }
        }
    }
    */
    

}
