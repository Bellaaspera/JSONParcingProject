//
//  WordFromDictViewController.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 20.08.2022.
//

import UIKit

class WordFromDictViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet var wordFromDictTableView: UITableView!
    var words: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        wordFromDictTableView.reloadData()
        print(words ?? "No data")

    }
    
    @IBAction func addWordButtonPressed() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        words?.count ?? 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wordFromDictTableView.dequeueReusableCell(withIdentifier: "dictionaryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Text from Dictionary fo word: \(words?[indexPath.row] ?? "No data")"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = .systemYellow
        
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 0, width: view.frame.width, height: view.frame.height - 20)
        label.textColor = .black
        guard let words = words else { return UIView() }
        label.text = "Word: \(words[section])"
        label.font = .boldSystemFont(ofSize: 20)
        
        view.addSubview(label)
        
        return view
    }
}
