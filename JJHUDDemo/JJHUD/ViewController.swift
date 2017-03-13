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

    @IBOutlet weak var pattern: PatternView!
    
    @IBOutlet var buttonCollect: [UIButton]! {
        didSet {
            buttonCollect.forEach {
                $0.isHidden = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pattern.setRhombusPattern()
        self.pattern.color = UIColor.white
        self.pattern.alpha = 0.1
        self.pattern.cellWidthMax = 70
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
//        JJHUD.showLoading()
        JJHUD.showLoading(text: "加载中\n五秒后消失")

        JJHUD.hide(delay: 5)
    }

    @IBAction func textButtonClick(_ sender: Any) {
        JJHUD.showText(text: "Hello,World!", delay: delay)
    }

    @IBAction func text2ButtonClick(_ sender: Any) {
        let hud = JJHUD(text: "锄禾日当午汗滴禾下土", type: .text, delay: 0)
        hud.backgroundColor = UIColor(red: 18/255, green: 112/255, blue: 238/255, alpha: 0.9)
        hud.show()
        hud.hide(delay: 3)
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


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

