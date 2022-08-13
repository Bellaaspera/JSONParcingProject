//
//  ViewController.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 08.08.2022.
//

import UIKit

class WordsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var words: [Word]?
    var textForURLAdress: String?
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 180
        getWordInfo()
        navigationItem.hidesBackButton = true
    }
    
    private func getWordInfo() {
        
        NetworkManager.shared.fetch(
            [Word].self,
            from: "https://api.dictionaryapi.dev/api/v2/entries/en/\(textForURLAdress ?? "hello")"
        ) { [weak self] result in
            switch result {
            case .success(let words):
                self?.words = words
                self?.index = words[words.startIndex].meanings?.count ?? 0
                self?.tableView.reloadData()
                print(words)
                print(words.count)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension WordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let words = words else { return 1 }
        return words.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        index
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? DefinitionsTableViewCell else { return UITableViewCell() }
        if let word = words?[indexPath.section] {
            for _ in 0...indexPath.row {
        cell.getInfo(for: word)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .systemYellow
        
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 0, width: view.frame.width, height: view.frame.height - 20)
        label.textColor = .black
        guard let words = words else { return UIView() }
        label.text = words[section].word?.uppercased()
        label.font = .boldSystemFont(ofSize: 20)
        
        view.addSubview(label)
        
        return view
    }
                      
                                                            
}

