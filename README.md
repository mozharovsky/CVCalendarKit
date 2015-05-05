
![](https://raw.githubusercontent.com/Mozharovsky/CVCalendarKit/9364bf1f7b7f70a632f5b57e2bbb7b9f85500109/Assets/CVCalendarKit.png)

CVCalendarKit is a wrapper around NSDate which provides a convenience way for dealing with dates through overloaded operators and extensions.

## Features

Currently available features. 

* DateUnit operations (year, month, day) – multiplication, division, addition, subtraction
* Trailing operations 
* NSDate comparison 
* NSDate convenience stuff 
* Date construction with custom values 
* Date unit values 
* Weekdays 

Further changes. 

- [ ] NSCalendar wrapper 
- [ ] Simplifyig the process of working with events
- [ ] Reading/Writing calendar data

## Setup 

<h4>Requirements.</h4>
* Swift 1.2 
* iOS 7 or higher

<h4>CocoaPods.</h4>

// TODO. 

<h4>Manual setup.</h4>

Download CVCalendarKit project source code and add <b>CVCalendarKit</b> folder into your target (copy if needed).
## Usage 

Using <b>CVCalendarKit</b> is extremely easy and intuitive. All you need is an instance of a NSDate. 

```swift
/// Current date.
let today = NSDate()
```

Now you can use addition and substraction on a <b>DateUnit</b>. 
```swift
/// Day operations.
let tomorrow = today.day + 1
let yesterday = today.day - 1

/// Month operations.
let monthAhead = today.month + 1
let monthAgo = today.month - 1

/// Year operations.
let yearAhead = today.year + 1
let yearAgo = today.year - 1
```

Or even crazier operations!
```swift
/// Multiplication and Division.
let multipliedDate = today.day * 5
let dividedDate = today.month / 5
```

You can get really difficult calculations with trailing.
```swift
/// Trailing operations. 
let dayAheadMonthAgo = (today.day + 1).month - 1
let yearAheadTwoMonthsAgoFiveDaysAhead = ((today.year + 1).month - 1).day + 5
```

Do you need to compare NSDate instances? Here you go!
```swift
/// NSDate comparison. 
today == yesterday
today > yesterday
yesterday <= tomorrow
tomorrow != today
```

You can also get the first/last date in your date's month/year.
```swift
/// Convenience stuff. 
let firstDateInCurrentMonth = today.firstMonthDate()
let lastDateInCurrentMonth = today.lastMonthDate()
let firstDateInCurrentYear = today.firstYearDate()
let lastDateInCurrentYear = today.lastYearDate()
```

Custom date can be constructed using `==` overloaded operator on NSDate objects. 
```swift
/// Date construction by assigning values. 
let customDate = ((today.day == 21).month == 5).year == 1997
```

Accessing date units' values.
```swift
/// Date unit values (year, month, day). 
let todaysYear = today.year.value()
let todaysMonth = today.month.value()
let todaysDay = today.day.value()
```

And getting weekday enum/raw value. 
```swift
/// NSDate+Weekday.
let todaysWeekday = today.weekday // Enum value. 
let todaysWeekdayRaw = today.weekday.rawValue // Raw value.
```

## Acknowledgments

* Author [Eugene Mozharovsky](https://github.com/Mozharovsky)
* Inspired by [Timepiece](https://github.com/naoty/Timepiece) and [SwiftMoment](https://github.com/akosma/SwiftMoment)

## License 

CVCalendarKit is released under the MIT license. For more information see the [LICENSE](https://github.com/Mozharovsky/CVCalendarKit/blob/master/LICENSE) file. 
