//
//  ItemStore.swift
//  Homepwner
//
//  Created by CSUFTitan on 4/5/20.
//  Copyright © 2020 Nancy Badillo. All rights reserved.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    
    init(){
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDictionay = documentsDirectories.first!
        return documentDictionay.appendingPathComponent("items.archive")
    }()
    
    // @discardableResult means that the a caller of the function is free to ignore the result of calling this function
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool{
        print("Saving items to: \(itemArchiveURL.path)")
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            return true
        } catch {
            print("Could not write file")
            return false
        }
    }
}
