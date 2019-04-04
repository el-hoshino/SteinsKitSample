//
//  ViewController.swift
//  SteinsKitSample
//
//  Created by 史 翔新 on 2019/04/04.
//  Copyright © 2019 Crazism. All rights reserved.
//

import UIKit
import SteinsKit

protocol UsecaseProtocol: AnyObject {
    var timesOfCalculation: AnyObservable<Int> { get }
    var calculationResult: AnyObservable<String> { get }
    func calculateLength(of string: String)
}

class ViewController: UIViewController {
    
    // It's better to set this property through DI
    var usecase = (UIApplication.shared.delegate as! AppDelegate).usecase
    private var calculationTimer: Timer?
    
    private var outputTextArray: [String] = ["", ""] {
        didSet {
            refreshOutputTextView()
        }
    }
    
    private(set) lazy var inputTextField: UITextField = {
        let field = UITextField()
        field.delegate = self
        return field
    }()
    
    private(set) lazy var outputTextView: UITextView = {
        let view = UITextView()
        view.isUserInteractionEnabled = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSubviews()
        setupLayout()
        startObservations()
        
    }
    
    private func setupSubviews() {
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        outputTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputTextField)
        view.addSubview(outputTextView)
        
    }
    
    private func setupLayout() {
        
        inputTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        inputTextField.bottomAnchor.constraint(equalTo: outputTextView.topAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        outputTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        outputTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        outputTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    private func startObservations() {
        
        usecase.calculationResult
            .beObserved(by: self, .asyncOnQueue(.main), onChanged: { $0.outputTextArray[0] = $1 })
        
        usecase.timesOfCalculation
            .map({ "You have calculated \($0) times" })
            .beObserved(by: self, .asyncOnQueue(.main), onChanged: { $0.outputTextArray[1] = $1 })
        
    }
    
    private func refreshOutputTextView() {
        
        outputTextView.text = outputTextArray.joined(separator: "\n")
        
    }
    
    private func sendLengthCalculation(of string: String, laterAfter interval: TimeInterval) {
        
        calculationTimer?.invalidate()
        
        calculationTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block:
            { [unowned usecase, string] _ in
                usecase.calculateLength(of: string)
            })
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text as NSString? ?? ""
        let newText = currentText.replacingCharacters(in: range, with: string)
        sendLengthCalculation(of: newText, laterAfter: 0.5)
        
        return true
        
    }
    
}
