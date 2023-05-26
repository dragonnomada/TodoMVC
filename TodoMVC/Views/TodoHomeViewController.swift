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
        let controller = TodoHomeController(self)
        
        // TODO: Configure the controller
        //controller.deleteAllTodos()
        controller.generateSampleTodos()
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Home"

        todosTableView.dataSource = todoHomeController
        todosTableView.delegate = todoHomeController
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todoDetailViewController = segue.destination as? TodoDetailViewController {
            if let todo = sender as? TodoEntity {
                todoDetailViewController.todo = todo
            }
        }
    }
    
}
