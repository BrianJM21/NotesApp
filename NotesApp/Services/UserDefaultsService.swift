//
//  UserDefaultsController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 24/02/23.
//

import Foundation

// Servicio que gestiona la carga y almacenamiento local de la configuración del usuario en el UserDefaults de iOS.
struct UserDefaultsService {
    
    // Instancia la UserDefaults de iOS.
    private let userDefaults = UserDefaults()
    // Se define una llave para identificar la configuración de usuario de la app.
    private let keySetting = "NotesAppSettings"
    
    func loadSettings() -> Setting? {
        
        Setting(rawValue: userDefaults.string(forKey: keySetting) ?? "")
    }
    
    func saveSettings(_ settings: Setting) {
        
        userDefaults.set(settings.rawValue, forKey: keySetting)
    }
}
