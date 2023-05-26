//
//  TodoHomeController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import UIKit

class TodoHomeController: NSObject {
    
    let todoModel: TodoModel = AppDelegate.sharedTodoModel

    let view: UIViewController
    
    init(_ view: UIViewController) {
        self.view = view
    }
    
    func deleteAllTodos() {
        for todo in todoModel.todosUnchecked {
            todoModel.delete(id: todo.id ?? UUID())
        }
        
        for todo in todoModel.todosChecked {
            todoModel.delete(id: todo.id ?? UUID())
        }
    }
    
    func generateSampleTodos() {
        if todoModel.isEmpty {
            todoModel.add(title: "Hello 1")
            todoModel.add(title: "Hello 2")
            todoModel.add(title: "Hello 3") { todo in
                self.todoModel.update(id: todo.id ?? UUID(), title: nil, checked: true)
            }
            todoModel.add(title: "Hello 4") { todo in
                self.todoModel.update(id: todo.id ?? UUID(), title: nil, checked: true)
            }
        }
    }
    
}

extension TodoHomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var todo: TodoEntity? = nil
        
        if indexPath.section == 0 {
            todo = todoModel.todosUnchecked[indexPath.row]
        } else {
            todo = todoModel.todosChecked[indexPath.row]
        }
        
        if let todo = todo {
            view.performSegue(withIdentifier: "showTodoDetail", sender: todo)
        }
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
        if section == 0 {
            return todoModel.todosUnchecked.count
        }
        if section == 1 {
            return todoModel.todosChecked.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            let todo = todoModel.todosUnchecked[indexPath.row]
            contentConfiguration.text = "❌ \(todo.title ?? "<unknown>")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let date = dateFormatter.string(from: todo.updateAt ?? todo.createAt ?? Date())
            contentConfiguration.secondaryText = "\(date)"
        }
        if indexPath.section == 1 {
            let todo = todoModel.todosChecked[indexPath.row]
            contentConfiguration.text = "✅ \(todo.title ?? "<unknown>")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            let date = dateFormatter.string(from: todo.updateAt ?? todo.createAt ?? Date())
            contentConfiguration.secondaryText = "\(date)"
        }
        
        cell.contentConfiguration = contentConfiguration
        
        return cell
    }
    
}
