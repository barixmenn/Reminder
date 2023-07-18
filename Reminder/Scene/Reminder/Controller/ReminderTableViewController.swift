//
//  ReminderTableViewController.swift
//  Reminder
//
//  Created by Baris on 18.07.2023.
//

import UIKit

class ReminderTableViewController: UITableViewController {
    
    
    //MARK: - Properties
    var reminderManager = ReminderManager()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

// MARK: - Table view data source
extension ReminderTableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminderManager.getAllReminders().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as? ReminderTableViewCell else { return UITableViewCell() }
        
        let reminder = reminderManager.getAllReminders()[indexPath.row]
        cell.prepare(with: reminder)
        
        return cell
    }
    
    
    //  Soldan sağa doğru UITableViewCell objesini kaydırınca hatırlatıcıyı tamamlama aksiyonunu almak için leadingSwipeActionsConfigurationForRowAt fonksiyonunu kullanıyoruz.
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedReminder = reminderManager.getAllReminders()[indexPath.row]
        
        let completeAction = UIContextualAction(style: .normal, title: nil, handler: { (_, _, completion) in
            completion(true)
            
            self.reminderManager.setComplete(reminder: selectedReminder)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        })
        
        completeAction.image = selectedReminder.isCompleted ? UIImage(systemName: "minus.circle.fill") : UIImage(systemName: "checkmark.circle.fill")
        completeAction.backgroundColor = selectedReminder.isCompleted ? .lightGray : .orange
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    // Sağdan sola doğru UITableViewCell objesini kaydırınca hatırlatıcıyı tamamlayınca aksiyonu silmek için trailingSwipeActionsConfigurationForRowAt fonksiyonunu kullanıyoruz.
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let reminderToDelete = reminderManager.getAllReminders()[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (_, _, completed) in
            completed(true)
            self.reminderManager.delete(reminder: reminderToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
