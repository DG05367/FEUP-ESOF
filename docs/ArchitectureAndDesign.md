## Architecture and Design

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture

The purpose of this subsection is to document the high-level logical structure of the code (Logical View), using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

_UML package diagram_ showing a _logical view_ of the Interactive Schedule App 

 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/3LEIC06T5/blob/main/images/logical_arquitecture.png"/>
</p>

*Schedule Database Schema* - Database with all the schedules possible. <br>
*App GUI* - What can be physically seen in the application. <br>
*Interactive Schedule Model* - has the logged in student's schedule. <br>
*sigarra* - provides the data needed about the students, professors, classes and schedules. <br>
*Google Maps* - provides the classrooms' locations. <br>
*Firebase* - needed to send notifications.

### Physical architecture

The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams (Deployment View) or component diagrams (Implementation View), separate or integrated, showing the physical structure of the system.

_UML deployment diagram_ showing a _deployment view_ of the Interactive Schedule App:

 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/3LEIC06T5/blob/main/images/physical_architecture.png"/>
</p>

*Smartphone* - Where the app runs
*Backend Server* -  Sigarra, provides all the information for the app to run properly.
*Google Server* - Provides the college map.
*Firebase* - Database for the notifications.


### Vertical prototype

The user story implemented is the Login page, which was made using an Icon called alarm_on, two TextFormFields for the username and password, the second having the text hidden which can be shown when pressing the eye Icon. After the two TextFormFields there is a custom made checkbox followed by a Text. Lastly there is a Text with "Iniciar Sessão" written that changes the page when pressed to the default flutter page. Since there is no backend yet, the validation is not implemmented. The process described in the snapshots below is inserting "202012345" in the "Utilizador" field, inserting "senha" in the "Senha" field, clicking on the eye icon to show the password, checking the "Lembrar-me" checkbox and lastly pressing "Iniciar Sessão", leading to the Home Page on the last snapshot.

<p float = "left">
<img src="https://user-images.githubusercontent.com/75994325/162643046-5f55ff80-8fb1-41d5-b7fa-2d315c48e541.png" width="180" height="400">
<img src="https://user-images.githubusercontent.com/75994325/162643053-0fef6043-502f-48da-a5da-e2eccd6787c3.png" width="180" height="400">
<img src="https://user-images.githubusercontent.com/75994325/162643074-bd0267a1-511f-4b64-9adc-6f1292d0555e.png" width="180" height="400">
<img src="https://user-images.githubusercontent.com/75994325/162643092-fb116c16-8dcd-48f7-8d1a-080e5a5d34ec.png" width="180" height="400">
<img src="https://user-images.githubusercontent.com/75994325/162643103-ec4f0018-1787-4c9e-8351-20644c19aef2.png" width="180" height="400">
<img src="https://user-images.githubusercontent.com/75994325/162643106-91da8906-af6b-4633-9fbf-720538893e0e.png" width="180" height="400">
</p>
