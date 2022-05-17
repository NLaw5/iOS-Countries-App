//
//  FavouriteCountryViewController.swift
//  MAP523_FinalAssignment
//
//  Created by Newman Law on 2022-04-19.
//

import UIKit
import CoreData
class FavouriteCountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favouriteList:[Favourite] = []
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("In function view will appear")
        super.viewWillAppear(animated)
        
        self.grabFavourites()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        print("We are in the favourite country view screen!")
        self.grabFavourites()
        // Do any additional setup after loading the view.
    }
    

    func grabFavourites() {
        // 1. Create a fetch request object
        let request:NSFetchRequest<Favourite> = Favourite.fetchRequest()
        // 2. Initiate fetch request
        do{
            let results:[Favourite] = try self.context.fetch(request)
            self.favouriteList = results
            print("Success when fetching favourite countries!")
            self.tableview.reloadData()
        } catch {
            print("Fetching Tasks failed")
        }
    }
    
    // MARK: Table View Functions
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.favouriteList.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = self.tableview.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as UITableViewCell
       //cell.textLabel?.text = taskList[indexPath.row]
       cell.textLabel?.text = favouriteList[indexPath.row].name
       cell.detailTextLabel?.text = String(favouriteList[indexPath.row].population)
       
       if(favouriteList[indexPath.row].population > 38005238)
       {
           cell.backgroundColor = UIColor.yellow
       }
       return cell
   }
   
   
   // delete a row
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
       if editingStyle == .delete {
           
            print("Deleting Task")

           // 1. Get a refeence to the NSManaged task object you want to delete
           let request:NSFetchRequest<Favourite> = Favourite.fetchRequest()
           request.predicate = NSPredicate(format: "name == %@", favouriteList[indexPath.row].name as! CVarArg)
           // 2. Use context variable to delete it from Core Data
           
           do {
               let results:[Favourite] = try self.context.fetch(request)
            
               let deletedRequest = results.first!
               
               self.context.delete(deletedRequest)
               try self.context.save()
               // 2. remove it from the tasks array
               self.favouriteList.remove(at:indexPath.row)
              
               // 3. remove it from the table view
               tableView.deleteRows(at: [indexPath], with: .fade)

           }
           catch {
               print("Deletion unsuccesful in database")
           }
       }
   }


}
