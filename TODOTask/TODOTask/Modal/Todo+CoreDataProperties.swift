//
//  Todo+CoreDataProperties.swift
//  TODOTask
//
//  Created by Mac on 27/10/1940 Saka.
//  Copyright © 1940 Mac. All rights reserved.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var note: String?

}



