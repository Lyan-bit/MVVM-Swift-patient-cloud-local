
import SwiftUI

struct AddPatientattendsAppointmentScreen: View { 
	@State var x :String = ""
  	@State var y :String = ""

  	@ObservedObject var model : PatientViewModel
    @ObservedObject var appModel: AppointmentViewModel

  var body: some View {
	  	NavigationView {
	  		ScrollView {
    VStack(spacing: 20) {
	   HStack (spacing: 20) {
		  Text("patientId:").bold()
		  Divider()
	      Picker("Patient", selection: $y) { 
	      	ForEach(model.currentPatients) { Text($0.patientId).tag($0.patientId)}
	      }.pickerStyle(.menu)
	   }.frame(width: 200, height: 30).border(Color.gray)

	   HStack (spacing: 20) {
		  Text("appointmentId:").bold()
		  Divider()
	      Picker("Appointment:", selection: $x) { 
	      	ForEach(appModel.currentAppointments) { Text($0.appointmentId).tag($0.appointmentId)}
	      }.pickerStyle(.menu)
	   }.frame(width: 200, height: 30).border(Color.gray)

      HStack(spacing: 20) {
        Button(action: { self.model.addPatientattendsAppointment(x: x, y: y) } ) { Text("Add") }
        Button(action: { self.model.cancelAddPatientattendsAppointment() } ) { Text("Cancel") }
      }.buttonStyle(.bordered)
    }.padding(.top).onAppear(perform: 
                {
                	model.listPatient()
                	appModel.listAppointment()
                  y = model.currentPatient?.patientId ?? "id"
                  x = appModel.currentAppointment?.appointmentId ?? "id"})
     }.navigationTitle("addPatientattendsAppointment")
    }
  }
}
