//
//  ViewController.swift
//  FetchResultsController
//
//  Created by Priyam Dutta on 17/02/17.
//  Copyright © 2017 Priyam Dutta. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var primaryTable: UITableView!
    @IBOutlet var fetchTable: FetchTableController!
    
    private let titleArray = ["Ishit", "Arnab", "Kaushik", "Anmol", "Joydeep", "Kailash", "Suresh", "Asif", "Sunil", "Jaggu"]
    private let descriptionArray = ["Goa", "Cuba", "Israel", "Argentina", "USA", "Russia", "Singapore", "China", "Congo", "Japan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchTable.configureFetchResultsController(entity: "PersonInfo", sortDescriptorKeyPath: "name")
        fetchTable.cell = {(tableView, indexPath, data) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "fetchCell")
            
            (cell?.contentView.viewWithTag(1) as! UILabel).text = (data as! PersonInfo).name
            (cell?.contentView.viewWithTag(2) as! UILabel).text = (data as! PersonInfo).place
            
            return cell!
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        primaryTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UITableViewDatasource and UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let primaryCell = tableView.dequeueReusableCell(withIdentifier: "primaryCell")
        (primaryCell?.contentView.viewWithTag(1) as! UILabel).text = titleArray[indexPath.row]
        (primaryCell?.contentView.viewWithTag(2) as! UILabel).text = "from " + descriptionArray[indexPath.row]
        return primaryCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PersonInfo.insertPersonDetails(name: titleArray[indexPath.row], place: descriptionArray[indexPath.row])
    }
    
}

