//
//  TodoDetailController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import UIKit

class TodoDetailController: NSObject {
    
    let todoModel = AppDelegate.sharedTodoModel
    
    var view: UIViewController
    
    var todo: TodoEntity?
    
    init(_ view: UIViewController) {
        self.view = view
    }
    
    func setup(todo: TodoEntity) {
        self.todo = todo
    }
    
    func configureTitleLabel(_ label: UILabel) {
        guard let todo = todo
        else {
            label.text = "Unknown"
            return
        }
        
        label.text = todo.title
    }
    
    func configureCheckLabel(_ label: UILabel) {
        guard let todo = todo
        else {
            label.text = "⚠️"
            return
        }
        
        label.text = todo.checked ? "✅" : "❌"
    }
    
    func configureCreateAtLabel(_ label: UILabel) {
        guard let todo = todo
        else {
            label.text = "Created at: ?"
            return
        }
        
        if let date = todo.createAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            label.text = "Create at: \(dateFormatter.string(from: date))"
        } else {
            label.text = "Create at: ⌛️"
        }
    }
    
    func configureUpdateAtLabel(_ label: UILabel) {
        guard let todo = todo
        else {
            label.text = "Update at: ?"
            return
        }
        
        if let date = todo.updateAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            label.text = "Update at: \(dateFormatter.string(from: date))"
        } else {
            label.text = "Update at: ⌛️"
        }
    }
    
}
