//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 22/02/23.
//

import UIKit

class DetailViewController: UIViewController, SettingController {
    
    var delegate: NoteController!
    var indexPath: IndexPath!
    var editingNote: Note!
    private var willDeleteNote = false
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        noteText.layer.cornerRadius = 10
        noteText.text = editingNote.text
        if let settings = settingLoad() {
            noteText.backgroundColor = settings.noteColor
        }
        noteTitle.text = editingNote.title
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if willDeleteNote {
            
            delegate.note(delete: editingNote)
        } else {
            editingNote.title = noteTitle.text!
            editingNote.text = noteText.text
            delegate.note(edit: editingNote, at: indexPath)
        }
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        
        let deleteActionSheet = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .actionSheet)
        deleteActionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
            
            [weak self] _ in
            
            self?.willDeleteNote = true
            self?.navigationController?.popViewController(animated: true)
            
        }))
        deleteActionSheet.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(deleteActionSheet, animated: true)
    }
}
