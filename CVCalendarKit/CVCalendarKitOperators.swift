//
//  CVCalendarKitOperators.swift
//  CVCalendarKit
//
//  Created by Eugene Mozharovsky on 05/05/15.
//  Copyright (c) 2015 Dwive. All rights reserved.
//

import Foundation

/**
An operating entity containing content information regarding its
owner. It's used in the date management for date construction and
comparison.

Each enum case is associated with a date and a value.
*/
public enum DateUnit {
    case Year(NSDate, Int)
    case Month(NSDate, Int)
    case Day(NSDate, Int)
    
    /**
    :returns: An associated value with a particular case.
    */
    func value() -> Int {
        switch self {
        case .Year(_, let x): return x
        case .Month(_, let x): return x
        case .Day(_, let x): return x
        }
    }
}

/**
A structure for marking an offset for a date. Used for date contruction.
*/
public struct Offset {
    var year: Int
    var month: Int
    var day: Int
}

// MARK: - Helper functions

private typealias DateOffset = (Offset, DateOperation) -> NSDate

/**
Constructs a date with the offset from the source date.

:param: date The given date for applying the offset.

:returns: A function for getting the date from the offset and the assignment operation.
*/
private func dateWithOffset(date: NSDate) -> DateOffset {
    let comps = NSCalendar.currentCalendar().allComponentsFromDate(date)
    return { offset, operation in
        comps.year = offset.year == 0 ? comps.year : operation(comps.year, offset.year)
        comps.month = offset.month == 0 ? comps.month : operation(comps.month, offset.month)
        comps.day = offset.day == 0 ? comps.day : operation(comps.day, offset.day)
        
        return NSCalendar.currentCalendar().dateFromComponents(comps)!
    }
}

private typealias DateOperation = (Int, Int) -> (Int)

/**
A bridge between construction function and the given options.

:param: dateUnit A date unit providing the necessary data.
:param: offset An offset for
*/
private func dateUnitOffset(dateUnit: DateUnit, offset: Int, operation: DateOperation) -> NSDate {
    let result: NSDate
    
    switch dateUnit {
    case .Year(let date, let value):
        result = dateWithOffset(date)(Offset(year: offset, month: 0, day: 0), operation)
    case .Month(let date, let value):
        result = dateWithOffset(date)(Offset(year: 0, month: offset, day: 0), operation)
    case .Day(let date, let value):
        result = dateWithOffset(date)(Offset(year: 0, month: 0, day: offset), operation)
    }
    
    return result
}

private typealias ComparisonOperation = (Int, Int) -> Bool
private typealias ResultMerge = (Bool, Bool, Bool) -> Bool
private typealias ComparisonResult = (NSDate, NSDate) -> Bool

/**
Compares dates via return closure.

:param: operation Comparison operation.
:param: resultMerge The way of merging the results.
:returns: A comparison function.
*/
private func compareWithOperation(operation: ComparisonOperation, resultMerge: ResultMerge) -> ComparisonResult {
    return { dateA, dateB in
        let resultA = operation(dateA.year.value(), dateB.year.value())
        let resultB = operation(dateA.month.value(), dateB.month.value())
        let resultC = operation(dateA.day.value(), dateB.day.value())
        
        return resultMerge(resultA, resultB, resultC)
    }
}

// MARK: - DateUnit operators overload

public func + (lhs: DateUnit, rhs: Int) -> NSDate {
    return dateUnitOffset(lhs, rhs, { x, y in x + y })
}

public func - (lhs: DateUnit, rhs: Int) -> NSDate {
    return dateUnitOffset(lhs, rhs, { x, y in x - y })
}

public func * (lhs: DateUnit, rhs: Int) -> NSDate {
    return dateUnitOffset(lhs, rhs, { x, y in x * y })
}

public func / (lhs: DateUnit, rhs: Int) -> NSDate {
    return dateUnitOffset(lhs, rhs, { x, y in x / y })
}

public func == (lhs: DateUnit, rhs: Int) -> NSDate {
    return dateUnitOffset(lhs, rhs, { _, y in y })
}

// MARK: - NSDate operators overload

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return compareWithOperation({ $0 == $1 }, { $0 && $1 && $2 })(lhs, rhs)
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return compareWithOperation({ $0 > $1 }, { $0 || $1 || $2 })(lhs, rhs)
}

public func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return compareWithOperation({ $0 > $1 || lhs == rhs }, { $0 || $1 || $2 })(lhs, rhs)
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return compareWithOperation({ $0 < $1 }, { $0 || $1 || $2 })(lhs, rhs)
}

public func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return compareWithOperation({ $0 < $1 || lhs == rhs }, { $0 || $1 || $2 })(lhs, rhs)
}

public func != (lhs: NSDate, rhs: NSDate) -> Bool {
    return !(lhs == rhs)
}