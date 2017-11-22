//
//  DateAfterViewController.swift
//  Practica5
//
//  Created by Roberto Llop Cardenal on 22/11/17.
//  Copyright © 2017 IWEB. All rights reserved.
//

import UIKit

class DateAfterViewController: UIViewController {
    
    var afterDate: Date!
    
    var def: UserDefaults = UserDefaults.standard

    @IBOutlet weak var afterDatePicker: UIDatePicker!
    
    var completionHandlerAfterDate: ((Date) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        afterDatePicker.date = afterDate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        completionHandlerAfterDate?(afterDatePicker.date)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backAfter" {
            def.set(afterDatePicker.date, forKey: "afterDate")
            if let mvc = segue.destination as? MainViewController {
                mvc.dateAfter = afterDatePicker.date
            }
        }
    }
    */
    

}
