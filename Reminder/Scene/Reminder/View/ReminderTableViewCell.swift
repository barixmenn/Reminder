//
//  ReminderTableViewCell.swift
//  Reminder
//
//  Created by Baris on 18.07.2023.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    //MARK: - UI Elements
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Functions
    func prepare(with reminder: Reminder) {
        nameLabel.text = reminder.title
        tagView.backgroundColor = reminder.isCompleted ? .orange : .lightGray
        
        if let dueDate = reminder.dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "tr")
            infoLabel.text = dateFormatter.string(from: dueDate)
        } else {
            infoLabel.text = nil
        }
    }
}
