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
}

struct Definition: Decodable {
    let definition: String? 
    let example: String?
}
