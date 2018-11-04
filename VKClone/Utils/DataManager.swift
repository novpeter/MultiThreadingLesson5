//
//  DataManager.swift
//  VKClone
//
//  Created by Петр on 04/11/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import Foundation

final class DataManager: DataProtocol {

    static let instance = DataManager()
    var models: [Model]
    var user: User
    
    private init() {
        models = Generator().generateRandomModels()
        user = Generator().getRandomUser()
    }
    
    func obtainData(completionBlock: @escaping ([Model]) -> Void) {
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 2) {
            completionBlock(self.models)
        }
    }
    
    // MARK: - Operation queues
    
    private lazy var searchOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Search operation queue"
        
        return queue
    }()
    
    private lazy var addOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Add operation queue"
        
        return queue
    }()
    
    private lazy var saveOperationQueue: OperationQueue = {
        
        let queue = OperationQueue()
        queue.name = "Save operation queue"
        
        return queue
    }()
    
    
    // MARK: - Search model
    
    func syncSearchModel(id: String) -> Model? {
        return models.filter{ model in model.id == id}[0]
    }
    
    func asyncSearchModel(id: String, completionBlock: @escaping (Model?) -> Void) {
        searchOperationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            
            completionBlock(strongSelf.models.filter{ model in model.id == id}[0])
        }
    }
    

    // MARK: - Add model
    
    func syncAddModel(model: Model) {
        var newModels: [Model] = [model]
        newModels += models
        models = newModels
    }
    
    func asyncAddModel(model: Model, completionBlock: @escaping () -> (Bool)) {
        addOperationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            
            var newModels: [Model] = [model]
            newModels += strongSelf.models
            strongSelf.models = newModels
            
            completionBlock()
        }
    }
    
    
    // MARK: - Save model
    
    func syncSaveModel(model: Model) {
        
        let index = models.firstIndex { (oldModel) -> Bool in
            oldModel.id == model.id
        }
        models.insert(model, at: index ?? models.count)
    }
    
    func asyncSaveModel(model: Model, completionBlock: @escaping () -> (Bool)) {
        saveOperationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            
            let index = strongSelf.models.firstIndex { (oldModel) -> Bool in
                oldModel.id == model.id
            }
            strongSelf.models.insert(model, at: index ?? strongSelf.models.count)
            
            completionBlock()
        }
    }
    
}
