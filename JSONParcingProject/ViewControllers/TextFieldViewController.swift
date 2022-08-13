//
//  TextFieldViewController.swift
//  JSONParcingProject
//
//  Created by Светлана Сенаторова on 11.08.2022.
//

import UIKit

class TextFieldViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        getImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let wordVC = segue.destination as? WordsViewController else { return }
        wordVC.textForURLAdress = textField.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func showDetailsButtonPressed(_ sender: UIButton) {
        guard let text = textField.text, !text.isEmpty else {
            showAlert(with: "Attantion!", and: "Please enter your WORD")
            return
        }
        performSegue(withIdentifier: "showWords", sender: nil)
    }
    
    @IBAction func unwindTo(_ unwindSegue: UIStoryboardSegue) {
        textField.text = ""
    }
    
    private func getImage() {
        NetworkManager.shared.fetchImage(
            from: "https://sun9-67.userapi.com/impf/8vKz3W_-i407x_xOjHg29wud50e83MgBo1FJ2w/1usLb1j3I9E.jpg?size=757x431&quality=96&sign=fee8befc3068f7a8c8eecd545b2bc386&type=album"
        ) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
            }
    }

}

extension TextFieldViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let forgotEnterText = UIAlertAction(title: "OK", style: .default)
        alert.addAction(forgotEnterText)
        present(alert, animated: true)
    }
}
