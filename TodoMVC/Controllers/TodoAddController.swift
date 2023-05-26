//
//  TodoAddController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 26/05/23.
//

import Foundation
import UIKit

protocol TodoAddDelegate: AnyObject {
    
    func add(todo: TodoEntity)
    
}

class TodoAddController: NSObject {
    
    let todoModel = AppDelegate.sharedTodoModel
    
    let view: TodoAddDelegate
    
    init(_ view: TodoAddDelegate) {
        self.view = view
    }
 
    func add(title: String) {
        print("Add new todo with title: \(title)")
        
        todoModel.add(title: title, success:  { todo in
            self.view.add(todo: todo)
        })
    }
    
}
