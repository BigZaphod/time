//
//  Clock.swift
//  Chronology
//
//  Created by Dave DeLong on 11/22/17.
//

import Foundation

public struct Clock {
    
    public static let system = Clock()
    
    private let impl: ClockImplementation
    
    public init() {
        impl = SystemClock()
    }
    
    public init(referenceDate: Date, rate: Double = 1.0) {
        guard rate > 0.0 else { fatalError("Clocks can only count forwards") }
        impl = CustomClock(referenceDate: referenceDate, rate: rate)
    }
    
    public func thisInstant() -> Date {
        return impl.now()
    }
}


