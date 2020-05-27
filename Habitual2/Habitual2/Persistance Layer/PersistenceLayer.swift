//
//  PersistenceLayer.swift
//  Habitual2
//
//  Created by Cao Mai on 5/25/20.
//  Copyright © 2020 Make School. All rights reserved.
//

import Foundation

struct PersistanceLayer {
    private(set) var habits: [Habit] = []
    
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    private mutating func loadHabits() {
        let userDefault = UserDefaults.standard
        
        guard let habitData = userDefault.data(forKey: PersistanceLayer.userDefaultsHabitsKeyValue),
              let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {return}
        
        self.habits = habits
    }
    
    @discardableResult
    
    mutating func createNewHabit(name: String, image: Habit.Images) -> Habit {
        let newHabit = Habit(title: name, image: image)
        self.habits.insert(newHabit, at: 0)
        self.saveHabits()
        
        return newHabit
    }
    
    private func saveHabits() {
        guard let habitsData = try? JSONEncoder().encode(self.habits) else { fatalError("Could not encode habit")}
        let userDefault = UserDefaults.standard
        userDefault.set(habitsData, forKey: PersistanceLayer.userDefaultsHabitsKeyValue)
        userDefault.synchronize()
    }
    
    mutating func delete(_ habitIndex: Int) {
        self.habits.remove(at: habitIndex)
        
        self.saveHabits()
    }
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        var updatedHabit = self.habits[habitIndex]
        
        guard updatedHabit.completedToday == false else {return updatedHabit}
        updatedHabit.numberOfCompletions += 1
        
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }
        
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        
        let now = Date()
        updatedHabit.lastCompletionDate = now
        
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
        return updatedHabit
    }
    
    // To swap habits location
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
    
}
