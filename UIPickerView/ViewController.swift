//
//  ViewController.swift
//  UIPickerView
//
//  Created by Никита Коголенок on 22.12.20.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Variables
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker",
    ]
    var selectedElement: String?
    // MARK: - Outlet
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var labelForSwitch: UILabel!
    @IBOutlet weak var switchElement: UISwitch!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = 1
        label.text = String(slider.value)
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        label.numberOfLines = 3
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        textField.placeholder = "Enter your name"
        textField.backgroundColor = .white
        
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUiElement()
        createToolbar()
    }
    // MARK: - Methods
    func hideAllElements() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        button.isHidden = true
        datePicker.isHidden = true
    }
    func choiceUiElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        // Costamization
        elementPicker.backgroundColor = .brown
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        // Costamization
        toolBar.tintColor = .white
        toolBar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected!"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected!"
            label.textColor = .yellow
        case 2:
            label.text = "The third segment is selected!"
            label.textColor = .green
        default:
            print("Something wrong!")
        }
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        guard textField.text?.isEmpty == false else { return }
        
        if Double(textField.text!) != nil {
            let alert = UIAlertController(title: "Wrong format!", message: "Please,enter your name!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            print("Name format is wrong!")
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
    }
    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedControl.isHidden = !segmentedControl.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        button.isHidden = !button.isHidden
        datePicker.isHidden = !datePicker.isHidden
        
        if sender.isOn {
            labelForSwitch.text = "Отобразить все элементы!"
        } else {
            labelForSwitch.text = "Скрыть все элементы!"
        }
    }
}
// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // количество барабанов которое мы используем
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    // количество элементов которые будут доступны в pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmentedControl.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            button.isHidden = false
        case 5:
            hideAllElements()
            datePicker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
    
    
}

