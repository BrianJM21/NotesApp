//
//  FileManagerController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 23/02/23.
//

import Foundation

// Servicio que gestiona la carga y almacenamiento local de las notas en el file system de la app.
struct FileManagerService {
    
    // Directorio de almacenaiento.
    private var notesDirectory: URL {
        
        try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    // Archivo y extensión del archivo físico local.
    private var notesFile: URL {
        
        notesDirectory.appendingPathComponent("notes").appendingPathExtension(".json")
    }
    
    // Función que maneja el almacenamiento de los datos en un fichero de datos en formato JSON.
    func save(_ notes: [Note]) throws {
        
        let data = try JSONEncoder().encode(notes)
        try data.write(to: notesFile)
    }
    
    // Función que recupera el archivo físico local y lo decodifica de JSON a un objeto de Swift.
    func load() throws -> [Note]? {
        
        guard FileManager.default.isReadableFile(atPath: notesFile.path) else { return nil }
        let data = try Data(contentsOf: notesFile)
        return try JSONDecoder().decode([Note].self, from: data)
    }
}
