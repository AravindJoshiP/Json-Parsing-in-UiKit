//
//  DescriptionViewController.swift
//  Penumaka_A_HW2
//
//  Created by Aravind Joshi Penumaka on 5/1/26.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var selectedCar: Car?
    var details: [CarDetails]?

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var driveLabel: UILabel!
    @IBOutlet weak var engLabel: UILabel!
    @IBOutlet weak var transLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var cylindersLabel: UILabel!
    @IBOutlet weak var enginedescLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.makeLabel.text = selectedCar?.make
        //self.carLabel.text = selectedCar?.name
        // Do any additional setup after loading the view.
        fetchCarDetails()
         
    }
    
    func fetchCarDetails(){
        guard let selectedCar = selectedCar else {return}
        let makeName = selectedCar.make?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let modelName = selectedCar.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let feedURL = "https://carapi.app/api/engines/v2?limit=1&make=\(makeName)&model=\(modelName)"
        
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
                let decodedData = try JSONDecoder().decode(CarDetailsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.details = decodedData.data
                    if(self.details!.isEmpty){
                        self.descLabel.text = "No Details Found"
                        self.driveLabel.text = "No Details Found"
                        self.engLabel.text = "No Details Found"
                        self.transLabel.text = "No Details Found"
                        self.enginedescLabel.text = "No Details Found"
                        self.cylindersLabel.text = "No Details Found"
                        self.hpLabel.text = "No Details Found"
                        self.yearLabel.text = "No Details Found"
                        self.carLabel.text = self.selectedCar?.name
                        self.makeLabel.text = self.selectedCar?.make
                    }
                    else{
                        self.carLabel.text = self.details![0].model
                        self.descLabel.text = self.details![0].trim_description
                        self.driveLabel.text = self.details![0].drive_type
                        self.engLabel.text = self.details![0].engine_type
                        self.transLabel.text = self.details![0].transmission
                        self.makeLabel.text = self.details![0].make
                        self.enginedescLabel.text = self.details![0].cam_type
                        self.cylindersLabel.text = self.details![0].cylinders
                        self.hpLabel.text = String(self.details![0].horsepower_hp ?? 1)
                        self.yearLabel.text = String(self.details![0].year ?? 2026)
                    }
                }
                
            } catch {
                print("Decode Error:", error)
            }
            
        }.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
