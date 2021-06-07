


Scene module follow VIPER layout architecture

View <-> Presenter <-> Interacter <-> Worker (service)
           ^
           |
           v
           router
           
 There is Router to handle routing between scene. Can build tree router
 There is scene class act as scene factory to hide the complex of generate scene follow the VIPER
 

Mutliple theme: There are popular ways to handle 
- Each base control handle itself by listening the notification change theme to update 
- ViewController, View listen to notificaiton change theme to reload children view
 In this code using first option with theme config by file plist so can update on demand
 
 About the layout: Sorry for my BAD layout, i not good at design, to make it look good will
 take much time but i need finish soon to back to tasks from team.

 About unit test: Because limit time, i just focus on write unit test for VIPER module. With me unit test permit
 double code, it should be separate for easier to handle.
