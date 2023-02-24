//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Brian Jiménez Moedano on 23/02/23.
//

import UIKit

class SettingsViewController: UIViewController, SettingController {
    
    @IBOutlet weak var backgroundColor: UIColorWell!
    
    @IBOutlet weak var hideDetails: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let userSettings = settingLoad() {
            
            backgroundColor.selectedColor = userSettings.noteColor
            hideDetails.isOn = userSettings.hideDetails
        } else {
            
            backgroundColor.selectedColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 0.5)
            hideDetails.isOn = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        guard let selectedColor = backgroundColor.selectedColor else { return }
        settingSave(Setting(noteColor: selectedColor, hideDetails: hideDetails.isOn))
    }
}
