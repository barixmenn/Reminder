//
//  ReminderTableViewController.swift
//  Reminder
//
//  Created by Baris on 18.07.2023.
//

import UIKit

class ReminderTableViewController: UITableViewController {

    
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
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderTableViewCell
        cell.nameLabel.text = "İOS 17 ile ilgili tanışma videosu çek"
        cell.infoLabel.text = "18 Temmuz 2023 11:30"

        // Configure the cell...

        return cell
    }
    
}
