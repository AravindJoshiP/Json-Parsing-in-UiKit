//
//  TableViewController.swift
//  Penumaka_A_HW2
//
//  Created by Aravind Joshi Penumaka on 4/28/26.
//

import UIKit

class TableViewController: UITableViewController {
    
    var carMakes: [CarMake] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchCarMakes()
    }

    // MARK: - Table view data source
    
    func fetchCarMakes(){
        let feedURL = "https://carapi.app/api/makes"
        
        guard let url = URL(string: feedURL) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("API Error:", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(CarMakeResponse.self, from: data)
                
                
                DispatchQueue.main.async {
                    self.carMakes = decodedData.data
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Decode Error:", error)
            }
            
        }.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carMakes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attriCell", for: indexPath)

        // Configure the cell...
        let car = carMakes[indexPath.row]
        cell.textLabel?.text = car.name
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = attributes[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CarTableViewController") as! CarTableViewController
        
        vc.selectedAttribute = selectedCell
        navigationController?.pushViewController(vc, animated: true)
    } */
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let nav = segue.destination as? UINavigationController,
           let vc = nav.topViewController as? CarTableViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            
            vc.selectedMake = carMakes[indexPath.row]
        }
        
    }
    
}
