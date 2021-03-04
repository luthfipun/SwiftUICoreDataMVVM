//
//  PoepleViewModel.swift
//  SwiftUICoreData
//
//  Created by Luthfi Abdul Azis on 04/03/21.
//

import Foundation
import CoreData

class  PeopleViewModel: ObservableObject, Identifiable {
    
    let genders = ["Male", "Female"]
    
    var id: UUID = UUID()

    @Published var name: String = ""
    @Published var gender: Int = 0
    @Published var age: String = ""
    
    @Published var item: People!
    @Published var isUpdate: Bool = false
    
    func insertData(context: NSManagedObjectContext) {
        
        if item != nil {
            item.name = name
            item.gender = genders[gender]
            item.age = Int16(age) ?? 0
            
            try! context.save()
            refreshForm()
            return
        }
        
        
        let newItem = People(context: context)
        newItem.name = name
        newItem.gender = genders[gender]
        newItem.age = Int16(age) ?? 0
        newItem.id = id
        
        do {
            try context.save()
            refreshForm()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(context: NSManagedObjectContext, people: People){
        do {
            context.delete(people)
            try context.save()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func updateData(people: People){
        item = people
        name = people.name
        gender = genders.firstIndex(of: people.gender) ?? 0
        age = String(people.age)
        isUpdate = true
    }
    
    func refreshForm() {
        item = nil
        isUpdate = false
        name = ""
        gender = 0
        age = ""
        id = UUID()
    }
}
