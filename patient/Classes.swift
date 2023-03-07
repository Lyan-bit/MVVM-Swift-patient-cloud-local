//
//  classes.swift
//  patient
//
//  Created by Lyan Alwakeel on 06/03/2023.
//

import Foundation

/* This code requires OclFile.swift */

func initialiseOclFile()
{
  //let systemIn = createByPKOclFile(key: "System.in")
  //let systemOut = createByPKOclFile(key: "System.out")
  //let systemErr = createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
    
  let patientOclType = createByPKOclType(key: "Patient")
  patientOclType.actualMetatype = Patient.self

  let patientPatientId = createOclAttribute()
        patientPatientId.name = "patientId"
        patientPatientId.type = stringOclType
        patientOclType.attributes.append(patientPatientId)
  let patientName = createOclAttribute()
        patientName.name = "name"
        patientName.type = stringOclType
        patientOclType.attributes.append(patientName)
  let patientAppointmentId = createOclAttribute()
        patientAppointmentId.name = "appointmentId"
        patientAppointmentId.type = stringOclType
        patientOclType.attributes.append(patientAppointmentId)
  let appointmentOclType = createByPKOclType(key: "Appointment")
  appointmentOclType.actualMetatype = Appointment.self

  let appointmentAppointmentId = createOclAttribute()
        appointmentAppointmentId.name = "appointmentId"
        appointmentAppointmentId.type = stringOclType
        appointmentOclType.attributes.append(appointmentAppointmentId)
  let appointmentCode = createOclAttribute()
        appointmentCode.name = "code"
        appointmentCode.type = stringOclType
        appointmentOclType.attributes.append(appointmentCode)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
    { let jdata = json.data(using: .utf8)!
      let decoder = JSONDecoder()
      if typeName == "String"
      { let x = try? decoder.decode(String.self, from: jdata)
          return x as AnyObject
      }
if typeName == "Patient"
  { let x = try? decoder.decode(Patient.self, from: jdata)
  return x
}
if typeName == "Appointment"
  { let x = try? decoder.decode(Appointment.self, from: jdata)
  return x
}
  return nil
    }

