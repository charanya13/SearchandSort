//
//  ViewController.swift
//  sort search segment
//
//  Created by dietskan on 11/16/16.
//  Copyright © 2016 random. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating{

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    let textCellidenifier = "Cell"
    
    var  meals = [Meal]()
    func loadSampleMeals()
    {
        
        
        let photo1 = UIImage(named:"BlueProfile")
        let meal1 = Meal(photo:photo1!, label1:"Breakfast", label2:"02/03/1985", label3:"11:27")
        
        let photo2 = UIImage(named:"RedProfile.png")
        let meal2 = Meal(photo:photo2!, label1:"Lunch", label2:"12/01/2025", label3:"3:35")
        
        let photo3 = UIImage(named:"GrayProfile.png")
        let meal3 = Meal(photo: photo3!, label1: "Dinner", label2: "07/08/1964", label3: "4:50")
        
        meals += [meal1,meal2,meal3]
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        configureSearchController()
        loadSampleMeals()
        
    }

    
    @IBAction func segmentedControl(_ sender: UISegmentedControl)
    {
        let index = segmentedControl.selectedSegmentIndex
        
        if(index == 1)
        {
            
            meals.sort(){$0.label1 > $1.label1}
            
            tableViewOutlet.reloadData()
        }
        else if(index == 2)
        {
            meals.sort(){$0.label2 > $1.label2}
            
            tableViewOutlet.reloadData()

        }
        else if(index == 3)
        {
            meals.sort(){$0.label3 > $1.label3}
            
            self.tableViewOutlet.reloadData()

        }
    }
    //define variables for holding data in each label of the prototype cell
        //We need an array to hold or access this struct
        
    //MARK:UiTableviewDataSource methods
    //to indicate how many sections the table view is going to be split into
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //to indicate number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(shouldshowsearchresults)
        {
            return filteredArray.count
            
        }
        else
        {
            return meals.count

        }

    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let mycustomcell = tableViewOutlet.dequeueReusableCell(withIdentifier: textCellidenifier, for: indexPath) as! CustomCellTableViewCell
        let candy:Meal
        if(shouldshowsearchresults)
        {
            candy = filteredArray[indexPath.row]
        }
        else{
        
       candy = meals[indexPath.row]
         }
 
    let meal = meals[indexPath.row]
        mycustomcell.lblprofile.image = candy.photo
        mycustomcell.lblsecondrow.text = candy.label1
        mycustomcell.lblthirdrow.text = candy.label2
        mycustomcell.lblfourthrow.text = candy.label3
        return mycustomcell
        
    }
    
    //MARK:UItableviewDelegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    
    
                 //MARK:Searchcontroller
    var filteredArray = [Meal]()
    var shouldshowsearchresults = false
    var searchController:UISearchController!
    
    func configureSearchController()
    {
        
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
         searchController.searchResultsUpdater = self
         searchController.dimsBackgroundDuringPresentation = false
         searchController.searchBar.placeholder = "Search here..."
         searchController.searchBar.delegate = self
         searchController.searchBar.sizeToFit()
         tableViewOutlet.tableHeaderView = searchController.searchBar
    }

    
    //functions of searchbardelegate to detect if a search is happenning
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    
        shouldshowsearchresults = true
        tableViewOutlet.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldshowsearchresults = false
        tableViewOutlet.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if(!shouldshowsearchresults)
        {
            shouldshowsearchresults = true
            tableViewOutlet.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    //uisearchresultsupdating protocol function to actually perform the search
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        
        filteredArray = meals.filter{candy in
           // let mealText: NSString = candy as NSString;
            return candy.label1.contains(searchString!)
        }
         
            //return mealText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location != NSNotFou
        
        tableViewOutlet.reloadData()
    }

}
