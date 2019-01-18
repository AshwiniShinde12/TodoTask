//
//  DatabaseHelper.swift
//  TODOTask
//
//  Created by Mac on 27/10/1940 Saka.
//  Copyright © 1940 Mac. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DatabaseHelper {
    static var shareInstant = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate) .persistentContainer.viewContext
    
    
    func  saveData(object:[String:String]) {
        let  todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! Todo
        todo.title = object["title"]
        todo.note = object["note"]
        todo.date = object["date"]
        do
        {
            try context.save()
            print("data Save")
        }catch{
            print("data Not Save")
        }
    }
    
    func getTodoData() -> [Todo] {
        
        var todo = [Todo]()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Todo")
        do{
            todo = try context.fetch(fetchRequest) as! [Todo]
            print("Data Fetch Successfully")
        } catch{
            print("Data Not Fetch Successfully")
        }
        return todo
    }
    
    func deleteData(index: Int) -> [Todo] {
        var todo = getTodoData()
        context.delete(todo[index])
        todo.remove(at:index)
        do{
            try  context.save()
            print("data deleted ")
        }
        catch{
            print("data not deleted ")
        }
        return todo
    }
    
    func editData(object:[String:String], index: Int)  {
        var todo = getTodoData()
        todo[index].title = object["title"]
        todo[index].note = object["note"]
        todo[index].date = object["date"]
        do
        {
            try context.save()
            print("data update Successfully")
        }catch
        {
            print("data is not save")
        }
    }
}

