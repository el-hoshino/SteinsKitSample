//
//  Usecase.swift
//  SteinsKitSample
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import Foundation
import SteinsKit

protocol RepositoryProtocol: AnyObject {
    func count(string: String, completion: @escaping (Result<Int, Error>) -> Void)
}

protocol ValidationUtilityProtocol: AnyObject {
    func result(of input: String) -> AsciiStringValidationResult
}

final class Usecase {
    
    private let repository: RepositoryProtocol
    private let validationUtility: ValidationUtilityProtocol
    
    let _timesOfCalculation = Variable(0)
    let _calculationResult = LazyVariable<String>()
    
    init(repository: RepositoryProtocol, validation: ValidationUtilityProtocol) {
        self.repository = repository
        self.validationUtility = validation
    }
    
    func _calculateLength(of string: String) {
        
        _timesOfCalculation.accept({ $0 + 1 })
        
        let validStatus = validationUtility.result(of: string)
        
        switch validStatus {
        case .success(let string):
            repository.count(string: string) { [weak _calculationResult] result in
                _calculationResult?.accept(result.resultValue)
            }
            
        case .failure(let error):
            _calculationResult.accept(String(describing: error))
        }
        
    }
    
}

private extension Result where Success == Int {
    
    var resultValue: String {
        switch self {
        case .success(let int):
            return "\(int)"
            
        case .failure(let error):
            return String(describing: error)
        }
    }
    
}
