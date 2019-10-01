//
//  CalendaringSystem.swift
//  Chronology
//
//  Created by Dave DeLong on 2/21/18.
//

import Foundation

public enum CalendarUnit {
    case era
    case year
    case month
    case day
    case hour
    case minute
    case second
    case nanosecond
}

public typealias Components = Dictionary<CalendarUnit, Int>

public protocol CalendaringSystem {
    
    var identifier: String { get }
    
    /// Different calendars may have different definitions of what a "second" is.
    /// For example, on Earth, calendars all have the convention that one calendar-second
    /// is the same as one SI Second. However, on Mars, the days are slightly longer,
    /// which means that dividing the slightly-longer day in to 86,400 slices results
    /// in "seconds" that are slightly longer than Earth seconds.
    /// Therefore, to accomodate this, the calendar needs to define how many
    /// SI Seconds are in each calendar-second.
    /// note: This does NOT affect how physics calculations are done (or velocities, etc)
    /// because those are all defined relative to SI Seconds
    var SISecondsPerSecond: Double { get }
    
    func instant(matching components: Components, in timeZone: TimeZone) -> Instant?
    
    func add<C: CalendarValue>(components: Components, to value: C, overflowToLargerUnits: Bool) -> C?
    
    func components(_ components: Set<CalendarUnit>, from instant: Instant, in timeZone: TimeZone) -> Components
    
    func isDateInWeekend<A: Anchored & YearMonthDayFields>(_ instant: A) -> Bool
    
    func range(of unit: CalendarUnit, containing instant: Instant) -> ClosedRange<Instant>
    
}
