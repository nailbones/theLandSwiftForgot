//
//  MathExtensions.swift
//  A bunch of missing extensions for CG primitives for doing graphics and maths
//  Extensions
//
//  Created by nailbones on 7-5-16.
//  Copyright © 2018 nailbones. All rights reserved.
//

import UIKit

//MARK: - CGFloat properties
extension CGFloat {
    
    /// Converts radians to degrees
    /// - Returns: CGFloat as degrees
    var degrees: CGFloat {
        return self * (180 / .pi)
    }

    /// Converts degrees to radians
    /// - Returns: CGFloat as radians
    var radians: CGFloat {
        return (.pi * self) / 180
    }
    
}

//MARK: - CGFloat functions
extension CGFloat {
    /// Calculates the length of an arc given radius, start and end radians
    /// - Parameters:
    ///     - startRadians: The beginning of the arc
    ///     - endRadians:   The end of the arc
    ///     - radius:       Radius of the arc
    /// - Returns: Length of the arc
    static func arcLength(startRadians: CGFloat, endRadians: CGFloat, radius: CGFloat) -> CGFloat {
        let start = startRadians.degrees
        let end = endRadians.degrees
        return arcLength(startAngle: start,
            endAngle: end,
            radius: radius)
    }
    
    /// Calculates the length of an arc given radius, start and end degrees
    /// - Parameters:
    ///     - startAngle: The beginning of the arc in degrees
    ///     - endAngle:   The end of the arc in degrees
    ///     - radius:     Radius of the arc
    /// - Returns: Length of the arc
    static func arcLength(startAngle: CGFloat, endAngle: CGFloat, radius: CGFloat) -> CGFloat
    {
        let angle = startAngle - endAngle
        return fabs(2 * .pi * radius) * (angle / 360)
    }
    
    /// Calculates the radians (from zero) from the length of an arc
    /// - Parameters:
    ///     - length: Length of the arc
    ///     - radius: Radius of the arc
    /// - Returns: Radians
    static func radiansFromLength(length: CGFloat, radius: CGFloat) -> CGFloat
    {
        return length / radius
    }
   
    /// Checks for equality between two CGFloats where equals when difference is less than epsilon
    /// - Parameters:
    ///     - a, b: CGFloats to compare
    ///     - epsilon: The difference under which equality is determined
    /// - Returns: Bool
    static func fuzzyEquals(_ a: CGFloat,_ b:CGFloat, epsilon: CGFloat = 0.01) -> Bool {
        let absA = abs(a)
        let absB = abs(b)
        let diff = abs(a - b)
        let minVal: CGFloat = 0.0000000000001
        
        if (a == b) {
            return true
        }
        else if (a == 0 || b == 0 || diff < minVal) {
            return diff < (epsilon * minVal)
        } else {
            return diff / (absA + absB) < epsilon
        }
    }
}

//MARK: - CGPoint Properties
extension CGPoint {
    /// Length of this point
    /// - Returns: Length of the point
    var length: CGFloat {
        return sqrt(CGPoint.dotOfPoints(self, self))
    }
    
    /// Normalized version of this point
    /// - Returns: Normalized version of this point
    var normalizePoint: CGPoint {
        return self * (1 / self.length)
    }
    
    /// Absolute of the point
    /// - Returns: Absolute CGPoint
    var absPoint: CGPoint {
        return CGPoint(x: abs(x), y: abs(y))
    }
    
    /// Rounds points
    /// - Returns: Rounds CGPoint
    var rounded: CGPoint {
        return CGPoint(x: round(x), y: round(y))
    }
}

//MARK: - CGPoint Functions
extension CGPoint {
    
    /// Calculates a point from the center of an arc at angle n
    /// - Parameters:
    ///     - radians: Radians from zero
    ///     - radius:  Radius of arc (distance from center)
    /// - Returns: Point
    static func pointOnArc(radians: CGFloat, radius: CGFloat) -> CGPoint {
        let x = cos(radians) * radius
        let y = sin(radians) * radius
        return CGPoint(x: x, y: y)
    }
    
    /// Calulates the angle between points
    /// - Parameters:
    ///     - center: The center point to evaluate against target
    ///     - target: Point to evaluate against center for angle
    /// - Returns: Angle as radians
    static func radiansFromPoints(_ start: CGPoint, _ end: CGPoint) -> CGFloat {
        let deltaY = end.y - start.y
        let deltaX = end.x - start.x
        return atan2(deltaY, deltaX)
    }

    /// Checks for equality between two CGPoints where equals when difference is less than epsilon
    /// - Parameters:
    ///     - a, b: CGPoints to compare
    ///     - epsilon: The difference under which equality is determined
    /// - Returns: Bool
    static func fuzzyEquals(_ firstPoint: CGPoint, _ secondPoint: CGPoint, epsilon: CGFloat) -> Bool {
        return CGFloat.fuzzyEquals(firstPoint.x, secondPoint.x, epsilon: epsilon) &&
            CGFloat.fuzzyEquals(firstPoint.y, secondPoint.y, epsilon: epsilon)
    }
    
    /// Subtracts CGPoints
    /// - Parameters:
    ///     - a, b: CGPoints to subtract
    /// - Returns: CGPoint
    static func -(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        return CGPoint(x: a.x - b.x, y: a.y - b.y)
    }
    
