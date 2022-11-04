//
//  NoteMO+CoreDataProperties.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-03.
//
//

import Foundation
import CoreData


extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "NoteMO")
    }

    @NSManaged public var content: String
    @NSManaged public var time: Date
    @NSManaged public var date: Date

}

extension NoteMO : Identifiable {

}
