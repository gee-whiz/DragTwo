//
//  ViewController.swift
//  DragTwo
//
//  Created by George Kapoya on 2017/06/16.
//  Copyright © 2017 immedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addInteraction(UIDropInteraction(delegate: self))
        
        
        
    }

    
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        for item in session.items {
            item.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: {(obj, err) in
                if let err = err {
                    print("Errror ", err)
                }
                
                guard let draggedItem = obj as? UIImage else {return}
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: draggedItem)
                    self.view.addSubview(imageView)
                    let centerPoint = session.location(in: self.view)
                    
                    imageView.center = centerPoint
                }
         })
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        
        return UIDropProposal(operation: .copy)
    }

}

