//
//  ViewController.swift
//  MAP523_FinalAssignment
//
//  Created by Newman Law on 2022-04-19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    // context variable
//    // reference to variables created by the appdelegate swift file
//    let context = (UIApplication.shared.delegate as!
//                   AppDelegate).persistentContainer.viewContext
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        //Get current item we want to display
        let currTask = self.countryList[indexPath.row]
        cell.textLabel?.text = currTask.countryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row clicked")
        
        //Send user to next screen and send details of country to next screen as well
        //Navigate to second screen
        guard let navigateToScreen2 = storyboard?.instantiateViewController(identifier: "Screen2") as?
                CountryDetailsViewController else{
                    print("Error when navigating to second screen")
                    return
                }
      
        navigateToScreen2.country = self.countryList[indexPath.row]
    
        show(navigateToScreen2, sender:self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    var countryList:[Countries] = []
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.callCountrAPI()
        
        print("Testing \(self.countryList)")
        self.tableView.reloadData()
    }

    func callCountrAPI() {
        // define my endpoint
        let apiEndpoint = "https://restcountries.com/v2/all"

        guard let apiURL = URL(string:apiEndpoint) else {
            print("Could not convert the string endpoint to an URL object")
            return
        }
        
        // fetch the data (wait for a response)
        // once we have a response
        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
                    // the code that should run AFTER we receive a response from the website api
                // (or when the api doesn't respond at all 404)
            
            if let err = error {
                print("Error occured while fetching data from api")
                print(err)
                return
            }
            
            // what will we do if everything is ok?
            // - assuming you got JSON data back!
            if let jsonData = data {
                // - represent the data we got back from the APi
                // as an instance fo the Model class (SpaceshipLaunch)
                
                print(jsonData)
                // convert it to JSON data format
                do {
                    let decoder = JSONDecoder()
                    let decodedItem:[Countries] = try decoder.decode([Countries].self, from: jsonData)
                             
                    DispatchQueue.main.async {
                        // the value of the launchList will be set when we fetch the data from the API
                        print("Updating the Country List")
                        self.countryList.append(contentsOf: decodedItem)
                        
                        self.tableView.reloadData()
                    }

                }
                catch let error {
                    print("An error occured during JSON decoding")
                    print(error)
                }
            }
        }.resume()
        print(countryList)

    }
}

