//
//  ResourceManager.swift
//  MainApp
//
//  Created by Vina Rianti on 22/4/22.
//

import Foundation

class ResourceManager {
    let tag: String
    
    init(tag: String) {
        self.tag = tag
    }
    
    var currentRequest: NSBundleResourceRequest?
    
    func requestResourceWith(onSuccess: @escaping () -> Void, onFailure: @escaping( (NSError) -> Void)) {
        
        currentRequest = NSBundleResourceRequest(tags: [tag])
        
        guard let request = currentRequest else { return }
        
        request.beginAccessingResources { error in
            if let error = error {
                onFailure(error as NSError)
                return
            }
            onSuccess()
        }
    }
    
    func purgeResource() {
        guard let request = currentRequest else { return }
        request.endAccessingResources()
    }
}
