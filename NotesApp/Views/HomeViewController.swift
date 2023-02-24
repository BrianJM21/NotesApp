//
//  ViewController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 22/02/23.
//

import UIKit

class HomeViewController: UIViewController, SettingController {
    
    // Se configura el ´DiffableDataSource´ con la tabla, la celda y el modelo de datos que que integra.
    var tableDataSource: MyUITableViewDiffableDataSource!
    
    // Instancia al controlador que administra la persistencia de datos local.
    let notesFileManager = FileManagerService()
    
    // Enlace con la ´TableView´ de la vista.
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        
        table.delegate = self
        setupTableDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        tableDataSource.applySnapshotUsingReloadData(tableDataSource.snapshot())
    }
    
    func setupTableDataSource() {
        
        tableDataSource = MyUITableViewDiffableDataSource(tableView: table, cellProvider: {
            
            [weak self] tableView, indexPath, noteModel in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var cellConfig = cell.defaultContentConfiguration()
            if noteModel.title.isEmpty {
                
                cellConfig.text = "Untitled Note"
            } else {
                
                cellConfig.text = noteModel.title
            }
            if noteModel.text.isEmpty {
                
                cellConfig.secondaryText = "This is an empty note..."
            } else {
             
                cellConfig.secondaryText = noteModel.text
            }
            if let settings = self?.settingLoad() {
                
                if settings.hideDetails {
                    
                    cellConfig.secondaryText = nil
                }
            }
            cell.contentConfiguration = cellConfig
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.main])
        if let notes = try? notesFileManager.load() {
            
            snapshot.appendItems(notes)
        }
        tableDataSource.apply(snapshot)
    }
    
    // Se sobreescribe el método ´prepare´ que permite "preparar" con información relevante la navegación hacia las vistas que se desprendan de ésta.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail" {
            
            guard let detailViewController = segue.destination as? DetailViewController else { return }
            detailViewController.delegate = self
            guard let indexPath = sender as? IndexPath else { return }
            guard let note = tableDataSource.itemIdentifier(for: indexPath) else { return }
            detailViewController.indexPath = indexPath
            detailViewController.editingNote = note
        }
        
        if segue.identifier == "add" {
            
            guard let addViewController = segue.destination as? AddViewController else { return }
            addViewController.delegate = self
        }
    }

    // Botón de navegación hacia la vista que agrega nuevas notas.
    @IBAction func addNote(_ sender: Any) {
        
        performSegue(withIdentifier: "add", sender: nil)
    }
}

// El ´HomeViewController´ será el delegado del ´NoteController´, por lo que debe implementar los métodos que agregan nuevas notas al modelo de datos integrado en el DiffableDataSource de la tabla, así como los métodos que editan y eliminan las nota seleccionadas previamente del ´TableView´.
extension HomeViewController: NoteController {
    
    func note(add note: Note) {
        
        var snapshot = tableDataSource.snapshot()
        snapshot.appendItems([note], toSection: Section.main)
        do {
            try? notesFileManager.save(snapshot.itemIdentifiers)
        }
        tableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func note(edit note: Note, at indexPath: IndexPath) {
        
        var notes = tableDataSource.snapshot().itemIdentifiers
        notes[indexPath.row] = note
        var editedSnapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        editedSnapshot.appendSections([Section.main])
        editedSnapshot.appendItems(notes)
        do {
            try? notesFileManager.save(editedSnapshot.itemIdentifiers)
        }
        tableDataSource.apply(editedSnapshot)
    }
    
    func note(delete note: Note) {
        
        var snapshot = tableDataSource.snapshot()
        snapshot.deleteItems([note])
        do {
            try? notesFileManager.save(snapshot.itemIdentifiers)
        }
        tableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// El ´HomeViewController´ es el delegado de la ´TableView´. Se implementa el método que permite al usuario seleccionar de la ´TableView´ una nota para su edición y/o eliminación.
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detail", sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
