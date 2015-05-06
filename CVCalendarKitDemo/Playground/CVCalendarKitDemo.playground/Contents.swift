//: Playground - noun: a place where people can play

import UIKit

/// Current date.
let today = NSDate()

/// Day operations.
let tomorrow = today.day + 1
let yesterday = today.day - 1

/// Month operations.
let monthAhead = today.month + 1
let monthAgo = today.month - 1

/// Year operations.
let yearAhead = today.year + 1
let yearAgo = today.year - 1

/// Multiplication and Division.
let multipliedDate = today.day * 5
let dividedDate = today.month / 5

/// Trailing operations.
let dayAheadMonthAgo = (today.day + 1).month - 1
let yearAheadTwoMonthsAgoFiveDaysAhead = ((today.year + 1).month - 2).day + 5

/// NSDate comparison.
today == yesterday
today > yesterday
yesterday <= tomorrow
tomorrow != today

/// Convenience stuff.
let firstDateInCurrentMonth = today.firstMonthDate()
let lastDateInCurrentMonth = today.lastMonthDate()
let firstDateInCurrentYear = today.firstYearDate()
let lastDateInCurrentYear = today.lastYearDate()

/// Date construction by assigning values.
let customDate = ((today.day == 21).month == 5).year == 1997

/// Date unit values (year, month, day).
let todaysYear = today.year.value()
let todaysMonth = today.month.value()
let todaysDay = today.day.value()

/// NSDate+Weekday.
let todaysWeekday = today.weekday // Enum value.
let todaysWeekdayRaw = today.weekday.rawValue // Raw value.

/// Date description.
let date = (NSDate().month == 5).descriptionWithLocale(nil, format: .DDMMYY, style: nil)

/// Date from String (its description).
if let myDate = "May 21, 1997".date(.DDMMYY, style: .MediumStyle) {
    myDate
}