//
//  VisitasTableViewController.swift
//  Practica5
//
//  Created by Jaime on 21/11/2017.
//  Copyright © 2017 IWEB. All rights reserved.
//

import UIKit

typealias Visita = [String:Any]

class VisitasTableViewController: UITableViewController {

    var visitas = [Visita]()
    
    var session = URLSession.shared
    
    var imgCache = [String:UIImage]()
    
    var urlMio: String?
    
    var urlFav: String?
    
    var urlTodas: String?
    
    var strurl: String = ""
    
    var titulo: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(titulo!)
        title = titulo
        downloadVisits()
    }
    
    private func downloadVisits() {
        
//<<<<<<< HEAD
//        let strurl = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(token)&dateafter=2017-10-01&datebefore=2017-11-07"
//=======
        //var strurl = "https://dcrmt.herokuapp.com/api/visits/flattened?token=\(token)&datebefore=\(bDate!)&dateafter=\(aDate!)"
//>>>>>>> 074510c8d026abffa1dd08f30bb21ec5dced1a50
        
        switch titulo! {
        case "Todas las visitas":
            strurl = urlTodas!
            break
        case "Visitas favoritas":
            strurl = urlFav!
            break
        case "Mis visitas":
            strurl = urlMio!
            break
        default:
            strurl = urlTodas!
        }
        print(strurl)
        
        if let url = URL(string: strurl) {
            
            let tarea = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Error Tipo 1", error!.localizedDescription)
                    return
                }
                
                if (response as! HTTPURLResponse).statusCode != 200 {
                    print("Error Tipo 2", (response as! HTTPURLResponse).statusCode)
                    return
                }
                
                if let visitas = (try? JSONSerialization.jsonObject(with: data!)) as? [Visita] {
                    DispatchQueue.main.async {
                        self.visitas = visitas
                        self.tableView.reloadData()
                    }
                }
                
            }
            
            tarea.resume()
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visitas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit Cell", for: indexPath) as! VisitTableViewCell

        let visit = visitas[indexPath.row]
        
        cell.nameLabel.text = ""
        cell.salesmanLabel.text = ""
        cell.plannedForLabel.text = ""
        cell.accomplishedLabel.text = "La visita no se ha realizado"
        
        cell.imagen.image = UIImage(named: "noface")
        
        //Nombre del customer
        if let customer = visit["Customer"] as? [String:Any], let name = customer["name"] as? String {
            cell.nameLabel.text = name
        }
        
        if let salesman = visit["Salesman"] as? [String:Any],let sName = salesman["fullname"] as? String {
            cell.salesmanLabel.text = "Vendedor: "+sName
        }
        
        //Fecha de la visita con el formateador
        if let plannedFor = visit["plannedFor"] as? String {
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: plannedFor) {
                let str3 = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                cell.plannedForLabel.text = str3
            }
        }
        
        if let accomplishedBy = visit["fulfilledAt"] as? String {
            let df = ISO8601DateFormatter()
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            df.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            if let d = df.date(from: accomplishedBy) {
                let date = ISO8601DateFormatter.string(from: d, timeZone: .current, formatOptions: [.withFullDate])
                cell.accomplishedLabel.text = date
            }
        }
        
        if let salesman = visit["Salesman"] as? [String:Any], let photo = salesman["Photo"] as? [String:Any], let strurl = photo["url"] as? String {
            
            if let img = imgCache[strurl] {
                cell.imagen.image = img
            } else {
                updatePhoto(strurl, for: indexPath)
            }
            
        }

        return cell
    }
    
    //Posibles mejoras: mirar la velocidad de los scroll para no bajarse las fotos hasta que se vayan a usar
    //Guardar en un array las imágenes que se han guardado para no descargar varias veces la misma imagen (Desde Customer??)
    
    func updatePhoto(_ strurl: String, for indexPath: IndexPath) {
        
        DispatchQueue.global().async {
            if let url = URL(string: strurl), let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imgCache[strurl] = img
                    self.tableView.reloadRows(at: [indexPath], with: .left)
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVisit" {
            if let vvc = segue.destination as? VisitViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    vvc.visita = visitas[indexPath.row]
                    vvc.image = imgCache
                }
            }
        }
    }
    

}
