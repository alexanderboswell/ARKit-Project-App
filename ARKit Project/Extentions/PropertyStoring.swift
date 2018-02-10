//
//  PropertyStoring.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 2/10/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import Foundation

protocol PropertyStoring {
    
    associatedtype StoredType
    
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: StoredType) -> StoredType
}

extension PropertyStoring {
    func getAssociatedObject(_ key: UnsafeRawPointer!, defaultValue: StoredType) -> StoredType {
        guard let value = objc_getAssociatedObject(self, key) as? StoredType else {
            return defaultValue
        }
        return value
    }
}
