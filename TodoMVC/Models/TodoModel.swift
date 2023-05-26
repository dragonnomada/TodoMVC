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

enum TodoModelError: Error {
    case todoNotFound(id: UUID)
}

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
    
    func get(id: UUID) -> TodoEntity? {
        return try? context.fetch(TodoEntity.fetchRequest()).first(where: { $0.id == id })
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
    
    func update(id: UUID, title: String?, checked: Bool?,
              success: @escaping TodoHandler = defaultTodoHandler,
              error: @escaping ErrorHandler = defaultErrorHandler) {
        guard let todo = get(id: id)
        else {
            error(TodoModelError.todoNotFound(id: id))
            return
        }
        
        if let title = title {
            todo.title = title
            todo.updated = Date()
        }
        
        if let checked = checked {
            todo.checked = checked
            todo.updated = Date()
        }
                
        if todo.hasChanges {
            save() {
                success(todo)
            } error: { localError in
                error(localError)
            }
        } else {
            success(todo)
        }
    }
    
    func delete(id: UUID,
                success: @escaping TodoHandler = defaultTodoHandler,
                error: @escaping ErrorHandler = defaultErrorHandler) {
        guard let todo = get(id: id)
        else {
            error(TodoModelError.todoNotFound(id: id))
            return
        }
        
        context.delete(todo)
                
        if context.hasChanges {
            save() {
                success(todo)
            } error: { localError in
                error(localError)
            }
        } else {
            success(todo)
        }
    }
    
}
