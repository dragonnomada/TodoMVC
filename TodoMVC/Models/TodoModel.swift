//
//  TodoModel.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import CoreData

typealias Handler = () -> Void
typealias ErrorHandler = (Error) -> Void
typealias TodoHandler = (TodoEntity) -> Void

let defaultHandler: Handler = {}
let defaultErrorHandler: ErrorHandler = {_ in }
let defaultTodoHandler: TodoHandler = {_ in }

class TodoModel {
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoMVC")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error while loading container TodoMVC\n\(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext { container.viewContext }
    
    func save(completion: @escaping Handler = defaultHandler,
              error: @escaping ErrorHandler = defaultErrorHandler) {
        do {
            try context.save()
            completion()
        } catch let localError {
            context.rollback()
            error(localError)
        }
    }
    
    func add(title: String,
             success: @escaping TodoHandler = defaultTodoHandler,
             error: @escaping ErrorHandler = defaultErrorHandler) {
        let todo = TodoEntity(context: context)
        
        todo.id = UUID()
        
        todo.title = title
        todo.checked = false
        todo.created = Date()
        
        save() {
            success(todo)
        } error: { localError in
            error(localError)
        }
    }
    
}
