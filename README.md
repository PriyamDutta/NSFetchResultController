# NSFetchResultController
NSFetchResultController is widely used for listing the stored data using Core Data using NSFetchResultControllerDelegate.

# Usability
Configure NSFetchResultController with NSFetchRequest & NSManagedObjectContext

```
 let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PersonInfo.fetchRequestInfo() as! NSFetchRequest<NSFetchRequestResult>
 fetchRequest.sortDescriptors = [NSSortDescriptor(key: self.sortDescriptorPath!, ascending: true)]
 let tempFetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manageObjectContext, sectionNameKeyPath: nil, cacheName: "Root")
```

Use Delegates which will notify for the content change and hence update your table accordingly.
```
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
    
 ```
 
