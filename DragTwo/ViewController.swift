//
//  ViewController.swift
//  DragTwo
//
//  Created by George Kapoya on 2017/06/16.
//  Copyright © 2017 immedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDropInteractionDelegate,UIDragInteractionDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addInteraction(UIDropInteraction(delegate: self))
        
        view.addInteraction(UIDragInteraction(delegate: self ))
    }
    
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let itemsTouch = session.location(in: self.view)
        if let touchedImageView = self.view.hitTest(itemsTouch, with: nil)  as? UIImageView {
            
            let touchedImage = touchedImageView.image
            
            
            let itemProvider = NSItemProvider(object: touchedImage!)
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = touchedImageView
            
            return [dragItem]
        }
        
        return []
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        
        
        return UITargetedDragPreview(view: item.localObject as! UIView)
    }
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        
        return UIDropProposal(operation: .copy)
    }
    
    
    func  dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        for item in session.items {
            item.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (obj, err) in
                if let err = err {
                    print("Error  ", err)
                }
                
                guard  let draggedImage = obj as? UIImage else {return}
                
                DispatchQueue.main.sync {
                    let imageView = UIImageView(image: draggedImage)
                    imageView.isUserInteractionEnabled = true
                    self.view.addSubview(imageView)
                    
                    let centerPoint = session.location(in: self.view)
                    
                    imageView.center = centerPoint;
                }
                
                
                
            }
            )
        }
    }
    
    
    
}


