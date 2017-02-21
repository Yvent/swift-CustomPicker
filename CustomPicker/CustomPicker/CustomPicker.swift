//
//  CustomPicker.swift
//  CustomPicker
//
//  Created by 周逸文 on 17/2/21.
//  Copyright © 2017年 TZSY. All rights reserved.
//

import UIKit
//MARK: UI
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
public enum Pickertype: String {
    case zdefault = "default"
    case zdouble = "double"
    case zthree = "three"
    
}
struct RegionsModel{
    
    var id: String
    var name: String
    var num: String
    var parentId: String
    var level: String
    
    init(dict: [String: Any]) {
        id = dict["id"] as! String
        name = dict["name"] as! String
        num = dict["num"] as! String
        parentId = dict["parentId"] as! String
        level = dict["level"] as! String
    }
}
class CustomPicker: UIView ,UIPickerViewDelegate,UIPickerViewDataSource{
    var zdefaultSelected: ((_ defaultname: String)->())?
    var zdoubleSelected: ((_ defaultname: String, _ doublename: String)->())?
    var zthreeSelected: ((_ defaultname: String, _ doublename: String, _ threename: String)->())?
    var bgV: UIView!
    var picker: UIPickerView!
    var toolsv: UIView!
    var cancel: UIButton!
    var sure: UIButton!
    
    var pickerType: Pickertype = .zdefault
    
    var arrays: Array<RegionsModel>!
    
    
    var OneRow = 0
    var TwoRow = 0
    
    init(frame: CGRect,items: Array<RegionsModel>,pickertype: Pickertype) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        arrays = items
        pickerType = pickertype
        initUI()
        showPicker()
    }
    
    func initUI() {
        bgV = UIView()
        bgV.backgroundColor = UIColor.white
        toolsv = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        toolsv.backgroundColor = UIColor.white
        cancel = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(UIColor(red: 253/255, green: 128/255, blue: 35/255,alpha: 1), for: .normal)
        cancel.addTarget(self, action: #selector(CustomPicker.doCancel), for: .touchUpInside)
        sure = UIButton(frame: CGRect(x: ScreenWidth - 50, y: 0, width: 50, height: 40))
        sure.setTitle("确定", for: .normal)
        sure.setTitleColor(UIColor(red: 253/255, green: 128/255, blue: 35/255,alpha: 1), for: .normal)
        sure.addTarget(self, action: #selector(CustomPicker.doSure), for: .touchUpInside)
        self.addSubview(bgV)
        bgV.addSubview(toolsv)
        
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 40, width: ScreenWidth, height: 200))
        picker.delegate = self
        picker.dataSource = self
        bgV.addSubview(picker)
        
        toolsv.addSubview(cancel)
        toolsv.addSubview(sure)
        bgV.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 240)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        super.touchesBegan(touches, with: event)
        hidePicker()
    }
    func doCancel() {
        hidePicker()
    }
    func doSure() {
        hidePicker()
    }
    func showPicker() {
        UIView.animate(withDuration: 0.25) {
            self.bgV.frame = CGRect(x: 0, y: ScreenHeight - 240, width: ScreenWidth, height: 240)
        }
    }
    
    func hidePicker() {
        UIView.animate(withDuration:  0.25, animations: {
            self.bgV.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 240)
        }) { (true) in
            self.removeFromSuperview()
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        switch pickerType {
        case .zdefault:
            return 1
        case .zdouble:
            return 2
        case .zthree:
            return 3
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerType {
        case .zdefault:
            return arrays.count
        case .zdouble:
            if component == 0 {
                return arrays.filter{$0.level == "1"}.count
            }else{
                return arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                    }.count
            }
        case .zthree:
            if component == 0 {
                return arrays.filter{$0.level == "1"}.count
                
            }else if component == 1{
                return arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                    }.count
            }else{
                let twoarray = arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                }
                if twoarray.count != 0 {
                    return arrays.filter{ $0.level == "3" && $0.parentId == twoarray[TwoRow].id }.count
                }else{
                    return 0
                }
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerType {
        case .zdefault:
            return arrays[row].name
        case .zdouble:
            if component == 0 {
                return arrays.filter{$0.level == "1"}[row].name
            }else{
                return arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                    }[row].name
            }
        case .zthree:
            if component == 0 {
                return arrays.filter{$0.level == "1"}[row].name
                
            }else if component == 1{
                return arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                    }[row].name
            }else{
                let twoarray = arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                }
                if twoarray.count != 0 {
                    return arrays.filter{ $0.level == "3" && $0.parentId == twoarray[TwoRow].id }[row].name
                }else{
                    return nil
                }
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerType {
        case .zdefault:
           zdefaultSelected?(arrays[row].name)
        case .zdouble:
            if component == 0 {
                OneRow = row
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
            }else{
                
                let twoarray = arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                }
                if twoarray.count != 0 {
                    zdoubleSelected?(arrays.filter{$0.level == "1"}[OneRow].name,twoarray[row].name)
                }
                
            }
          
        case .zthree:
            if component == 0 {
                OneRow = row
                pickerView.reloadComponent(1)
                pickerView.selectRow(0, inComponent: 1, animated: true)
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                
            }else if component == 1{
                TwoRow = row
                pickerView.reloadComponent(2)
                pickerView.selectRow(0, inComponent: 2, animated: true)
                
            }else{
                let twoarray = arrays.filter{
                    $0.level == "2" && $0.parentId == arrays.filter{$0.level == "1"}[OneRow].id
                }
                if twoarray.count != 0 {
                    let cc = arrays.filter{
                        $0.level == "3" && $0.parentId == twoarray[TwoRow].id
                    }
                    if cc.count != 0 {
                        print("\(twoarray[TwoRow].id)==\(cc[row].name)")
                        
                        zthreeSelected?(arrays.filter{$0.level == "1"}[OneRow].name,twoarray[TwoRow].name,cc[row].name)
                    }
                }

            }
        }
    }
}
