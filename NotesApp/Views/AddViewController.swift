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
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        delegate.note(add: Note(title: noteTitle.text!, text: noteText.text))
        dismiss(animated: true)
    }
    
}
