              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : PatientViewModel
    @ObservedObject var appModel : AppointmentViewModel
    
	                                       
	var body: some View {
		TabView {
            CreatePatientScreen (model: model).tabItem { 
                        Image(systemName: "1.square.fill")
	                    Text("+Patient")} 
            ListPatientScreen (model: model).tabItem { 
                        Image(systemName: "2.square.fill")
	                    Text("ListPatient")} 
            EditPatientScreen (model: model).tabItem { 
                        Image(systemName: "3.square.fill")
	                    Text("EditPatient")} 
            DeletePatientScreen (model: model).tabItem { 
                        Image(systemName: "4.square.fill")
	                    Text("-Patient")} 
            CreateAppointmentScreen (model: appModel).tabItem {
                        Image(systemName: "5.square.fill")
	                    Text("+Appointment")} 
            ListAppointmentScreen ().tabItem {
                        Image(systemName: "6.square.fill")
	                    Text("ListAppointment")} 
            EditAppointmentScreen (model: appModel).tabItem {
                        Image(systemName: "7.square.fill")
	                    Text("EditAppointment")} 
            DeleteAppointmentScreen (model: appModel).tabItem {
                        Image(systemName: "8.square.fill")
	                    Text("-Appointment")} 
            AddPatientattendsAppointmentScreen (model: model, appModel: appModel).tabItem {
                        Image(systemName: "9.square.fill")
	                    Text("AddPatientattendsAppointment")} 
            RemovePatientattendsAppointmentScreen (model: model, appModel: appModel).tabItem {
                        Image(systemName: "10.square.fill")
	                    Text("RemovePatientattendsAppointment")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: PatientViewModel.getInstance(), appModel: AppointmentViewModel.getInstance())
    }
}

