//
//  ViewController.swift
//  ColorButton
//
//  Created by 林祔利 on 2023/8/6.
//

import UIKit

class ViewController: UIViewController {

    /*
     1. 使用 N*N 陣列作為 data source 表示 UI 顏色與佈局。
     2. 每個色塊都是連在一起的矩形且不會互相覆蓋。
     3. 不同色塊會視為可操作元件綁定 touch event。
     4. 使用下面提供的 JSON raw data 預期會呈現如範例圖的 UI。
     */
    
    
    var colors = [
        ["blue", "blue",  "blue",   "purple"],
        ["black","black", "yellow", "purple"],
        ["black","black", "yellow", "green"],
        ["red",  "red",   "yellow", "green"]
      ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonSize: CGFloat = 60.0

        // for 一個顏色陣列
        for rowColor in 0..<colors.count {
            for col in 0..<colors[rowColor].count {
                //把顏色轉成一個變數
                let color = colors[rowColor][col]
                print("color \(color)")
                //創建一個 UIButton
                let colorButton = UIButton()
                colorButton.setTitle("", for: .normal)
                //設定一個String 轉 enum color 的顏色
                colorButton.backgroundColor =  colorFromString(color)
                colorButton.translatesAutoresizingMaskIntoConstraints = false
                //增加 event 的 tag 來使用 Button
                colorButton.tag = rowColor * colors[rowColor].count + col
                //設定一個 event function
                colorButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                view.addSubview(colorButton)
                
                //AutoLayout 排版
                NSLayoutConstraint.activate([
                    colorButton.widthAnchor.constraint(equalToConstant: buttonSize),
                    colorButton.heightAnchor.constraint(equalToConstant: buttonSize),
                    //使用 CGFloat 來計算每一格的位置 上方距離是 rowColor 0 * 60, 1 * 60, 2 * 60...
                    colorButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(rowColor) * (buttonSize)),
                    //使用 CGFloat 來計算每一格 左方的距離 col 0, 60, 120 ....
                    colorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(col) * (buttonSize))
                ])
                
            }
        }
    }
        
    //寫一個String 轉換 UIColor 的 function
    func colorFromString(_ colorString: String) -> UIColor {
            switch colorString {
            case "blue":
                return .blue
            case "black":
                return .black
            case "yellow":
                return .yellow
            case "purple":
                return .purple
            case "red":
                return .red
            case "green":
                return .green
            default:
                return .clear
            }
        }
    //增加事件
    @objc func buttonTapped(_ sender: UIButton) {
            let row = sender.tag / colors[0].count
            let col = sender.tag % colors[0].count
            let color = colors[row][col]
            print("Button tapped at row: \(row), col: \(col), color: \(color)")
        }

}

