//
//  Word.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 08.08.2022.
//


struct Word: Decodable {
    let word: String?
    let phonetic: String?
    let meanings: [Meaning]?
}

struct Meaning: Decodable {
    let partOfSpeech: String?
    let definitions: [Definition]?
    
    static func getMeaning(partOfSpeech: String, definitions: [Definition]) -> Meaning {
        Meaning(partOfSpeech: partOfSpeech, definitions: [Definition.getDefinition(definition: "", example: "")])
    }
}

struct Definition: Decodable {
    let definition: String?
    let example: String?
    
    static func getDefinition(definition: String, example: String) -> Definition {
        Definition(definition: definition, example: example)
    }
}
