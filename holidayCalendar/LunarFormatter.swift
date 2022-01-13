//
//  LunarFormatter.swift
//  FSCalendarSwiftExample
//
//  Created by Wenchao Ding on 25/07/2017.
//  Copyright © 2017 wenchao. All rights reserved.
//

import UIKit

open class LunarFormatter: NSObject {
    
    fileprivate let chineseCalendar = Calendar(identifier: .chinese)
    fileprivate let formatter = DateFormatter()
    fileprivate let lunarDays = ["初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"]
    fileprivate let lunarMonths = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
    
    
    override init() {
        self.formatter.calendar = self.chineseCalendar
        self.formatter.dateFormat = "M"
    }
    
    open func string(from date: Date) -> String {
        let day = self.chineseCalendar.component(.day, from: date)
        if day != 1 {
            return self.lunarDays[day-2]
        }
        // First day of month
        let monthString = self.formatter.string(from: date)
        if self.chineseCalendar.veryShortMonthSymbols.contains(monthString) {
            if let month = Int(monthString) {
                return self.lunarMonths[month-1]
            }
            return ""
        }
        // Leap month
        let month = self.chineseCalendar.component(.month, from: date)
        return "闰" + self.lunarMonths[month-1]
    }
    
}
