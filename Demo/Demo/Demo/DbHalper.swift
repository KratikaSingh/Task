//
//  DbHalper.swift
//  Demo
//
//  Created by fluper on 16/07/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import Foundation
import SQLite3
import UIKit

class DBHelper{
    init()  {
        db = openDatabase()
        createTable()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?  {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS student(Id INTEGER PRIMARY KEY,username TEXT,password TEXT,type INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("student table created.")
            } else {
                print("student table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(username:String, password:String, loginType:Int32?, completionClosure: @escaping (_ result: Any?) -> ()) -> Void {
        let users = read()
        for user in users  {
            if user.username == username  {
                let alert = UIAlertController(title: "Alert", message: "Username already exist", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                return
            }
        }
        
        guard let index  = loginType as? Int32 else {return}
        let insertStatementString = "INSERT INTO student (Id, username , password, type) VALUES (?,?,?,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(1))
            sqlite3_bind_text(insertStatement, 2, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 4, index)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                completionClosure("Done")
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [UserDetails] {
        let queryStatementString = "SELECT * FROM student;"
        var queryStatement: OpaquePointer? = nil
        var psns : [UserDetails] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let loginTyoe = sqlite3_column_int(queryStatement, 3)
                psns.append(UserDetails(username: username, password: password, loginType: loginTyoe))
                print("Query Result:")
                print("\(username) | \(password) | \(loginTyoe)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
}
