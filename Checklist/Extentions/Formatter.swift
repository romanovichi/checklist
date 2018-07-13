//
//  Formatter.swift
//  Checklist
//
//  Created by Иван Романович on 25.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation

extension Formatter {
    
    static func dateToString(fromDate date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
