//
//  DefinitionsTableViewCell.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 13.08.2022.
//

import UIKit

class DefinitionsTableViewCell: UITableViewCell {

    @IBOutlet var nameAndFoneticLabel: UILabel!
    @IBOutlet var partOfSpeechLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    @IBOutlet var exampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func getInfo(for word: Word) {
        
        nameAndFoneticLabel.text = "Name: \(word.word ?? "No data") \nPhonetics: \(word.phonetic ?? "No data")"
        guard let meanings = word.meanings else { return }
        for meaning in meanings {
        partOfSpeechLabel.text = "Part of speech: \(meaning.partOfSpeech ?? "No data")"
        definitionLabel.text = "Definition: \(meaning.definitions?[0].definition ?? "No data")"
        exampleLabel.text = "Example: \(meaning.definitions?[0].example ?? "No data")"
        }
    }

}
