//
//  AddToDoViewController.swift
//  TODOTask
//
//  Created by Mac on 11/10/1931 Saka.
//  Copyright © 1931 Mac. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var lblViewTitle: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtNote: UITextField!
    
    var pushdata = [Todo]()
    var dict = [String:String]()
    var isEdit = false
    var index = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 10
        btnSave.backgroundColor = UIColor(red: 0, green: 0/255, blue: 205/255, alpha: 1)
        btnSave.clipsToBounds = true
        if isEdit == true{
            lblViewTitle.text = "Update Todo"
            btnSave.setTitle("Update", for: .normal)
            txtTitle.text = dict["title"]
            txtNote.text = dict["note"]
            txtDate.text = dict["date"]
        }
    }
    
    
    @IBAction func dateTextfieldTouhed(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(AddToDoViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        txtDate.text = dateFormatter.string(from: sender.date)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        let  data = ["title":txtTitle.text,"note":txtNote.text,"date":txtDate.text]
        if txtTitle.text! == "" || txtDate.text == "" || txtNote.text == ""
        {
            let alert = UIAlertController(title: "Alert", message: "Please Enter Valid Input", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }else{
            if isEdit == true
            {
                DatabaseHelper.shareInstant.editData(object: data as! [String:String], index: index)
                self.navigationController?.popViewController(animated: true)
                
            }else{
                DatabaseHelper.shareInstant.saveData(object: data as! [String:String])
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
