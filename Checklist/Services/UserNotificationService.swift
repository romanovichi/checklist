//
//  UserNotificationService.swift
//  Checklist
//
//  Created by Иван Романович on 23.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    static func setNotification(withID id: String, Label text: String, AndDate date: Date, completion: @escaping (_ sucsess: Bool) -> ()) {
        
        let dateInfo: DateComponents = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: text, arguments: nil)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func removeNotification(withId id: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier == id {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            print("Deleted")
            
        }
    }
    
}
