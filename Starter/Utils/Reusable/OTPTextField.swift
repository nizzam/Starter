//
//  OTPTextField.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override func deleteBackward() {
        if text == "" {
            previousTextField?.becomeFirstResponder()
        }
    }
}

//  MARK:- Always triggers when the OTP field is valid
protocol OTPDelegate: class {
    func didChangeValidity(isValid: Bool)
}

class OTPStackView: UIStackView {
    
    /// Colors
    let inactiveFieldBorderColor = UIColor.clear
    let textBackgroundColor = UIColor.white
    let activeFieldBorderColor = UIColor.black
    
    /// Customise the OTPField here
    let numberOfFields = 6
    var textFieldsCollection: [OTPTextField] = []

    weak var delegate: OTPDelegate?
    
    var showsWarningColor = false
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        addOTPFields()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addOTPFields()
    }
    
    /// Customisation and setting stackView
    func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 10
    }
    
    /// Adding each OTPfield to stack view
    func addOTPFields() {
        for index in 0..<numberOfFields {
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            /// Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            /// Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        /// Setting first field as firstResponder
        textFieldsCollection[0].layer.borderColor = activeFieldBorderColor.cgColor
    }
    
    /// Customisation and setting OTPTextFields
    func setupTextField(_ textField: OTPTextField) {
        textField.delegate = self
        /// Adding constraints wrt to its parent i.e OTPStackView
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        textField.backgroundColor = textBackgroundColor
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont.boldSystemFont(ofSize: 36)
        textField.textColor = .black
        textField.tintColor = .clear
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
        textField.keyboardType = .numberPad
    }
    
    /// Checks if all the OTPfields are filled
    func checkForValidity() {
        for fields in textFieldsCollection {
            if (fields.text == "") {
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    /// Gives the OTP text
    func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection {
            OTP += textField.text ?? ""
        }
        return OTP
    }

    /// Set isWarningColor true for using it as a warning color
    func setAllFieldColor(isWarningColor: Bool = false, color: UIColor) {
        for textField in textFieldsCollection {
            textField.layer.borderColor = color.cgColor
        }
        showsWarningColor = isWarningColor
    }
    
    /// Clear all text in textfield for the first selection
    func clearAllTextField() {
        for fields in textFieldsCollection {
            fields.text = nil
        }
    }
}

//  MARK:- TextField Delegate
extension OTPStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textFieldsCollection[0] {
            clearAllTextField()
        }
        
        if showsWarningColor {
            setAllFieldColor(color: inactiveFieldBorderColor)
            showsWarningColor = false
        }
        textField.layer.borderColor = activeFieldBorderColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
    }
    
    /// Switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        
        if (range.length == 0) {
            if textField.nextTextField == nil {
                textField.resignFirstResponder()
            } else {
                textField.nextTextField?.becomeFirstResponder()
            }
            textField.text? = string
            checkForValidity()
            return false
            
        } else if (range.length == 1) {
            textField.previousTextField?.becomeFirstResponder()
            textField.text? = ""
            checkForValidity()
            return false
        }
        return true
    }
}
