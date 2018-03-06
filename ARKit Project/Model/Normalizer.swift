//
//  Normalizer.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 3/3/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import Foundation

class Normalizer {
    
    static func normalize(max: Float, withMin min: Float) -> Float {
        return (min >= 1) ? max - min + 1 : max / min
    }
    
    static func normalize(value fromValue: Float, withNormMax normMax: Float, withMax max: Float, withMin min: Float) -> Float {
        let normOneValue = normMax / max
        return (fromValue >= 1) ? fromValue * normOneValue : fromValue / min
    }
    
    static func denormalize(value fromNormValue: Float, withNormMax fromNormMax: Float, withMax max: Float, withMin min: Float) -> Float {
        if min >= 1 {
            return fromNormValue * (max / fromNormMax) + (min - 1)
        } else {
            let toNormMax = self.normalize(max: max, withMin: min)
            let toNormValue = fromNormValue * (toNormMax/fromNormMax)
            return toNormValue * min
        }
    }
    
    static func convert(value: Float, withMax fromMax: Float, withMin fromMin: Float, toMax: Float, toMin: Float) -> Float {
        let fromNormMax = normalize(max: fromMax, withMin: fromMin)
        let normFromValue = normalize(value: value, withNormMax: fromNormMax, withMax: fromMax, withMin: fromMin)
        return denormalize(value: normFromValue, withNormMax: fromNormMax, withMax: toMax, withMin: toMin)
    }
    
    static func invert(value: Float, withMax fromMax: Float, withMin fromMin: Float, toMax: Float, toMin: Float) -> Float {
        let fromNormMax = normalize(max: fromMax, withMin: fromMin)
        var normFromValue = normalize(value: value, withNormMax: fromNormMax, withMax: fromMax, withMin: fromMin)
        normFromValue = fromNormMax - normFromValue
        return denormalize(value: normFromValue, withNormMax: fromNormMax, withMax: toMax, withMin: toMin)
    }
    
}
