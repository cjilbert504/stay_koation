1. Welcome the person
2. Ask the user for their name
3. Create a new user instance with the provided name
4. User should be able to save campsites
5. Prompt the user about which state they would like to search
6. Return a list of cities within the selected state that have KOA campsites
7. Prompt the user to select a city 
8. Return a list of ameneties at the selected campsite


To Do's
1. Address object relationships
2. Address Users being able to save campsites
3. Address being able to cycle through the program multiple times
4. Address users being able to view their saved sites and that campgrounds amenities
5. Address campground objects being able to know their individual amenities

States
    have many campgrounds

Campground
    has a state
    has amenities

User
    can search by state, then view campgrounds in that state and its amenities. User can save campgrounds that they like.