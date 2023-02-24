//
//  MyDiffableDataSource.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 23/02/23.
//

import UIKit

// Es importante crear una subclase para ´UITableViewDiffableDataSource´para poder acceder a sus métodos y sobreescribirlos. A diferencia de una ´UITableViewDataSource´ normal, que al ser un protocolo, puede ser implementada en la clase del controlador.
class MyUITableViewDiffableDataSource: UITableViewDiffableDataSource<Section, Note> {
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            var snapshot = self.snapshot()
            if let note = self.itemIdentifier(for: indexPath) {
                snapshot.deleteItems([note])
                let notesFileManager = FileManagerService()
                do {
                    try? notesFileManager.save(snapshot.itemIdentifiers)
                }
                self.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
}
