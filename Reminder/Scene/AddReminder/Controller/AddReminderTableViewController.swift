//
//  AddReminderTableViewController.swift
//  Reminder
//
//  Created by Baris on 18.07.2023.
//

import UIKit

class AddReminderTableViewController: UITableViewController {
    
    //MARK: - UI Elements
    @IBOutlet weak var reminderLabel: UILabel!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var reminderTextField: UITextField!
    
    //MARK: - Properties
    var reminder: Reminder?
    let reminderManger = ReminderManager()
    
    let dateLabelCellIndexPath = IndexPath(row: 1, section: 1)
    let datePickerCellIndexPath = IndexPath(row: 2, section: 1)
    
    var isDatePickerShown = false
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerSettings()
        updateDateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reminderTextField.becomeFirstResponder()
    }
    
    
    
    
    //MARK: - Actions
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        var dueDate: Date?
            
            if reminderSwitch.isOn {
                dueDate = reminderDatePicker.date
            }
            
            let newReminder = Reminder(title: reminderTextField.text!, dueDate: dueDate)
            
            reminderManger.create(reminder: newReminder)
            performSegue(withIdentifier: "unwindToReminders", sender: nil)
    }
    @IBAction func cancelButtonClicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDateView()
    }
    @IBAction func reminderSwitchChanged(_ sender: UISwitch) {
        if !sender.isOn {
                isDatePickerShown = false
            }
            
            updateCells()
    }
    
  
}


//MARK: - Helpers
extension AddReminderTableViewController {
    private func updateDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        
        reminderLabel.text = dateFormatter.string(from: reminderDatePicker.date)
    }
    
    private func datePickerSettings() {
        var dateComponents = DateComponents()
        dateComponents.setValue(2, for: .minute)
        
        reminderDatePicker.minimumDate = Calendar.current.date(byAdding: dateComponents, to: Date())!
    }
    
    func updateCells() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}



// MARK: - Table view data source

extension AddReminderTableViewController {
        
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dateLabelCellIndexPath:
            if reminderSwitch.isOn {
                return 44
            } else {
                return 0
            }
            
        case datePickerCellIndexPath:
            if isDatePickerShown && reminderSwitch.isOn {
                return 216
            } else {
                return 0
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == dateLabelCellIndexPath {
            isDatePickerShown.toggle()
            updateCells()
        }
    }
}
