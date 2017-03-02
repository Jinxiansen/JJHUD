//
//  ViewController.swift
//  JJHUD
//
//  Created by 晋先森 on 17/2/28.
//  Copyright © 2017年 晋先森. All rights reserved.
//

import UIKit

private let delay : TimeInterval = 1

class ViewController: UIViewController {

    @IBOutlet var buttonCollect: [UIButton]! {
        didSet {
            buttonCollect.forEach {
                $0.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func successButtonClick(_ sender: Any) {
        
         JJHUD.showSuccess(text: "加载成功", delay: delay)
    }

    @IBAction func errorButtonClick(_ sender: Any) {
        JJHUD.showError(text: "加载失败", delay: delay)
    }

    @IBAction func infoButtonClick(_ sender: Any) {
        JJHUD.showInfo(text: "请先注册", delay: delay)
    }

    @IBAction func loadingButtonClick(_ sender: Any) {
        JJHUD.showLoading()
//        JJHUD.showLoading(text: "加载中")
    }


    @IBAction func textButtonClick(_ sender: Any) {
        JJHUD.showText(text: "Hello,World!", delay: delay)
    }

    @IBAction func text2ButtonClick(_ sender: Any) {
        let hud = JJHUD(text: "无人问我粥可温\n无人与我共黄昏", type: .text, delay: 0)
        hud.backgroundColor = UIColor(red: 98/255, green: 162/255, blue: 238/255, alpha: 0.9)
        hud.show()
        hud.hide(delay: delay)
    }

    @IBAction func hideButtonClick(_ sender: UIButton) {

         JJHUD.hide()

        if sender.isSelected {
            sender.isSelected = false
            showButtonCollect()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showButtonCollect()
    }

    func showButtonCollect() {

        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
            self.buttonCollect.forEach({
                $0.isHidden = !$0.isHidden
            })

        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

