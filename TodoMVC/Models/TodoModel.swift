//
//  TodoModel.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import Foundation
import CoreData

public typealias Handler = () -> Void
public typealias ErrorHandler = (Error) -> Void
public typealias TodoHandler = (TodoEntity) -> Void

public let defaultHandler: Handler = {}
public let defaultErrorHandler: ErrorHandler = {_ in }
public let defaultTodoHandler: TodoHandler = {_ in }

public enum TodoModelError: Error {
    case todoNotFound(id: UUID)
}

public class TodoModel {
    
    lazy private var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoMVC")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error while loading container TodoMVC\n\(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext { container.viewContext }
    
    public var isEmpty: Bool {
        (try? context.fetch(TodoEntity.fetchRequest()))?.isEmpty ?? true
    }
    
    public var todos: [TodoEntity] {
        (try? context.fetch(TodoEntity.fetchRequest())) ?? []
    }
    
    public var todosChecked: [TodoEntity] {
        (try? context.fetch(TodoEntity.fetchRequest()).filter({$0.checked == true})) ?? []
    }
    
    public var todosUnchecked: [TodoEntity] {
        (try? context.fetch(TodoEntity.fetchRequest()).filter({$0.checked == false})) ?? []
    }
    
    private func save(completion: @escaping Handler = defaultHandler,
              error: @escaping ErrorHandler = defaultErrorHandler) {
        do {
            try context.save()
            completion()
        } catch let localError {
            context.rollback()
            error(localError)
        }
    }
    
    public func get(id: UUID) -> TodoEntity? {
        return try? context.fetch(TodoEntity.fetchRequest()).first(where: { $0.id == id })
    }
    
    public func add(title: String,
             success: @escaping TodoHandler = defaultTodoHandler,
             error: @escaping ErrorHandler = defaultErrorHandler) {
        let todo = TodoEntity(context: context)
        
        todo.id = UUID()
        
        todo.title = title
        todo.checked = false
        todo.createAt = Date()
        
        save() {
            success(todo)
        } error: { localError in
            error(localError)
        }
    }
    
    public func update(id: UUID, title: String?, checked: Bool?,
              success: @escaping TodoHandler = defaultTodoHandler,
              error: @escaping ErrorHandler = defaultErrorHandler) {
        guard let todo = get(id: id)
        else {
            error(TodoModelError.todoNotFound(id: id))
            return
        }
        
        if let title = title {
            todo.title = title
            todo.updateAt = Date()
        }
        
        if let checked = checked {
            todo.checked = checked
            todo.updateAt = Date()
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
    
    public func delete(id: UUID,
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
