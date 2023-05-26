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
        //todoHomeController.deleteAllTodos()
        //todoHomeController.generateSampleTodos()
        
        return todoHomeController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Home"
        
        refresh()
    }
    
    func refresh() {
        todoHomeController.configureTableView(todosTableView)
        todosTableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todoDetailViewController = segue.destination as? TodoDetailViewController {
            if let todo = sender as? TodoEntity {
                todoDetailViewController.todo = todo
                todoDetailViewController.update = { todo in
                    print("Todo Detail is updating...")
                    self.refresh()
                }
            }
        }
        
        if let todoAddViewController = segue.destination as? TodoAddViewController {
            todoAddViewController.update = {_ in
                self.refresh()
            }
        }
    }
    
}
