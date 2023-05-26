//
//  TodoHomeViewController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import UIKit

class TodoHomeViewController: UIViewController {

    @IBOutlet weak var todosTableView: UITableView!
    
    var todoModel: TodoModel?
    
    lazy var todoHomeController = {
        let controller = TodoHomeController(todoModel: todoModel ?? TodoModel())
        
        // TODO: Configure the controller
        controller.deleteAllTodos()
        //controller.generateSampleTodos()
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todosTableView.dataSource = todoHomeController
    }

}
