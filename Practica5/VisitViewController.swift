//
//  VisitViewController.swift
//  Practica5
//
//  Created by Jaime on 23/11/2017.
//  Copyright © 2017 IWEB. All rights reserved.
//

import UIKit


class VisitViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var customerName: UILabel!
    
    @IBOutlet weak var salesmanName: UILabel!
    
    @IBOutlet weak var plannedForLabel: UILabel!
    
    @IBOutlet weak var accomplishedByLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var webLabel: UILabel!
    
    var visita: Visita!
    
    var image: [String:UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalles de la Visita"
        profileImage.image = UIImage(named: "noface")
        customerName.text = "No especificado"
        salesmanName.text = "No especificado"
        plannedForLabel.text = "No planificada"
        accomplishedByLabel.text = "No realizada"
        notesLabel.text = "No especificado"
        addressLabel.text = "No especificado"
        cityLabel.text = "No especificado"
        emailLabel.text = "No especificado"
        phoneLabel.text = "No especificado"
        webLabel.text = "No especificado"
    
    
        
        if let salesman = visita["Salesman"] as? [String:Any], let sName = salesman["fullname"] as? String, let photo = salesman["Photo"] as? [String:Any], let photoUrl = photo["url"] as? String {
            salesmanName.text = sName
            if let img = image[photoUrl] {
                profileImage.image = img
            } else {
                updatePhoto(photoUrl)
            }
        }
        if let customer = visita["Customer"] as? [String:Any], let cName = customer["name"] as? String, let address = customer["address1"] as? String, let city = customer["city"] as? String, let phone = customer["phone1"] as? String, let email = customer["email1"] as? String, let web = customer["web"] as? String {
            customerName.text = cName
            if address == "" {
                addressLabel.text = "No especificado"
            } else {
                addressLabel.text = address
            }
            if city == "" {
                cityLabel.text = "No especificado"
            } else {
                
                cityLabel.text = city
            }
            if phone == "" {
                phoneLabel.text = "No especificado"
            } else {
                
                phoneLabel.text = phone
            }
            if email == "" {
                emailLabel.text = "No especificado"
            } else {
                
                emailLabel.text = email
            }
            if web == "" {
                webLabel.text = "No especificado"
            } else {
                webLabel.text = web
            }
        }
        if let plannedFor = visita["plannedFor"] as? String {
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: plannedFor) {
                let dateStr = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                plannedForLabel.text = dateStr
            }
        }
        if let accomplishedBy = visita["fullfilledAt"] as? String {
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: accomplishedBy) {
                let dateStr = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                accomplishedByLabel.text = dateStr
            }
        }
        if let notes = visita["notes"] as? String {
            if notes == "" {
                notesLabel.text = "No especificado"
            } else {
                notesLabel.text = notes
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatePhoto(_ strurl: String) {
        
        DispatchQueue.global().async {
            if let url = URL(string: strurl), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image[strurl] = img
                    self.viewDidLoad()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
