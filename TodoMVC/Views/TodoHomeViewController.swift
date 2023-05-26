//
//  TodoHomeViewController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import UIKit

class TodoHomeViewController: UIViewController {

    @IBOutlet weak var todosTableView: UITableView!
    
    lazy var todoHomeController = {
        let todoHomeController = TodoHomeController(self)
        
        // TODO: Configure todoHomeController
        //controller.deleteAllTodos()
        todoHomeController.generateSampleTodos()
        
        return todoHomeController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Home"

        todoHomeController.configureTableView(todosTableView)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todoDetailViewController = segue.destination as? TodoDetailViewController {
            if let todo = sender as? TodoEntity {
                todoDetailViewController.todo = todo
            }
        }
    }
    
}
