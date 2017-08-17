//
//  EntryViewController.swift
//  JournaliOS14CloudKit
//
//  Created by Nick Reichard on 8/16/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    // MARK: - Actions

    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        self.titleTextField.text = ""
        self.bodyTextView.text = ""
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!

}