    /// Adds CGPoints
    /// - Parameters:
    ///     - a, b: CGPoints to add
    /// - Returns: CGPoint
    static func +(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        return CGPoint(x: a.x + b.x, y: a.y + b.y)
    }
    
    /// Multiply point by n
    /// - Parameters:
    ///     - multiplicand: The number to multiply point by
    /// - Returns: CGPoint
    static func *(_ a: CGPoint, _ multiplicand: CGFloat) -> CGPoint {
        return CGPoint(x: a.x * multiplicand, y: a.y * multiplicand)
    }

    /// Divide point by n
    /// - Parameters:
    ///     - divisor: The number to divide point by
    /// - Returns: CGPoint
    static func /(_ a: CGPoint, _ divisor: CGFloat) -> CGPoint {
        return CGPoint(x: a.x / divisor, y: a.y / divisor)
    }

    
    /// Calculate midpoint between two points
    /// - Parameters:
    ///     - a,b: CGPoints to extrapolate midpoint
    /// - Returns: CGPoint
    static func midPoint(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        return (a + b) * 0.5
    }
    
    /// Dot of two points
    /// - Returns: dot (CGFloat) of two points
    static func dotOfPoints(_ a: CGPoint,_ b: CGPoint) -> CGFloat {
        return a.x * b.x + a.y * b.y
    }
    
    /// Projection of two points
    /// - Parameters:
    ///     - a,b: CGPoints
    /// - Returns: CGPoint projection of these points
    static func projection(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        return  b * (dotOfPoints(a, b) / dotOfPoints(b, b))
    }
    
    /// Calculates location of a point from the passed in point.
    /// Convenience method for getting a distant point then adding it
    /// - Parameters:
    ///     - from: CGPoint to use as the "pivot" point
    ///     - length: Distance from the from point
    ///     - angle: Angle from from point
    /// - Returns: CGPoint
    static func distantpoint(from: CGPoint, length: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint.distantPointWithRadians(from: from, length: length, radians: angle.radians)
    }
    
    /// Calculates location of a point from the passed in point.
    /// Convenience method for getting a distant point then adding it
    /// - Parameters:
    ///     - from: CGPoint to use as the "pivot" point
    ///     - length: Distance from the from point
    ///     - radians: Radians from from point
    /// - Returns: CGPoint
    static func distantPointWithRadians(from: CGPoint, length: CGFloat, radians: CGFloat) -> CGPoint {
        let displacedPoint = CGPoint.pointOnArc(radians: radians, radius: length)
        return from + displacedPoint
    }
    
    /// Calculates distance between points
    /// - Parameters:
    ///     - otherPoint: Other point
    /// - Returns: CGFloat distance between points
    func distanceToPoint(_ otherPoint: CGPoint) -> CGFloat {
        return sqrt(pow((otherPoint.x - x), 2)+pow((otherPoint.y - y), 2))
    }
    
    /// Given the length of the adjacent and opposite sides,
    /// calcualtes the length of the hypotenuse and the two angles
    /// - Parameters:
    ///     - adjacentLength: Length of the adjacent side
    ///     - oppositeLength: Length of the opposite side
    /// - Returns:
    ///     - adjacentAngle: CGFloat of the angle connecting the adjacent and hypotenuse
    ///     - oppositeAngle: CGFloat of the angle connecting the opposite and hypotenuse
    ///     - hypotenuse: Length of the hypotenuse
    static func rightTriangleAngles(adjacentLength: CGFloat, oppositeLength: CGFloat) -> (adjacentAngle: CGFloat, oppositeAngle: CGFloat, hypotenuse: CGFloat) {
        let hypotenuse = sqrt(pow(adjacentLength, 2) + pow(adjacentLength, 2))
        let radianA = asin(adjacentLength / hypotenuse)
        let angleA = radianA.degrees
        let angleB = 90 - angleA
        return (angleA, angleB, hypotenuse)
    }
}

//MARK: - CGPoint functions
extension CGSize {
    
    /// Multiply size by n
    /// - Parameters:
    ///     - multiplicand: The number to multiply size by
    /// - Returns: CGSize
    static func *(_ a: CGSize, _ multiplicand: CGFloat) -> CGSize {
        return CGSize(width: a.width * multiplicand, height: a.height * multiplicand)
    }
    
    /// Divide size by n
    /// - Parameters:
    ///     - divisor: The number to divide size by
    /// - Returns: CGSize
    static func /(_ a: CGSize, _ divisor: CGFloat) -> CGSize {
        return CGSize(width: a.width / divisor, height: a.height / divisor)
    }
    
    /// Subtracts CGSizes
    /// - Parameters:
    ///     - a, b: CGSizes to subtract
    /// - Returns: CGSizes
    static func -(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(width: a.width - b.width, height: a.height - b.height)
    }
    
    /// Adds CGSizes
    /// - Parameters:
    ///     - a, b: CGSizes to add
    /// - Returns: CGSizes
    static func +(_ a: CGSize, _ b: CGSize) -> CGSize {
        return CGSize(width: a.width + b.width, height: a.height + b.height)
    }
}
