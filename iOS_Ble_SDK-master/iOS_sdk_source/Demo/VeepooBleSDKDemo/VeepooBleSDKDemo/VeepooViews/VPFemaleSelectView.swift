//
//  VPFemaleSelectView.swift
//  VeepooBleSDKDemo
//
//  Created by 张冲 on 17/6/14.
//  Copyright © 2017年 zc.All rights reserved.
//

/*
The logic of this department is not very strict，
Writing this demo is mainly to tell developers who use SDK，How to call the interface and general usage logic，
1.The female project is generally divided into 4 menstrual periods：menstruation、Pregnancy period,、Due date、Baoma period
2.In the menstrual period, pregnancy preparation period, and the pregnant period, the bracelet needs to know the time of the user's last menstruation
3.Normal menstrual cycle, that is, the interval between two menstrual periods. The physique of different people varies from person to person. The default is 28 days.
4.Menstrual period length, that is, how many days it takes from menstruation to disappearance of menstruation, 5-6 days for average people
5.If the App needs to do this function, it is recommended to refer to Meiyou and Auntie, and search for various parameters on the Internet. We only provide the development interface, and the developer and the product manager need to define the details.


Finally, don’t complain about my bad writing. It’s enough for the developer to understand the general meaning. I also took the time to write a demo. Haha, this feature is over. Let’s take a break.
 */

import UIKit

class VPFemaleSelectView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    var callBackBlock: ((Bool) -> Void)?

    var selectViewTitle: String? {
        willSet
        {
            
        }
        didSet {
            titleLabel.text = selectViewTitle
//            selectPickerView.reloadAllComponents()
        }
    }
    
    var femaleModel: VPDeviceFemaleModel?

    let titleLabel: UILabel = UILabel()

    let selectPickerView:UIPickerView = UIPickerView()
    
    let physiologicalArray = ["Cancel","Menstrual Period","Pregnancy Period","Expected Date","Baoma Period""]
    let sexArray = ["men and women"]
    
    var a = 0,b = 0,c = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        self.setSelectViewUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectViewUI() {
        let selectMainView = UIView(frame: CGRect(x: 30, y: (self.frame.size.height - 300)/2, width: self.frame.size.width - 60, height: 300))
        selectMainView.backgroundColor = UIColor(white: 0.7, alpha: 0.8)
        self.addSubview(selectMainView)
        
        let seletctTopView = UIView(frame: CGRect(x: 0, y: 0, width: selectMainView.frame.width, height: 44))
        seletctTopView.backgroundColor = UIColor.brown
        selectMainView.addSubview(seletctTopView)
        
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.frame = CGRect(x: 10, y: 0, width: 40, height: seletctTopView.frame.height)
        cancelBtn.tag = 0
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelOrConfirmAction(sender:)), for: .touchUpInside)
        seletctTopView.addSubview(cancelBtn)
        
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.frame = CGRect(x: seletctTopView.frame.width - 50, y: 0, width: 40, height: seletctTopView.frame.height)
        confirmBtn.tag = 1
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.addTarget(self, action: #selector(cancelOrConfirmAction(sender:)), for: .touchUpInside)
        seletctTopView.addSubview(confirmBtn)
        
        titleLabel.frame = CGRect(x: 60, y: 0, width: seletctTopView.frame.size.width - 120, height: seletctTopView.frame.size.height)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        seletctTopView.addSubview(titleLabel)
        
        selectPickerView.frame = CGRect(x: 0, y: seletctTopView.frame.size.height, width: selectMainView.frame.size.width, height: selectMainView.frame.size.height - seletctTopView.frame.size.height)
        selectPickerView.delegate = self
        selectPickerView.dataSource = self
        selectMainView.addSubview(selectPickerView)
    }
    
    @objc func cancelOrConfirmAction(sender: UIButton) {
        if sender.tag == 1 {
            if selectViewTitle == "Menstrual period selection" {
                femaleModel?.femaleState = VPDeviceFemaleState(rawValue: a)!
            }else if selectViewTitle == "Date of last menstrual period" {
                femaleModel?.lastMenstrualDate = String(format: "%04d", a + 2001) + "-" + String(format: "%02d", b + 1) + "-" + String(format: "%02d", c + 1)
            }else if selectViewTitle == "Menstrual cycle" {
                femaleModel?.menstrualCircle = a + 7
            }else if selectViewTitle == "Normal duration of menstrual period" {
                femaleModel?.menstrualDays = a + 1
            }else if selectViewTitle == "Baby birthday" {
                femaleModel?.babyBirthday = String(format: "%04d", a + 2001) + "-" + String(format: "%02d", b + 1) + "-" + String(format: "%02d", c + 1)
            }else if selectViewTitle == "Baby gender" {
                femaleModel?.isGirl = a == 1
            }else {//Due date
                femaleModel?.expectedDateOfChildbirth = String(format: "%04d", a + 2001) + "-" + String(format: "%02d", b + 1) + "-" + String(format: "%02d", c + 1)
            }
        }
        
        callBackBlock!(sender.tag == 1)
    }
    
    // MARK: - pickerView DataSorce和delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if selectViewTitle == "生理期选择" {
            return 1
        }else if selectViewTitle == "最后经期日期" {
            return 3
        }else if selectViewTitle == "经期周期" {
            return 1
        }else if selectViewTitle == "经期正常持续天数" {
            return 1
        }else if selectViewTitle == "宝宝生日" {
            return 3
        }else if selectViewTitle == "宝宝性别" {
            return 1
        }else if selectViewTitle == "预产期"{//预产期
            return 3
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectViewTitle == "生理期选择" {//四种生理期
            return 5
        }else if selectViewTitle == "最后经期日期" || selectViewTitle == "宝宝生日" || selectViewTitle == "预产期" {//这里没有对日期进行逻辑处理，就是简单的功能实现，如出现9月份有31日的，你们自己设置的时候注意一下就好，我累了，不想写
            if component == 0 {//（2001-2019）
                return 19
            }else if component == 1 {
                return 12
            }else {
                return 31
            }
        }else if selectViewTitle == "经期周期" {//两次经期的正常间隔（7-46）
            return 40
        }else if selectViewTitle == "经期正常持续天数" {//从来月经到走（1-15）
            return 15
        }else if selectViewTitle == "宝宝性别" {//男或者女
            return 2
        }
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for subView in pickerView.subviews {
            if subView.frame.size.height < 1 {
                subView.backgroundColor = UIColor.brown
            }
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width/3, height: 44))
        label.textColor = UIColor.brown
        label.textAlignment = .center
        if selectViewTitle == "生理期选择" {//四种生理期
            label.text = physiologicalArray[row]
        }else if selectViewTitle == "最后经期日期" || selectViewTitle == "宝宝生日" || selectViewTitle == "预产期" {//这里没有对日期进行逻辑处理，就是简单的功能实现，如出现9月份有31日的，你们自己设置的时候注意一下就好，我累了，不想写
            if component == 0 {//（2001-2017）
                label.text =  String(row+2001)
            }else if component == 1 {
                label.text =  String(row+1)
            }else {
                label.text =  String(row+1)
            }
        }else if selectViewTitle == "经期周期" {//两次经期的正常间隔（7-46）
            label.text =  String(row + 7)
        }else if selectViewTitle == "经期正常持续天数" {//从来月经到走（1-15）
            label.text =  String(row + 1)
        }else if selectViewTitle == "宝宝性别" {//男或者女
            label.text =  sexArray[row]
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            a = row
        }else if component == 1 {
            b = row
        }else {
            c = row
        }
    }
    
}













