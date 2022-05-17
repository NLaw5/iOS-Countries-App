//
//  CountryDetailsViewController.swift
//  MAP523_FinalAssignment
//
//  Created by Newman Law on 2022-04-19.
//

import UIKit
import CoreData

class CountryDetailsViewController: UIViewController {

    var country:Countries? = nil
    var favouriteList:[Favourite] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var lblErrorMessage: UILabel!
    
    @IBOutlet weak var lblCountryCapital: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountryPopulation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Entering Second Screen")

        guard let inputCountry = country else {
            //Send error message to label
            lblErrorMessage.text = "Country Details cannot be loaded, we are sorry for the inconvenience"
            lblCountryName.text = ""
            lblCountryCode.text = ""
            lblCountryCapital.text = ""
            lblCountryPopulation.text = ""
            
            return
        }

        lblCountryName.text = "Country Name: \(inputCountry.countryName)"
        lblCountryCapital.text = "Country Capital: \(inputCountry.capitalName)"
        lblCountryCode.text = "Country Code: \(inputCountry.countryCode)"
        lblCountryPopulation.text = "Population: \(inputCountry.population)"
        lblErrorMessage.text = " "
//

    }
    
  
    

    @IBAction func saveToFavorite(_ sender: Any) {
        
     
        
        
        var checkIfExist = false;
    
        // Grab all favourites for now:
        // 1. Create a fetch request object
        let request:NSFetchRequest<Favourite> = Favourite.fetchRequest()
        // 2. Initiate fetch request
        do{
            let results:[Favourite] = try self.context.fetch(request)
            self.favouriteList = results
            print("Success when fetching favourite countries!")
        } catch {
            print("Fetching Tasks failed")
        }
        
        for elements in favouriteList{
            //Check to see if element already exist
            if(elements.name == country?.countryName)
            {
                checkIfExist = true;
            }
        }
        
        if(checkIfExist != true)
        {
            // Insert or add to favourite in core data:
            let intPopulation = country?.population
            // Create favourite object

            
            let favouriteCountry = Favourite(context: self.context)
            
            // 2. Set the property of the object
            favouriteCountry.population = Int64(intPopulation!)
            favouriteCountry.name = country?.countryName
            
            // 3.Use the context variable to save favoourite to the database table
            
            do {
                try self.context.save()
                print("Favourite country saved")
                
                //Alert box:
                let box = UIAlertController(title: "Adding Country", message: "Succesfully Saved", preferredStyle: .alert)
                box.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                self.present(box, animated: true)
            }
            catch{
                print("Save Failed")
            }
        }
        else{
            //Send alert box indicating that it cannot be saved
            let box = UIAlertController(title: "Failed to add country", message: "Unsuccesfully saved, country already exists in favourite list", preferredStyle: .alert)
            box.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            self.present(box, animated: true)
        }
    }
    
}
