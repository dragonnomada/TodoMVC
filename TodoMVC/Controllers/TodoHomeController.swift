//
//  TodoHomeController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import UIKit

class TodoHomeController: NSObject {
    
    let todoModel: TodoModel
    
    var checkedTodos: [TodoEntity] {
        todoModel.
    }
    
    init(todoModel: TodoModel) {
        self.todoModel = todoModel
    }
    
}

extension TodoHomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Unchecked Todos"
        }
        if section == 1 {
            return "Checked Todos"
        }
        
        return "Unknown"
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
