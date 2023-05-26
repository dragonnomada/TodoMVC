//
//  TodoEditViewController.swift
//  TodoMVC
//
//  Created by Alan Badillo Salas on 25/05/23.
//

import UIKit

class TodoEditViewController: UIViewController {

    var todo: TodoEntity?
    
    lazy var todoEditController: TodoEditController = {
        let todoEditController = TodoEditController(self)
        
        //TODO: Configure todoEditController
        if let todo = todo {
            todoEditController.setup(todo: todo)
        }
        
        return todoEditController
    }()
    
    var complete: TodoHandler = defaultTodoHandler
    var delete: TodoHandler = defaultTodoHandler
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var checkedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todo Edit"
        
        todoEditController.initialize()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        todoEditController.save(title: titleTextField.text, checked: checkedSwitch.isOn)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        todoEditController.delete()
    }
    
}

extension TodoEditViewController: TodoEditDelegate {
    
    func save(todo: TodoEntity) {
        complete(todo)
    }
    
    func update(todo: TodoEntity) {
        todoEditController.configureTitleTextField(titleTextField)
        todoEditController.configureCheckedSwitch(checkedSwitch)
    }
    
    func delete(todo: TodoEntity) {
        print("TodoEditViewController Deleting...")
        self.delete(todo)
    }
    
    func close() {
        print("TodoEditViewController Closing...")
        self.dismiss(animated: true)
    }
    
}
