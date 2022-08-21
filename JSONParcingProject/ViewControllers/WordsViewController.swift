//
//  ViewController.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 08.08.2022.
//

import UIKit

class WordsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var words: [Word] = []
    private var word: Word?
    var textForURLAdress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
//        getWordInfo()
        fetchWord()
        navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func addButtonPressed() {
        
    }
    
    private func getUrl() -> String {
        return "https://api.dictionaryapi.dev/api/v2/entries/en/\(textForURLAdress ?? "hello")"
    }
    
//    private func getWordInfo() {
//
//        NetworkManager.shared.fetch(
//            [Word].self,
//            from: "https://api.dictionaryapi.dev/api/v2/entries/en/\(textForURLAdress ?? "hello")"
//        ) { [weak self] result in
//            switch result {
//            case .success(let words):
//                self?.word = words[words.count-1]
//                self?.tableView.reloadData()
//                print(words)
//                print(words.count)
//            case .failure(let error):
//                print(error)
//                self?.showAlert(with: "IMPOSSIBLE TO DISPLAY DATA!", and: "This word doesn't exist. Please, enter correct word in the previouse screen!")
//            }
//        }
//
//    }
    
    private func fetchWord() {
        NetworkManager.shared.fetchWord(from: getUrl()) { [weak self] result in
            switch result {
            case .success(let words):
                self?.words = words
                self?.word = words[words.startIndex]
                self?.tableView.reloadData()
                print(words)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension WordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let currentWord = word else { return 1 }
        guard let currentMeanings = currentWord.meanings else { return 1 }
        return currentMeanings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentWord = word else { return 1 }
        guard let currentMeanings = currentWord.meanings else { return 1 }
        guard let definitions = currentMeanings[section].definitions else { return 1 }
        return definitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? DefinitionsTableViewCell else { return UITableViewCell() }
        if let word = word {
            cell.getInfo(for: word, section: indexPath.section, row: indexPath.row)
        }
        let index = indexPath.row
        if index % 2 == 0 {
            cell.backgroundColor = .systemGray5
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .systemYellow
        
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 0, width: view.frame.width, height: view.frame.height - 20)
        label.textColor = .black
        guard let word = word else { return UIView() }
        label.text = "\(word.word?.uppercased() ?? "Loadind...") : \(word.meanings?[section].partOfSpeech ?? "No data")"
        label.font = .boldSystemFont(ofSize: 20)
        
        view.addSubview(label)
        
        return view
    }
            
}

extension WordsViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let invalidTexOfRequest = UIAlertAction(title: "OK", style: .default)
        alert.addAction(invalidTexOfRequest)
        present(alert, animated: true)
    }
}
