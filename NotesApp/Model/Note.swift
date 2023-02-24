//
//  Note.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 22/02/23.
//

import Foundation

// Al ser un modelo de datos que implementa el protocolo ´Hashable´ (necesario para insertarlo en una ´UITableViewDiffableDataSource´), debemos incluir un *id* que permita tener dos o más objetos con propiedades idénticas dentro del DataSource de la TableView. También es necesario implementar el protocolo ´Codable´ para la persistencia de datos local en forma de un fichero JSON dentro el File System de la aplicación.
struct Note: Hashable, Codable {
    
    private let id: UUID
    var title: String
    var text: String
    
    init(title: String, text: String) {
        
        self.id = UUID()
        self.title = title
        self.text = text
    }
}

// Sólo ocuparemos una sección principal para las notas.
enum Section {
    
    case main
}
