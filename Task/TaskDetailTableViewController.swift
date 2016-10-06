//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Caleb Hicks on 10/20/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var task: Task?
    
    var dueDateValue: Date?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskDueTextField.inputView = dueDatePicker
        
        if let task = task {
            updateWithTask(task)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        updateTask()
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        let _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        self.taskDueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }

    @IBAction func userTappedView(_ sender: AnyObject) {
        
        self.taskNameTextField.resignFirstResponder()
        self.taskDueTextField.resignFirstResponder()
        self.taskNotesTextView.resignFirstResponder()
    }

    func updateTask() {
        
        guard let name = taskNameTextField.text else {return}
        let due = dueDateValue
        let notes = taskNotesTextView.text
        
        if let task = self.task {
            TaskController.sharedController.updateTask(task, name: name, notes: notes, due: due)
        } else {
            TaskController.sharedController.addTask(name, notes: notes, due: due)
        }
    }
    
    func updateWithTask(_ task: Task) {
        self.task = task
        
        title = task.name
        taskNameTextField.text = task.name
        
        if let due = task.due {
            taskDueTextField.text = due.stringValue()
        }
        
        if let notes = task.notes {
            taskNotesTextView.text = notes
        }

    }

}
