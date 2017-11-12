//
//  String+helpers.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 11/11/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import Foundation

extension String {
    
    func strip() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func withoutWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

