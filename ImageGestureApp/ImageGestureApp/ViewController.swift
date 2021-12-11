//
//  ViewController.swift
//  ImageGestureApp
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let myView:UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    
    private let myImageView:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds=true
        return imageView
    }()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myView)
        
        myView.addSubview(myImageView)
        imagePicker.delegate=self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        myView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchGesture))
        myView.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotateView))
        myView.addGestureRecognizer(rotationGesture)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        rightSwipe.direction = .right
        myView.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .left
        myView.addGestureRecognizer(leftSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .up
        myView.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        downSwipe.direction = .down
        myView.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        myView.addGestureRecognizer(panGesture)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 460)
        
        myImageView.frame=CGRect(x: 20 , y: 50, width: myView.frame.size.width-40, height: 400)
        
    }
}

extension ViewController{
    @objc private func didTapView(gesture: UITapGestureRecognizer){
        print("gallery called")
                imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @objc private func didPinchGesture(gesture: UIPinchGestureRecognizer){
        myImageView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func didRotateView(gesture: UIRotationGestureRecognizer){
        myImageView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    @objc private func didSwipeView(gesture: UISwipeGestureRecognizer){
        if gesture.direction == .left{
            UIView.animate(withDuration: 0.5){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x - 40, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            }
        }else if gesture.direction == .right{
            UIView.animate(withDuration: 0.5){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x + 40, y: self.myImageView.frame.origin.y, width: 200, height: 200)
            }
            
        }else if gesture.direction == .up{
            UIView.animate(withDuration: 0.5){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y - 40, width: 200, height: 200)
            }
        }else if gesture.direction == .down{
            UIView.animate(withDuration: 0.5){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x, y: self.myImageView.frame.origin.y + 40, width: 200, height: 200)
            }
        }
    }
    @objc private func didPanView(gesture: UIPanGestureRecognizer){
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        myImageView.center = CGPoint(x: x, y: y)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       picker.dismiss(animated: true, completion: nil)
        
        if let selectImage = info[.originalImage] as? UIImage{
            myImageView.image=selectImage
        }
    }
}
