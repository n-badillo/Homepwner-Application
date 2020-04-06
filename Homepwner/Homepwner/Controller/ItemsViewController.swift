//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by CSUFTitan on 4/5/20.
//  Copyright © 2020 Nancy Badillo. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController{
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
}
