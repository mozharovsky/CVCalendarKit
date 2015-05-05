//
//  CVCalendarKitExtensions.swift
//  CVCalendarKit
//
//  Created by Eugene Mozharovsky on 05/05/15.
//  Copyright (c) 2015 Dwive. All rights reserved.
//

import Foundation

/**
A wrapper around weekday raw value. The values match ones presented in NSCalendar.
*/
public enum Weekday: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

private let YearUnit = NSCalendarUnit.CalendarUnitYear
private let MonthUnit = NSCalendarUnit.CalendarUnitMonth
private let WeekUnit = NSCalendarUnit.CalendarUnitWeekOfMonth
private let WeekOfYearUnit = NSCalendarUnit.CalendarUnitWeekOfYear
private let WeekdayUnit = NSCalendarUnit.CalendarUnitWeekday
private let DayUnit = NSCalendarUnit.CalendarUnitDay
private let AllUnits = YearUnit | MonthUnit | WeekUnit | WeekOfYearUnit | WeekdayUnit | DayUnit

public extension NSCalendar {
    /**
    Returns the NSDateComponents instance for all main units.
    
    :param: Date The date for components construction.
    :returns: The NSDateComponents instance for all main units.
    */
    func allComponentsFromDate(date: NSDate) -> NSDateComponents {
        return components(AllUnits, fromDate: date)
    }
}


public extension NSDate {
    private typealias DateRange = (year: Int, month: Int, day: Int)
    
    /**
    Calculates the date values.
    
    :returns: A tuple with date year, month and day values.
    */
    private func dateRange() -> DateRange {
        let calendar = NSCalendar.currentCalendar()
        let comps = calendar.allComponentsFromDate(self)
        
        return (comps.year, comps.month, comps.day)
    }
    
    /**
    Current date weekday.
    */
    var weekday: Weekday {
        get {
            return Weekday(rawValue: NSCalendar.currentCalendar().allComponentsFromDate(self).weekday)!
        }
    }
    
    /**
    Date year.
    */
    var year: DateUnit {
        get {
            return .Year(self, dateRange().year)
        }
    }
    
    /**
    Date month.
    */
    var month: DateUnit {
        get {
            return .Month(self, dateRange().month)
        }
    }
    
    /**
    Date day.
    */
    var day: DateUnit {
        get {
            return .Day(self, dateRange().day)
        }
    }
    
    /**
    Returns the first date in the current date's month.
    
    :returns: The first date in the current date's month.
    */
    func firstMonthDate() -> NSDate {
        return (self.day == 1)
    }
    
    /**
    Returns the last date in the current date's month.
    
    :returns: The las date in the current date's month.
    */
    func lastMonthDate() -> NSDate {
        return ((firstMonthDate().month + 1).day - 1)
    }
    
    /**
    Returns the first date in the current date's year.
    
    :returns: The first date in the current date's year.
    */
    func firstYearDate() -> NSDate {
        return ((NSDate().month == 1).day == 1)
    }
    
    /**
    Returns the last date in the current date's year.
    
    :returns: The last date in the current date's year.
    */
    func lastYearDate() -> NSDate {
        return (((firstYearDate().month == 12).month + 1).day - 1)
    }
}