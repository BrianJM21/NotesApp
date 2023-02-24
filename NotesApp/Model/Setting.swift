//
//  Setting.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 23/02/23.
//

import Foundation
import UIKit


// La configuración del usuario se almacenará localmente utilizando el ´UserDefaults´ de iOS, por lo que es necesario reducir los tipos de datos complejos como el ´UIColor´a un tipo de dato simple como ´String´ para posteriormente hacer la codificación a un archivo JSON y almacenarlo.
struct Setting: Codable {
    
    var noteColor: UIColor
    var hideDetails: Bool
}

// Implementamos el protocolo ´RawRepresentable´ para poder "mapear" la configuración del usuario a un tipo de dato sencillo y codeable como lo es un ´String´.
extension Setting: RawRepresentable {
    
    typealias RawValue = String

    // Decodificación del ´RawValue´ de tipo ´String´ a un ´Setting´.
    init?(rawValue: String) {
        
        do {
            
            let encodedData = rawValue.data(using: .utf8)!
            let components = try JSONDecoder().decode([Double].self, from: encodedData)
            var component4: Bool
            if components[4] == 0.0 {
                component4 = false
            } else {
                component4 = true
            }
            self = Setting(noteColor: UIColor(red: components[0]/255, green: components[1]/255, blue: components[2]/255, alpha: components[3]/255), hideDetails: component4)
        } catch {
            
            return nil
        }
    }
    
    // Codificación de un ´Setting´ a un ´RawValue´ de tipo ´String´.
    var rawValue: String {
        
        guard let cgFloatComponents = self.noteColor.cgColor.components else { return "" }
        var doubleComponents = cgFloatComponents.map { Double($0 * 255) }
        self.hideDetails ? doubleComponents.append(1.0) : doubleComponents.append(0.0)
        do {
            
            let encodedComponents = try JSONEncoder().encode(doubleComponents)
            return String(data: encodedComponents, encoding: .utf8) ?? ""
        } catch {
            
            return ""
        }
    }
}
