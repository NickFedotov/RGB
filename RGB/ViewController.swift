//
//  ViewController.swift
//  RGB
//
//  Created by Nikita Fedotov on 19.08.2020.
//  Copyright © 2020 Nikita Fedotov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        
        setColor()
        setValueForLabel()
        setValueForTextLabel()
        
        addDoneButtonTo(redTextField)
        addDoneButtonTo(greenTextField)
        addDoneButtonTo(blueTextField)
        
    }

    //Изменение цветов слайдерами
    @IBAction func rgbSlider (_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = rounding (from: sender)
            redTextField.text = rounding (from: sender)
        case 1:
            greenLabel.text = rounding (from: sender)
            greenTextField.text = rounding (from: sender)
        case 2:
            blueLabel.text = rounding (from: sender)
            blueTextField.text = rounding (from: sender)
        default: break
        }
        
        setColor()
    }
    
    //Цввет View
    private func setColor() {
        colorView.backgroundColor = UIColor (red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
    }
    
    private func setValueForLabel() {
        redLabel.text = rounding(from: redSlider)
        greenLabel.text = rounding(from: greenSlider)
        blueLabel.text = rounding(from: blueSlider)
    }
    
    private func setValueForTextLabel() {
        redTextField.text = rounding(from: redSlider)
        greenTextField.text = rounding(from: greenSlider)
        blueTextField.text = rounding(from: blueSlider)
    }
    
    private func rounding(from slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
}

extension ViewController: UITextFieldDelegate {
    
    //Скрываем клавиатуру нажатием "Done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Скрываем клавиатуру за пределами Text View
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    view.endEditing(true) //Скрываем клавиатуру, вызванную для любого объекта
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let currentValue = Float(text) {
            
            switch textField.tag {
            case 0: redSlider.value = currentValue
            case 1: greenSlider.value = currentValue
            case 2: blueSlider.value = currentValue
            default: break
            }
            setColor()
            setValueForLabel()
        } else {
            showAlert(title: "Wrong format!", message: "Please enter correct value")
        }
    }
}

//Метод отображение кнопки "Done"
extension ViewController {
    private func addDoneButtonTo(_ textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
