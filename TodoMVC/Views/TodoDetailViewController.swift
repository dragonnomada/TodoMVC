//
//  TodoDetailViewController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import UIKit

class TodoDetailViewController: UIViewController {

    let todoModel: TodoModel = AppDelegate.sharedTodoModel
    
    var todo: TodoEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let todo = todo {
            print("TodoDetail for \(todo)")
        }
    }

}
