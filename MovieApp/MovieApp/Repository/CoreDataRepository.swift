//
//  CoreDataRepository.swift
//  MovieApp
//
//  Created by Bach Nghiem on 26/09/2023.
//

import UIKit
import Foundation
import CoreData

protocol CoreDataRepository {
    func getAll() -> [MovieLocal]
    func add(movie: Movie, baseURLVideo: String)
    func remove(name: String)
}

class CoreDataRepositoryImpl: CoreDataRepository {
    private let persistentContainer: NSPersistentContainer
    init() {
        persistentContainer = NSPersistentContainer(name: "MovieLocal")
        persistentContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func getAll() -> [MovieLocal] {
        var myListArray = [MovieLocal]()
        do {
            myListArray = try persistentContainer.viewContext.fetch(MovieLocal.fetchRequest())
        } catch {
            print("Can't fetch core data items")
        }
        return myListArray
    }

    func add(movie: Movie, baseURLVideo: String) {
        let coreData = MovieLocal(context: persistentContainer.viewContext)
        coreData.urlVideo = baseURLVideo
        coreData.urlImage =  movie.posterPath ?? ""
        coreData.name = movie.title 
        coreData.desc = movie.overview ?? ""
        coreData.date = movie.releaseDate ?? ""
        saveContext()
    }

    func remove(name: String) {
        let fetchRequest: NSFetchRequest<MovieLocal> = MovieLocal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let matchingUsers = try persistentContainer.viewContext.fetch(fetchRequest)
            if let userToDelete = matchingUsers.first {
                persistentContainer.viewContext.delete(userToDelete)
                try persistentContainer.viewContext.save()
            }
        } catch {
            print("Error fetching or deleting user: \(error)")
        }
    }
    
    func isExistInFavouriteList(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<MovieLocal> = MovieLocal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let matchingUsers = try persistentContainer.viewContext.fetch(fetchRequest)
            return !matchingUsers.isEmpty
        } catch {
            return false
        }
    }
    
    private func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
