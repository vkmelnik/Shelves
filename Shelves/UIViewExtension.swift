//
//  UIViewExtension.swift
//  vkmelnikCW2
//
//  Created by Всеволод on 17.09.2021.
//

import UIKit

extension UIView {
    func pinLeft(to: NSLayoutXAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(
            equalTo: to,
            constant: CGFloat(const)
        ).isActive = true
    }
    
    func pinLeft(view: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: CGFloat(const)
        ).isActive = true
    }
    
    func pinRight(to: NSLayoutXAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(
            equalTo: to,
            constant: -CGFloat(const)
        ).isActive = true
    }
    
    func pinRight(view: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -CGFloat(const)
        ).isActive = true
    }
    
    func pinTop(to: NSLayoutYAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(
            equalTo: to,
            constant: CGFloat(const)
        ).isActive = true
    }
    
    func pinTop(view: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: CGFloat(const)
        ).isActive = true
    }

    
    func pinBottom(to: NSLayoutYAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(
            equalTo: to,
            constant: -CGFloat(const)
        ).isActive = true
    }
    
    func pinBottom(view: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -CGFloat(const)
        ).isActive = true
    }
    
    func pin(to view: UIView, _ const: Double = 0) {
        pinLeft(view: view, const)
        pinRight(view: view, const)
        pinTop(view: view, const)
        pinBottom(view: view, const)
    }
    
    func setHeight(_ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: CGFloat(const)).isActive = true
    }
    
    func setWidth(_ const: Double) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: CGFloat(const)).isActive = true
    }
    
    func pinCenter(to view: UIView, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(
            equalTo: view.centerXAnchor,
            constant: CGFloat(const)
        ).isActive = true
        centerYAnchor.constraint(
            equalTo: view.centerYAnchor,
            constant: CGFloat(const)
        ).isActive = true
    }
    
    func pinCenter(to xAnchor: NSLayoutXAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(
            equalTo: xAnchor,
            constant: CGFloat(const)
        ).isActive = true
    }
    
    func pinCenter(to yAnchor: NSLayoutYAxisAnchor, _ const: Double = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(
            equalTo: yAnchor,
            constant: CGFloat(const)
        ).isActive = true
    }
    
    func castShadowInside() {
        self.layer.masksToBounds = false;
        self.layer.cornerRadius = 15; // if you like rounded corners
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        let indent = CGFloat(10);
        let innerRect = CGRect(x: indent,y: indent,width: self.frame.size.width-2*indent,height: self.frame.size.height-2*indent);
        self.layer.shadowPath = UIBezierPath(roundedRect: innerRect, cornerRadius: 15).cgPath
    }
}
