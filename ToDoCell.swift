//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Meera Patel on 4/16/22.
//

import UIKit

func updateSaveButtonState() {
    let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
    saveButton.isEnabled = shouldEnableSaveButton
}



@IBAction func textEditingChanged(_ sender: UITextField) {
    updateSaveButtonState()
}



@IBAction func returnPressed(_ sender: UITextField) {
    sender.resignFirstResponder()
}

@IBAction func isCompleteButtonTapped(_ sender: UIButton) {
    isCompleteButton.isSelected.toggle()
}

func checkmarkTapped(sender: ToDoCell) {
    if let indexPath = tableView.indexPath(for: sender) {
        var todo = todos[indexPath.row]
        todo.isComplete.toggle()
        todos[indexPath.row] = todo
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


@IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveUnwind" else { return }
    let sourceViewController = segue.source as! ToDoDetailTableViewController

    if let todo = sourceViewController.todo {
        if let indexOfExistingToDo = todos.firstIndex(of: todo) {
            todos[indexOfExistingToDo] = todo
            tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    ToDo.saveToDos(todos)
}




