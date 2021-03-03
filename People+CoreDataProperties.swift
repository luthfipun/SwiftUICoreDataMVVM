//
//  People+CoreDataProperties.swift
//  SwiftUICoreData
//
//  Created by Luthfi Abdul Azis on 04/03/21.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var gender: String
    @NSManaged public var age: Int16
    
    var genderPeople: Gender {
        set {
            gender = newValue.rawValue
        }
        
        get {
            Gender(rawValue: gender) ?? .male
        }
    }

}

extension People : Identifiable {

}

enum Gender: String {
    case male = "Male"
    case female = "Female"
}
