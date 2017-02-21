//
//  ViewController.swift
//  CustomPicker
//
//  Created by 周逸文 on 17/2/21.
//  Copyright © 2017年 TZSY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var regions = [["id":"0","name":"全国","num":"0","parentId":"0","level":"1"],["id":"0001","name":"北京市","num":"0001","parentId":"0","level":"1"],["id":"00010001","name":"朝阳区","num":"0001","parentId":"0001","level":"2"],["id":"00010002","name":"海淀区","num":"0002","parentId":"0001","level":"2"],["id":"00010003","name":"通州区","num":"0003","parentId":"0001","level":"2"],["id":"00010004","name":"房山区","num":"0004","parentId":"0001","level":"2"],["id":"00010005","name":"丰台区","num":"0005","parentId":"0001","level":"2"],["id":"00010006","name":"昌平区","num":"0006","parentId":"0001","level":"2"],["id":"00010007","name":"大兴区","num":"0007","parentId":"0001","level":"2"],["id":"00010008","name":"顺义区","num":"0008","parentId":"0001","level":"2"],["id":"00010009","name":"西城区","num":"0009","parentId":"0001","level":"2"],["id":"00010010","name":"延庆县","num":"0010","parentId":"0001","level":"2"],["id":"00010011","name":"石景山区","num":"0011","parentId":"0001","level":"2"],["id":"00010012","name":"宣武区","num":"0012","parentId":"0001","level":"2"],["id":"00010013","name":"怀柔区","num":"0013","parentId":"0001","level":"2"],["id":"00010014","name":"崇文区","num":"0014","parentId":"0001","level":"2"],["id":"00010015","name":"密云县","num":"0015","parentId":"0001","level":"2"],["id":"00010016","name":"东城区","num":"0016","parentId":"0001","level":"2"],["id":"00010017","name":"平谷区","num":"0017","parentId":"0001","level":"2"],["id":"00010018","name":"门头沟区","num":"0018","parentId":"0001","level":"2"],["id":"0002","name":"上海市","num":"0002","parentId":"0","level":"1"],["id":"00020001","name":"松江区","num":"0001","parentId":"0002","level":"2"],["id":"00020002","name":"宝山区","num":"0002","parentId":"0002","level":"2"],["id":"00020003","name":"金山区","num":"0003","parentId":"0002","level":"2"],["id":"00020004","name":"嘉定区","num":"0004","parentId":"0002","level":"2"],["id":"00020005","name":"南汇区","num":"0005","parentId":"0002","level":"2"],["id":"00020006","name":"青浦区","num":"0006","parentId":"0002","level":"2"],["id":"00020007","name":"浦东新区","num":"0007","parentId":"0002","level":"2"],["id":"00020008","name":"奉贤区","num":"0008","parentId":"0002","level":"2"],["id":"00020009","name":"徐汇区","num":"0009","parentId":"0002","level":"2"],["id":"00020010","name":"静安区","num":"0010","parentId":"0002","level":"2"],["id":"00020011","name":"闵行区","num":"0011","parentId":"0002","level":"2"],["id":"00020012","name":"黄浦区","num":"0012","parentId":"0002","level":"2"],["id":"00020013","name":"杨浦区","num":"0013","parentId":"0002","level":"2"],["id":"00020014","name":"虹口区","num":"0014","parentId":"0002","level":"2"],["id":"00020015","name":"普陀区","num":"0015","parentId":"0002","level":"2"],["id":"00020016","name":"闸北区","num":"0016","parentId":"0002","level":"2"],["id":"00020017","name":"长宁区","num":"0017","parentId":"0002","level":"2"],["id":"00020018","name":"崇明县","num":"0018","parentId":"0002","level":"2"],["id":"00020019","name":"卢湾区","num":"0019","parentId":"0002","level":"2"],
        ["id":"00010001","name":"南磨房地区","num":"0001","parentId":"00010001","level":"3"],
        ["id":"00010001","name":"高碑店地区","num":"0001","parentId":"00010001","level":"3"],
        ["id":"00010001","name":"将台地区","num":"0001","parentId":"00010001","level":"3"],
        ["id":"00010001","name":"太阳宫地区","num":"0001","parentId":"00010001","level":"3"],
        ["id":"00010001","name":"小红门地区","num":"0001","parentId":"00010001","level":"3"],
        ["id":"00010001","name":"十八里店地区","num":"0001","parentId":"00010001","level":"3"],
        ["id":"00010001","name":"三间房地区","num":"0001","parentId":"00010001","level":"3"]]
    
    
    var oneBtn: UIButton!
    var twoBtn: UIButton!
    var threeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oneBtn = UIButton(frame: CGRect(x: 20, y: 40, width: 300, height: 40))
        oneBtn.setTitle("一级选择器", for: .normal)
        oneBtn.backgroundColor = UIColor.darkGray
        twoBtn = UIButton(frame: CGRect(x: 20, y: 90, width: 300, height: 40))
        twoBtn.setTitle("二级选择器", for: .normal)
        twoBtn.backgroundColor = UIColor.darkGray
        threeBtn = UIButton(frame: CGRect(x: 20, y: 140, width: 300, height: 40))
        threeBtn.setTitle("三级选择器", for: .normal)
        threeBtn.backgroundColor = UIColor.darkGray
        view.addSubview(oneBtn)
        view.addSubview(twoBtn)
        view.addSubview(threeBtn)
        
        oneBtn.addTarget(self, action: #selector(ViewController.dooneBtn), for: .touchUpInside)
        twoBtn.addTarget(self, action: #selector(ViewController.dotwoBtn), for: .touchUpInside)
        threeBtn.addTarget(self, action: #selector(ViewController.dothreeBtn), for: .touchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dooneBtn() {
        addPicker(type: .zdefault)
    }
    func dotwoBtn() {
        addPicker(type: .zdouble)
    }
    func dothreeBtn() {
        addPicker(type: .zthree)
    }
    func addPicker(type: Pickertype){
        let arrays =  regions.map{RegionsModel(dict: $0)}
        let picker = CustomPicker(frame: CGRect.zero, items: arrays, pickertype: type)
        picker.zdefaultSelected = { (onename) in
            self.oneBtn.setTitle(onename, for: .normal)
        }
        picker.zdoubleSelected = { (onename,twoname) in
            self.twoBtn.setTitle("\(onename)==\(twoname)", for: .normal)
        }
        picker.zthreeSelected = { (onename,twoname,threename) in
            self.threeBtn.setTitle("\(onename)==\(twoname)==\(threename)", for: .normal)
        }
        let win: UIWindow = UIApplication.shared.windows.last!
        win.addSubview(picker)
        picker.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        
    }
    
}

