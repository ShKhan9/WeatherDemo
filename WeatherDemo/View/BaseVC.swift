//
//  ViewController.swift
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

import UIKit
class BaseVC: UIViewController {
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isLight ? .darkContent : .lightContent
    }
     
}
