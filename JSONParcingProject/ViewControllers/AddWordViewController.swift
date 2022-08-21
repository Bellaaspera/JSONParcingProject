//
//  AddWordViewController.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 20.08.2022.
//

import UIKit

class AddWordViewController: UIViewController {

    
    @IBOutlet var phoneticTF: UITextField!
    @IBOutlet var wordTF: UITextField!
    @IBOutlet var partOfSpeechTF: UITextField!
    @IBOutlet var definitionTF: UITextField!
    @IBOutlet var exampleTF: UITextField!
    
    @IBOutlet var addPartOfSpeechTF: UITextField!
    @IBOutlet var addDefinitionTF: UITextField!
    @IBOutlet var addExampleTF: UITextField!
   
    @IBOutlet var addTFButton: UIButton!
    @IBOutlet var pickerView: UIPickerView!
    
    private var newWord: [Word] = []
    private var firstWordOption: Word?
    private var secondWordOption: Word?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partOfSpeechTF.inputView = pickerView
        addPartOfSpeechTF.inputView = pickerView
    }

    @IBAction func additionalTFButtonPressed() {
        if addPartOfSpeechTF.isHidden {
        addTFButton.setTitle("-", for: .normal)
        addExampleTF.isHidden = false
        addDefinitionTF.isHidden = false
        addPartOfSpeechTF.isHidden = false
        } else {
            addTFButton.setTitle("+", for: .normal)
            addExampleTF.isHidden = true
            addDefinitionTF.isHidden = true
            addPartOfSpeechTF.isHidden = true
        }
    }
    
    @IBAction func saveWordButtonPressed() {
        guard let first = firstWordOption else { return }
        guard let second = secondWordOption else { return }
        newWord.append(first)
        newWord.append(second)
        print("The word is this: \(newWord)")
        dismiss(animated: true)
    }

}

extension AddWordViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        PartOfSpeech.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PartOfSpeech.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
        partOfSpeechTF.text = PartOfSpeech.allCases[row].rawValue
        default:
        addPartOfSpeechTF.text = PartOfSpeech.allCases[row].rawValue
        }
    }
    
}

extension AddWordViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        switch addPartOfSpeechTF.isHidden {
        case false:
            var definitionDict: [String:Any] = [:]
            definitionDict["definition"] = addDefinitionTF.text
            definitionDict["example"] = addExampleTF.text
            var meaningDict: [String:Any] = [:]
            meaningDict["partOfSpeech"] = addPartOfSpeechTF.text
            meaningDict["definitions"] = [definitionDict]
            secondWordOption = Word(
                word: wordTF.text ?? "No data",
                phonetic: phoneticTF.text ?? "No data",
                meanings: [Meaning(with: meaningDict)]
            )
            fallthrough
        default:
            var definitionDict: [String:Any] = [:]
            definitionDict["definition"] = definitionTF.text
            definitionDict["example"] = exampleTF.text
            var meaningDict: [String:Any] = [:]
            meaningDict["partOfSpeech"] = partOfSpeechTF.text
            meaningDict["definitions"] = [definitionDict]
            firstWordOption = Word(
                word: wordTF.text ?? "No data",
                phonetic: phoneticTF.text ?? "No data",
                meanings: [Meaning(with: meaningDict)]
            )
        }
    }
}
