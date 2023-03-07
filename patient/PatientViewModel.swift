
import Foundation
import SwiftUI


class PatientViewModel : ObservableObject {
        
static var instance : PatientViewModel? = nil
var cdb : FirebaseDB = FirebaseDB.getInstance()

var fileSystem : FileAccessor = FileAccessor()

static func getInstance() -> PatientViewModel {
if instance == nil
{ instance = PatientViewModel()
initialiseOclFile()
initialiseOclType() }
return instance! }

@Published var currentPatient : PatientVO? = PatientVO.defaultPatientVO()
@Published var currentPatients : [PatientVO] = [PatientVO]()

func createPatient(x : PatientVO) {
if let obj = getPatientByPK(val: x.patientId)
{ cdb.persistPatient(x: obj) }
else {
let item : Patient = createByPKPatient(key: x.patientId)
item.patientId = x.getPatientId()
item.name = x.getName()
item.appointmentId = x.getAppointmentId()
cdb.persistPatient(x: item)
}
currentPatient = x
}

func cancelCreatePatient() {
//cancel function
}

func deletePatient(id : String) {
if let obj = getPatientByPK(val: id)
{ cdb.deletePatient(x: obj) }
}

func cancelDeletePatient() {
//cancel function
}

func cancelEditPatient() {
//cancel function
}


func addPatientattendsAppointment(x: String, y: String) {
if let obj = getPatientByPK(val: y) {
obj.appointmentId = x
cdb.persistPatient(x: obj)
}
}

func cancelAddPatientattendsAppointment() {
//cancel function
}

func removePatientattendsAppointment(x: String, y: String) {
if let obj = getPatientByPK(val: y) {
obj.appointmentId = "NULL"
cdb.persistPatient(x: obj)
}
}

func cancelRemovePatientattendsAppointment() {
//cancel function
}

func listPatient() -> [PatientVO] {
currentPatients = [PatientVO]()
let list : [Patient] = PatientAllInstances
for (_,x) in list.enumerated()
{ currentPatients.append(PatientVO(x: x)) }
return currentPatients
}

func loadPatient() {
let res : [PatientVO] = listPatient()

for (_,x) in res.enumerated() {
let obj = createByPKPatient(key: x.patientId)
obj.patientId = x.getPatientId()
obj.name = x.getName()
obj.appointmentId = x.getAppointmentId()
}
currentPatient = res.first
currentPatients = res
}

func stringListPatient() -> [String] {
var res : [String] = [String]()
for (_,obj) in currentPatients.enumerated()
{ res.append(obj.toString()) }
return res
}

func searchByPatientpatientId(val : String) -> [PatientVO] {
var resultList: [PatientVO] = [PatientVO]()
let list : [Patient] = PatientAllInstances
for (_,x) in list.enumerated() {
if (x.patientId == val) {
resultList.append(PatientVO(x: x))
}
}
return resultList
}

func searchByPatientname(val : String) -> [PatientVO] {
var resultList: [PatientVO] = [PatientVO]()
let list : [Patient] = PatientAllInstances
for (_,x) in list.enumerated() {
if (x.name == val) {
resultList.append(PatientVO(x: x))
}
}
return resultList
}

func searchByPatientappointmentId(val : String) -> [PatientVO] {
var resultList: [PatientVO] = [PatientVO]()
let list : [Patient] = PatientAllInstances
for (_,x) in list.enumerated() {
if (x.appointmentId == val) {
resultList.append(PatientVO(x: x))
}
}
return resultList
}


func getPatientByPK(val: String) -> Patient?
{ return Patient.patientIndex[val] }

func retrievePatient(val: String) -> Patient?
{ return Patient.patientIndex[val] }

func allPatientids() -> [String] {
var res : [String] = [String]()
for (_,item) in currentPatients.enumerated()
{ res.append(item.patientId + "") }
return res
}

func setSelectedPatient(x : PatientVO)
{ currentPatient = x }

func setSelectedPatient(i : Int) {
if i < currentPatients.count
{ currentPatient = currentPatients[i] }
}

func getSelectedPatient() -> PatientVO?
{ return currentPatient }

func persistPatient(x : Patient) {
let vo : PatientVO = PatientVO(x: x)
cdb.persistPatient(x: x)
currentPatient = vo
}

func editPatient(x : PatientVO) {
if let obj = getPatientByPK(val: x.patientId) {
obj.patientId = x.getPatientId()
obj.name = x.getName()
obj.appointmentId = x.getAppointmentId()
cdb.persistPatient(x: obj)
}
currentPatient = x
}

}
