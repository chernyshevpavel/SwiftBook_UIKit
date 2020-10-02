//
//  ViewController.swift
//  SegmentedControl
//
//  Created by Павел Чернышев on 29.09.2020.
//  Copyright © 2020 Павел Чернышев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = [
        "UISegmentedControl",
        "UILabel",
        "UISlaider",
        "UITextField",
        "UIButton",
        "UIDatePicker"
    ]
    
    var selectedElement: String?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sliderValue: Float = 0.5
        
        label.text = String(sliderValue)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = sliderValue;
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUiElement()
        createToolbar()
    }
    
    func hideAllElement() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
        
    }
    
    func choiceUiElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        textField.inputView = elementPicker
        
        //costamization
        elementPicker.backgroundColor = .brown
    }
    
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        
        // Castomization
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false;
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The second segment is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .yellow
        default:
            print("Somthing wrong!")
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func cangeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormatter.string(from: sender.date)
        label.text = dateValue
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
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
            hideAllElement()
            segmentedControl.isHidden = false
        case 1:
            hideAllElement()
            label.isHidden = false
        case 2:
            hideAllElement()
            slider.isHidden = false
        case 3:
            hideAllElement()
        case 4:
            hideAllElement()
            doneButton.isHidden = false
        case 5:
            hideAllElement()
            datePicker.isHidden = false
        default:
            hideAllElement()
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
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
