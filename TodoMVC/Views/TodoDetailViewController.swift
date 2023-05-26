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
    
    var update: TodoHandler = defaultTodoHandler
    
    lazy var todoDetailController: TodoDetailController = {
        let todoDetailController = TodoDetailController(self)
        
        //TODO: Configure todoDetailController
        if let todo = todo {
            todoDetailController.setup(todo: todo)
        }
        
        return todoDetailController
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var checkedLabel: UILabel!
    
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var updateAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Todo Details will appear")
        refresh()
    }
    
    func refresh() {
        print("Todo Detail refreshing...")
        
        todoDetailController.configureTitleLabel(titleLabel)
        todoDetailController.configureCheckLabel(checkedLabel)
        todoDetailController.configureCreateAtLabel(createdAtLabel)
        todoDetailController.configureUpdateAtLabel(updateAtLabel)
        
        if let todo = todo {
            update(todo)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let todoEditViewController = segue.destination as? TodoEditViewController {
            todoEditViewController.todo = todo
            todoEditViewController.complete = { todo in
                self.todoDetailController.setup(todo: todo)
                self.refresh()
            }
            todoEditViewController.delete = { todo in
                self.update(todo)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
