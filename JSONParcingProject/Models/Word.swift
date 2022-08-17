//
//  Word.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 08.08.2022.
//


struct Word: Codable {
    var word: String?
    var phonetic: String?
    var meanings: [Meaning]?
    
    init (with value: [String:Any]) {
        word = value["word"] as? String
        phonetic = value["phonetic"] as? String
        let meaningsDictionary = value["meanings"] as? [[String:Any]] ?? [[:]]
        var meaningsArray: [Meaning] = []
        for meaningDictionary in meaningsDictionary {
            let meaning = Meaning(with: meaningDictionary)
            meaningsArray.append(meaning)
        }
        meanings = meaningsArray
    }
    
    static func getWord(from value: Any) -> [Word] {
        guard let wordsDdata = value as? [[String:Any]] else { return [] }
        var words: [Word] = []
        for wordData in wordsDdata {
            let currentWord = Word(with: wordData)
            words.append(currentWord)
        }
        return words
    }
    
}

struct Meaning: Codable {
    var partOfSpeech: String?
    var definitions: [Definition]?
    
    init (with value: [String:Any]) {
        partOfSpeech = value["partOfSpeech"] as? String
        let definitionsDictionary = value["definitions"] as? [[String:Any]] ?? [[:]]
        var definitionsArray: [Definition] = []
        for definitionDictionary in definitionsDictionary {
            let definition = Definition(with: definitionDictionary)
            definitionsArray.append(definition)
        }
        definitions = definitionsArray
    }
}

struct Definition: Codable {
    var definition: String?
    var example: String?
    
    init(with value: [String:Any]) {
        definition = value["definition"] as? String
        example = value["example"] as? String
    }
    
}

