//
//  DataSaving.swift
//  news
//
//  Created by Macbook on 21.09.2022.
//

import UIKit
import CoreData

struct DataManager {
    
    func saveData(cell: NewsModel.Cell) {
        
        let backgroundContext: NSManagedObjectContext
        let mainContext: NSManagedObjectContext

        
        mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = mainContext
        
        //MARK: - getting old data
        
        let fetchRequest = NSFetchRequest<NewsItem>(entityName: "NewsItem")
        var items: [NewsItem]?
        mainContext.performAndWait {
            do {
                items = try mainContext.fetch(fetchRequest)
            } catch let error {
                print("Failed to fetch companies: \(error)")
            }
        }
        
        //MARK: - deleting old data
        
        if let items = items {
            for item in items {
                let objectID = item.objectID
                backgroundContext.performAndWait {
                    if let itemInContext = try? backgroundContext.existingObject(with: objectID) {
                        backgroundContext.delete(itemInContext)
                        try? backgroundContext.save()
                    }
                }
            }
        }
        
        //MARK: - saving data
        backgroundContext.performAndWait {
            let newItem = NSEntityDescription.insertNewObject(forEntityName: "NewsItem", into: backgroundContext) as! NewsItem
            
            newItem.author = cell.author
            newItem.date = cell.date
            newItem.title = cell.title
            newItem.text = cell.description
            var data: Data?
            if let urlString = cell.imageURL, let url = URL(string: urlString) {
                do {
                    data = try Data(contentsOf: url)
                    newItem.image = data
                } catch {
                    data = nil
                }
            }
            
            try? backgroundContext.save()
            print(newItem)
        }
        print("cell saved")
    }
    
    func loadingData() -> [NewsModel.Cell]? {
        
        let backgroundContext: NSManagedObjectContext
        let mainContext: NSManagedObjectContext

        
        mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = mainContext
        
        let fetchRequest = NSFetchRequest<NewsItem>(entityName: "NewsItem")
        
        var items: [NewsItem]?
        
        mainContext.performAndWait {
            do {
                items = try mainContext.fetch(fetchRequest)
            } catch let error {
                print("Failed to fetch companies: \(error)")
            }
        }
        
        let cells = items?.map({ item in
            NewsModel.Cell(author: item.author,
                           title: item.title,
                           description: item.text,
                           date: item.date,
                            url: nil,
                            imageURL: nil,
                           image: item.image)
        })
        return cells
    }
}
