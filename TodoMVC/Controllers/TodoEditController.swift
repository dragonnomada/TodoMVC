//
//  TodoEditController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import UIKit

protocol TodoEditDelegate: AnyObject {
    
    func save(todo: TodoEntity)
    
    func update(todo: TodoEntity)
    
    func delete(todo: TodoEntity)
    
    func close()
    
}

class TodoEditController: NSObject {
    
    let todoModel = AppDelegate.sharedTodoModel
    
    let view: TodoEditDelegate
    
    var todo: TodoEntity?
    
    init(_ view: TodoEditDelegate) {
        self.view = view
    }
    
    func setup(todo: TodoEntity) {
        self.todo = todo
    }
    
    func initialize() {
        if let todo = todo {
            self.view.update(todo: todo)
        }
    }
    
    func configureTitleTextField(_ textField: UITextField) {
        guard let todo = todo
        else { return }
        
        textField.text = todo.title
    }
    
    func configureCheckedSwitch(_ checked: UISwitch) {
        guard let todo = todo
        else { return }
        
        checked.isOn = todo.checked
    }
    
    func save(title: String?, checked: Bool?) {
        guard let todo = todo
        else { return }
        
        todoModel.update(id: todo.id ?? UUID(), title: title, checked: checked) { todo in
            self.view.save(todo: todo)
            self.view.close()
        } error: { error in
            print(error)
        }
    }
    
    func delete() {
        guard let todo = todo
        else { return }
        
        todoModel.delete(id: todo.id ?? UUID()) { todo in
            self.view.delete(todo: todo)
            self.view.close()
        } error: { error in
            print(error)
        }
    }
    
}
