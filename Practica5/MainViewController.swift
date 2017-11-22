//
//  MainViewController.swift
//  Practica5
//
//  Created by Roberto Llop Cardenal on 22/11/17.
//  Copyright © 2017 IWEB. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var desdeLabel: UILabel!
    @IBOutlet weak var hastaLabel: UILabel!
    
    var dateBefore: Date = Date(timeIntervalSinceNow: 0)
    var dateAfter: Date = Date(timeIntervalSinceNow: 0)
    
    var def: UserDefaults = UserDefaults.standard
    
    let dateFormatter = DateFormatter()
    
    let dateFormatterURL = ISO8601DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "ddMMMMyyyy"
        dateFormatter.monthSymbols = [" de enero de ", " de febrero de ", " de marzo de ", " de abril de ", " de mayo de ", " de junio de ", " de julio de ", " de agosto de ", " de septiembre de ", " de octubre de ", " de noviembre de ", " de diciembre de "]
        if (def.object(forKey: "dateBefore") != nil) {
            dateBefore = def.object(forKey: "dateBefore") as! Date
        } else {
            def.set(dateBefore, forKey: "dateBefore")
        }
        
        if (def.object(forKey: "dateAfter") != nil) {
            dateAfter = def.object(forKey: "dateAfter") as! Date
        } else {
            def.set(dateAfter, forKey: "dateAfter")
        }
        desdeLabel.text = "Desde: "+dateFormatter.string(from: dateBefore)
        hastaLabel.text = "Hasta: "+dateFormatter.string(from: dateAfter)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBefore" {
            if let bdvc = segue.destination as? DateBeforeViewController {
                bdvc.beforeDate = dateBefore
                bdvc.completionHandlerBeforeDate = {(bDate: Date) in
                    self.dateBefore = bDate
                    self.desdeLabel.text = "Desde: "+self.dateFormatter.string(from: bDate)
                    self.def.set(bDate, forKey: "dateBefore")
                    print(ISO8601DateFormatter.string(from: bDate, timeZone: .current, formatOptions: [.withFullDate]))
                }
            }
        }
        else if segue.identifier == "goAfter" {
            if let advc = segue.destination as? DateAfterViewController {
                advc.afterDate = dateAfter
                advc.completionHandlerAfterDate = {(aDate: Date) in
                    self.dateAfter = aDate
                    self.hastaLabel.text = "Desde: "+self.dateFormatter.string(from: aDate)
                    self.def.set(aDate, forKey: "dateAfter")
                    print(ISO8601DateFormatter.string(from: aDate, timeZone: .current, formatOptions: [.withFullDate]))
                }
            }
        }
        else if segue.identifier == "showVisits" {
            if let vtvc = segue.destination as? VisitasTableViewController {
                vtvc.bDate = ISO8601DateFormatter.string(from: dateBefore, timeZone: .current, formatOptions: [.withFullDate])
                vtvc.aDate  = ISO8601DateFormatter.string(from: dateAfter, timeZone: .current, formatOptions: [.withFullDate])
            }
        }
    }
    
    
    @IBAction func backBefore(_ segue: UIStoryboardSegue){
        
    }
    
    @IBAction func backAfter(_ segue: UIStoryboardSegue){
        
    }

}
