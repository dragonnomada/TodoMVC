//
//  TodoAddViewController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 26/05/23.
//

import UIKit

class TodoAddViewController: UIViewController {

    lazy var todoAddController: TodoAddController = {
        let todoAddController = TodoAddController(self)
        
        //TODO: Configure todoAddController
        
        return todoAddController
    }()
    
    var update: TodoHandler = defaultTodoHandler
    
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Add"
    }

    @IBAction func addAction(_ sender: Any) {
        print("Todo Add with title = \(titleTextField.text ?? "???")")
        
        guard let title = titleTextField.text
        else {
            //TODO: Alert
            return
        }
        
        guard !title.isEmpty
        else {
            //TODO: Alert
            return
        }
        
        todoAddController.add(title: title)
    }
    
}

extension TodoAddViewController: TodoAddDelegate {
    
    func add(todo: TodoEntity) {
        update(todo)
        self.dismiss(animated: true)
    }
    
}
