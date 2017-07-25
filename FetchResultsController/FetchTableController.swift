//
//  FetchTableController.swift
//  FetchResultsController
//
//  Created by Priyam Dutta on 17/02/17.
//  Copyright © 2017 Priyam Dutta. All rights reserved.
//

import UIKit
import CoreData

let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class FetchTableController: UITableView, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private var sortDescriptorPath: String?
    private var canCommitCellEditingStyle: Bool? = true
    var cell:((_ tableview: UITableView, _ indexPath: NSIndexPath, _ dataSource: AnyObject) -> (UITableViewCell))?
    private var fetchResultController: NSFetchedResultsController<NSFetchRequestResult>?
    private var entity: String? {
        didSet {
            do {
                try fetchResultController?.performFetch()
            }
            catch let error as NSError{
                debugPrint("Process Error: \(error.localizedDescription)")
            }
            self.delegate = self
            self.dataSource = self
        }
    }
    
    func configureFetchResultsController(entity: String!, sortDescriptorKeyPath: String!){
        self.setEditing(true, animated: true)
        self.sortDescriptorPath = sortDescriptorKeyPath
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PersonInfo.fetchRequestInfo() as! NSFetchRequest<NSFetchRequestResult>
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: self.sortDescriptorPath!, ascending: true)]
        let tempFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manageObjectContext, sectionNameKeyPath: nil, cacheName: "Root")
        tempFetchController.delegate = self
        fetchResultController = tempFetchController
        
        do {
            try fetchResultController?.performFetch()
        }
        catch let error as NSError
        {
            debugPrint("Process Error: \(error.localizedDescription)")
        }
        self.delegate = self
        self.dataSource = self
    }
    
    //MARK:- UITableViewDelegate and UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        if fetchResultController?.sections != nil {
            return (fetchResultController?.sections?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (fetchResultController?.sections?[0].numberOfObjects)! > 0 {
            return (fetchResultController?.sections![0].numberOfObjects)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return  self.cell!(tableView, indexPath as NSIndexPath, (fetchResultController?.object(at: indexPath))!)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manageObjectContext.delete(fetchResultController?.object(at: indexPath) as! NSManagedObject)
            do {
                try manageObjectContext.save()
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    //MARK:- NSFetchedResultsControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        debugPrint("Section: \(sectionInfo), at Index: \(sectionIndex)")
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.insertRows(at: [newIndexPath!], with: .fade)
        case .move:
            self.deleteRows(at: [indexPath!], with: .fade)
            self.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.reloadRows(at: [indexPath!], with: .fade)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
