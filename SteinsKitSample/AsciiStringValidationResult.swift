//
//  AsciiStringValidationResult.swift
//  SteinsKitSample
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import Foundation

enum AsciiStringValidationError: Error {
    case nonAsciiCharacters
}

typealias AsciiStringValidationResult = Result<String, AsciiStringValidationError>
