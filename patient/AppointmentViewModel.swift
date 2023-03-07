	                  
import Foundation
import SwiftUI

class AppointmentViewModel : ObservableObject {
		                      
	static var instance : AppointmentViewModel? = nil
	var db : DB?
		
	// path of document directory for SQLite database (absolute path of db)
	let dbpath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> AppointmentViewModel {
		if instance == nil
	     { instance = AppointmentViewModel()
	       initialiseOclFile()
	       initialiseOclType() }
	    return instance! }
	                          
	init() { 
		// init
		db = DB.obtainDatabase(path: "\(dbpath)/myDatabase.sqlite3")
		loadAppointment()
	}
	      
	@Published var currentAppointment : AppointmentVO? = AppointmentVO.defaultAppointmentVO()
	@Published var currentAppointments : [AppointmentVO] = [AppointmentVO]()

	func createAppointment(x : AppointmentVO) {
		let res : Appointment = createByPKAppointment(key: x.appointmentId)
			res.appointmentId = x.appointmentId
		res.code = x.code
	    currentAppointment = x

	    do { try db?.createAppointment(appointmentvo: x) }
	    catch { print("Error creating Appointment") }
	}
	
	func cancelCreateAppointment() {
		//cancel function
	}

	func cancelEditAppointment() {
	//cancel function
}

	func deleteAppointment(id : String) {
		 if db != nil
	      { db!.deleteAppointment(val: id) }
	     	currentAppointment = nil
	}
		
	func cancelDeleteAppointment() {
		//cancel function
	}

	func loadAppointment() {
		let res : [AppointmentVO] = listAppointment()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKAppointment(key: x.appointmentId)
	        obj.appointmentId = x.getAppointmentId()
        obj.code = x.getCode()
			}
		 currentAppointment = res.first
		 currentAppointments = res
		}
		
  		func listAppointment() -> [AppointmentVO] {
			if db != nil
			{ currentAppointments = (db?.listAppointment())!
			  return currentAppointments
			}
			currentAppointments = [AppointmentVO]()
			let list : [Appointment] = AppointmentAllInstances
			for (_,x) in list.enumerated()
			{ currentAppointments.append(AppointmentVO(x: x)) }
			return currentAppointments
		}
				
		func stringListAppointment() -> [String] { 
			currentAppointments = listAppointment()
			var res : [String] = [String]()
			for (_,obj) in currentAppointments.enumerated()
			{ res.append(obj.toString()) }
			return res
		}
				
		func getAppointmentByPK(val: String) -> Appointment? {
			var res : Appointment? = Appointment.getByPKAppointment(index: val)
			if res == nil && db != nil
			{ let list = db!.searchByAppointmentappointmentId(val: val)
			if list.count > 0
			{ res = createByPKAppointment(key: val)
			}
		  }
		  return res
		}
				
		func retrieveAppointment(val: String) -> Appointment? {
			let res : Appointment? = getAppointmentByPK(val: val)
			return res 
		}
				
		func allAppointmentids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentAppointments.enumerated()
			{ res.append(item.appointmentId + "") }
			return res
		}
				
		func setSelectedAppointment(x : AppointmentVO)
			{ currentAppointment = x }
				
		func setSelectedAppointment(i : Int) {
			if 0 <= i && i < currentAppointments.count
			{ currentAppointment = currentAppointments[i] }
		}
				
		func getSelectedAppointment() -> AppointmentVO?
			{ return currentAppointment }
				
		func persistAppointment(x : Appointment) {
			let vo : AppointmentVO = AppointmentVO(x: x)
			editAppointment(x: vo)
		}
			
		func editAppointment(x : AppointmentVO) {
			let val : String = x.appointmentId
			let res : Appointment? = Appointment.getByPKAppointment(index: val)
			if res != nil {
			res!.appointmentId = x.appointmentId
		res!.code = x.code
		}
		currentAppointment = x
			if db != nil
			 { db!.editAppointment(appointmentvo: x) }
		 }
			
	    func cancelAppointmentEdit() {
	    	//cancel function
	    }
	    
 	func searchByAppointmentappointmentId(val : String) -> [AppointmentVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByAppointmentappointmentId(val: val))!
		          return res
		        }
		    currentAppointments = [AppointmentVO]()
		    let list : [Appointment] = AppointmentAllInstances
		    for (_,x) in list.enumerated()
		    { if x.appointmentId == val
		      { currentAppointments.append(AppointmentVO(x: x)) }
		    }
		    return currentAppointments
		  }
		  
 	func searchByAppointmentcode(val : String) -> [AppointmentVO]
		  { 
		      if db != nil
		        { let res = (db?.searchByAppointmentcode(val: val))!
		          return res
		        }
		    currentAppointments = [AppointmentVO]()
		    let list : [Appointment] = AppointmentAllInstances
		    for (_,x) in list.enumerated()
		    { if x.code == val
		      { currentAppointments.append(AppointmentVO(x: x)) }
		    }
		    return currentAppointments
		  }
        
	}
