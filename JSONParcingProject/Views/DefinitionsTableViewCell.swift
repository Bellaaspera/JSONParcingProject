//
//  DefinitionsTableViewCell.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 13.08.2022.
//

import UIKit

class DefinitionsTableViewCell: UITableViewCell {

    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var forthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func getInfo(for word: Word, section: Int, row: Int) {
        
        secondLabel.text = "\(row + 1). Phonetics: \(word.phonetic ?? "No data")"
        guard let meaning = word.meanings?[section] else { return }
        thirdLabel.text = "Definition: \(meaning.definitions?[row].definition ?? "No data")"
        forthLabel.text = "Example: \(meaning.definitions?[row].example ?? "No data")"
        
    }

}
