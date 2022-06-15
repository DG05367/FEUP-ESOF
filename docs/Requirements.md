
## Requirements

In this section, we describe all kinds of requirements for our module: functional and non-functional requirements.

### Use case model 

 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/3LEIC06T5/blob/main/images/ClassDiagram.png"/>
</p>

|||
| --- | --- |
| Name | View Schedule |
| Actor |  Student | 
| Description | The student is able to open his schedule or other schedules accordingly to his will.|
| Preconditions | - The need for a student to log in using their credentials.<br> - Chosen schedule.|
| Postconditions | - The student gets access to the schedule selected. |
| Normal flow | 1. The student accesses the Interactive Schedule app.<br>2. The student clicks on Schedule. <br>3. The schedule shows up.|
| Alternative flows and exceptions | 1.  If the student has changed his schedule, then is shown his last saved schedule.|

|||
| --- | --- |
| Name | Change Schedule |
| Actor |  Student | 
| Description | While using this app, the student is able to view different theorical classes from other timetables and save it as their own.|
| Preconditions | - The need for a student to log in using their credentials.|
| Postconditions | - The student is able to make changes to his schedule.  |
| Normal flow | 1. The student accesses the Interactive Schedule app.<br> 2. The app shows the schedule with the saved changes if there are any.<br> 3. The student selects a class. <br> 4. If the class is theoretical and others exist at the same time, it shows different class options.<br> 5. In all the classes, the professors' information is displayed, as well as the option to check the class's information.<br> 6. The student can save a new selected class as their own.|
| Alternative flows and exceptions | The student can't view other class options to pratical classes.|

|||
| --- | --- |
| Name | View Map |
| Actor |  Student | 
| Description | The student is able to consult the path to a classroom, whether he chooses the specific classroom or it is the next class he has. |
| Preconditions | - The student is logged in. |
| Postconditions | - The map is show with the indications to the classroom. |
| Normal flow | 1. The student selects the app option. <br> 2. The system asks which classroom the student wants to find the path to. <br> 3. The system shows an option asking where should the path's origin be. <br> 4. The system shows an animation with the steps needed to find the classroom in the building.<br> 5. The student may swipe through the steps to understand better what path he needs to take. |
| Alternative flows and exceptions | 1. [Schedule choice] The student selects his schedule. <br> 2. The student's schedule is displayed, where after selecting a class, an option to find it shows. <br> 3. The student selects the find option from the desired class. <br> 4. The system shows an option asking where should the path's origin be. <br> 5. The system shows an animation with the steps needed to find the classroom in the building.<br> 6. The student may swipe through the steps to understand better what path he needs to take. <br> 1. [Notification alert] The student receives a notification warning him that his next class is soon. <br> 2. The students selects the notification showing him some information and an option to find the classroom. <br> 3. The student selects the find option. <br> 4. The system shows an option asking where should the path's origin be. <br> 5. The system shows an animation with the steps needed to find the classroom in the building.<br> 6. The student may swipe through the steps to understand better what path he needs to take.<br>1.[Clean Map] The student accesses the app. <br>2. The student selects the map.<br>3. The map shows up with no indications.|

|||
| --- | --- |
| Name | View Calendar |
| Actor |  Student | 
| Description | When using this app, the student can view this year's calendar, so he can keep up with all the events.|
| Preconditions | - The need for a student to log in using their credentials.|
| Postconditions | - The student is presented with the Calendar  |
| Normal flow | 1. The student logs in on the Interactive Schedule App.<br> 2. The student clicks on Calendar.<br> 3. The app shows the Calendar on the current day. <br>|
| Alternative flows and exceptions | 1. The student can click on specific days to set new events. <br> 2. The student can click on specific days to check all the events on that day.|

|||
| --- | --- |
| Name | Manage Notifications |
| Actor |  Student | 
| Description | The student is able to open the notifications tab and change the notification options.|
| Preconditions | - The need for a student to log in using their credentials.|
| Postconditions | - The student gets access to the options menu. |
| Normal flow | 1. The student accesses the Interactive Schedule app.<br>2. He chooses the notification tab.<br>3. He then can change the options accordingly to his will.|
| Alternative flows and exceptions | 1.  The student can turn off notifications.<br>2. The student can choose when to receive notifications. Ex. 10 minutes before the class.|


### Domain model

 <p align="center" justify="center">
  <img src="https://github.com/LEIC-ES-2021-22/3LEIC06T5/blob/main/images/DomainModel.png"/>
</p>

-**Class:** Saves all the information about the classes from timestamps, classroom, which teacher teaches the class and what is the class subject.

-**Schedule:** Displays a list of classes.

-**User:** Saves the student number (id) and his name.

-**Calendar:** Shows a list of events to be displayed.

-**Event:** An event can be of any type. Each needing a date of occurring and a name.

-**Map:** Has the current location and the destination, so a route can be made.
