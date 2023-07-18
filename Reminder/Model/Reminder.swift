//
//  Reminder.swift
//  Reminder
//
//  Created by Baris on 18.07.2023.
//

import Foundation

struct Reminder: Codable {
    //MARK: - Properties
    var id = UUID().uuidString
    var title: String
    var dueDate: Date?
    var isCompleted = false
}
