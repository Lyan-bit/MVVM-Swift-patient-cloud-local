              
              
import SwiftUI
import Firebase

@main 
struct patientMain : App {
			
	init() {
	    FirebaseApp.configure()
	       }

	var body: some Scene {
	        WindowGroup {
                ContentView(model: PatientViewModel.getInstance(), appModel: AppointmentViewModel.getInstance())
	        }
	    }
	} 
