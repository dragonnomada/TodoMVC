//
//  TodoHomeController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import UIKit

class TodoHomeController: NSObject {
    
    
    
}

extension TodoHomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section + 1) * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = "Section \(indexPath.section) \(indexPath.row)"
        
        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
    
}
