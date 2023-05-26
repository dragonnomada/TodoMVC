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

        todoDetailController.configureTitleLabel(titleLabel)
        todoDetailController.configureCheckLabel(checkedLabel)
        todoDetailController.configureCreateAtLabel(createdAtLabel)
        todoDetailController.configureUpdateAtLabel(updateAtLabel)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
