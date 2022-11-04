//
//  UserMO+CoreDataProperties.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-24.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var password: String
    @NSManaged public var login: String

}

extension UserMO : Identifiable {

}
