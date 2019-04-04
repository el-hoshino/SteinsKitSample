//
//  ValidationUtility.swift
//  SteinsKitSample
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import Foundation

final class ValidationUtility {
    
}

extension ValidationUtility: ValidationUtilityProtocol {
    
    func result(of input: String) -> AsciiStringValidationResult {
        
        if input.contains(where: { !$0.isASCII }) {
            return .failure(.nonAsciiCharacters)
            
        } else {
            return .success(input)
        }
        
    }
    
}
