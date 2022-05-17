//
//  Favourite+CoreDataProperties.swift
//  MAP523_FinalAssignment
//
//  Created by Newman Law on 2022-04-19.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var name: String?
    @NSManaged public var population: Int64

}

extension Favourite : Identifiable {

}
