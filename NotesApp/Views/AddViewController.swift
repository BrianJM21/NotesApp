//
//  AddViewController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 22/02/23.
//

import UIKit

class AddViewController: UIViewController, SettingController {
    
    var delegate: NoteController!
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteText.layer.cornerRadius = 10
        if let settings = settingLoad() {
            noteText.backgroundColor = settings.noteColor
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.size.height -= keyboardSize.height
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        delegate.note(add: Note(title: noteTitle.text!, text: noteText.text))
        dismiss(animated: true)
    }
    
}
