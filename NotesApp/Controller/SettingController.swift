//
//  SettingController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 24/02/23.
//

import Foundation

// El controlador de ´Setting´ tiene implementación por defecto que agiliza la comunicación con el ´User DefaultsService´ para hacer las peticiones de carga y guardado de la configuración e implementarla en las vistas que así lo requieran.
protocol SettingController {
    
    func settingLoad() -> Setting?
    
    func settingSave(_ setting: Setting)
}

extension SettingController {
    
    func settingLoad() -> Setting? {
        
        UserDefaultsService().loadSettings()
    }
    
    func settingSave(_ setting: Setting) {
        
        UserDefaultsService().saveSettings(setting)
    }
}
