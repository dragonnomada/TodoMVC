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
        let controller = TodoHomeController()
        
        // TODO: Configure the controller
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        todosTableView.dataSource = todoHomeController
    }

}
