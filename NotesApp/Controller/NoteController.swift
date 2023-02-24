//
//  NoteController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 23/02/23.
//

import Foundation

// Controlador entre el modelo de datos Note y las Vistas que presentan información de dicho modelo o modifican su estado por medio de las operaciones que el usuario solicita. Quien se asuma como delegado del controlador, debe implementar la funcionalidad de dichas operaciones.
protocol NoteController {
    
    func note(add note: Note)
    
    func note(edit note: Note, at indexPath: IndexPath)
    
    func note(delete note: Note)
}
