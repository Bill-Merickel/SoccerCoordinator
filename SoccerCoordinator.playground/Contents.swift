// First, I created a large dictionary to store all player data. Each player has their own dictionary as well. Since our dictionary is of type String: Any, as long as the key is a string, the values can be of any type (it took some research for that one).

var soccerLeague: [[String: Any]] = [
    ["name": "Joe Smith", "height": 42.0, "experience": true, "Guardian Name(s)": "Jim and Jan Smith"],
    ["name": "Jill Tanner", "height": 36.0, "experience": true, "Guardian Name(s)": "Clara Tanner"],
    ["name": "Bill Bon", "height": 43.0, "experience": true, "Guardian Name(s)": "Sara and Jenny Bon"],
    ["name": "Eva Gordon", "height": 45.0, "experience": false, "Guardian Name(s)": "Wendy and Mike Gordon"],
    ["name": "Matt Gill", "height": 40.0, "experience": false, "Guardian Name(s)": "Charles and Sylvia Gill"],
    ["name": "Kimmy Stein", "height": 41.0, "experience": false, "Guardian Name(s)": "Bill and Hillary Stein"],
    ["name": "Sammy Adams", "height": 45.0, "experience": false, "Guardian Name(s)": "Jeff Adams"],
    ["name": "Karl Saygan", "height": 42.0, "experience": true, "Guardian Name(s)": "Heather Bledsoe"],
    ["name": "Suzane Greenberg", "height": 44.0, "experience": true, "Guardian Name(s)": "Henrietta Dumas"],
    ["name": "Sal Dali", "height": 41.0, "experience": false, "Guardian Name(s)": "Gala Dali"],
    ["name": "Joe Kavalier", "height": 39.0, "experience": false, "Guardian Name(s)": "Sam and Elaine Kavalier"],
    ["name": "Ben Finkelstein", "height": 44.0, "experience": false, "Guardian Name(s)": "Aaron and Jill FinkelStein"],
    ["name": "Diego Soto", "height": 41.0, "experience": true, "Guardian Name(s)": "Robin and Sarika Soto"],
    ["name": "Chloe Alaska", "height": 47.0, "experience": false, "Guardian Name(s)": "David and Jamie Alaska"],
    ["name": "Arnold Willis", "height": 43.0, "experience": false, "Guardian Name(s)": "Claire Willis"],
    ["name": "Phillip Helm", "height": 44.0, "experience": true, "Guardian Name(s)": "Thomas Helm and Eva Jones"],
    ["name": "Les Clay", "height": 42.0, "experience": true, "Guardian Name(s)": "Wynonna Brown"],
    ["name": "Herschel Krustofski", "height": 42.0, "experience": true, "Guardian Name(s)": "Hyman and Rachel Krustofski"],
]

// Next I created an empty array of each team. I initalized each dictionary, but the first index will be removed after the players have been assigned to the teams. I also stored each team in an array called teams.

var teamDragons: [[String: Any]] = [[:]]
var teamSharks: [[String: Any]] = [[:]]
var teamRaptors: [[String: Any]] = [[:]]

var teams = [teamDragons, teamSharks, teamRaptors]

// Then I created two empty arrays, experienced and inexperienced players, also initalized and will be removed later.

var experiencedPlayers: [[String: Any]] = [[:]]
var inexperiencedPlayers: [[String: Any]] = [[:]]

// This next for-loop will go through each player on the Soccer League, check if they have experience playing soccer, and assign them to the experienced and inexperienced player groups.

for player in soccerLeague {
    if (player["experience"] as! Bool == true) { // If the player experience value is equal to true...
        experiencedPlayers.append(player) // Put the player on the experienced players group.
    } else { // Otherwise (if they have no experience)
        inexperiencedPlayers.append(player) // Put them on the inexperienced players group.
    }
}

// Here I just removed the first index in the two experience dictionarys, the ones I initialized. The dictionarys only contain players now.

experiencedPlayers.removeAtIndex(0)
inexperiencedPlayers.removeAtIndex(0)

// We can check that here.

experiencedPlayers
inexperiencedPlayers

// Next I created a function to sort the 2 experience groups into three even teams.

func sortIntoTeams(division: [[String: Any]]) -> Bool { // This function takes a parameter called division, which represents the experienced and inexperienced groups. Notice it's the same type as the experience groups.
    var finished: Bool // This boolean called finished will be used in the future. We don't need to worry abut it now.
    var index = 0 // Here I created a variable of type Int called index, and assigned it to 0. This represents the experienced/inexperienced player index. This is how we assign the players to the teams.
    while index < division.count { // The while loop checks as long as the variable index's value is less than the division's count, or the experienced/inexperienced players count (which is currently 9)...
        teamDragons.append(division[index]) // assign the player group's index value (which is 0)
        teamSharks.append(division[index + 1]) // assign the player group's next index value (which is 1)
        teamRaptors.append(division[index + 2]) // assign the player group's following index value (which is 2)
        index += 3 // add 3 to index, and repeat the process. The dragon team will now contain experiencedPlayers[3, 6] etc. We add by 3 because there are 3 teams. That will distribute the players as evenly as possible.
    }
    finished = true // After the while loop completes, assign true to finished.
    return finished // And return finished. This will be used later when we check to see if the players have already been sorted into teams by experience.
}

// Now we call the function on the experienced and inexperienced groups.

sortIntoTeams(experiencedPlayers)
sortIntoTeams(inexperiencedPlayers)

// And removing the inital values from each team.

teamDragons.removeAtIndex(0)
teamSharks.removeAtIndex(0)
teamRaptors.removeAtIndex(0)

// Not only will the teams be sorted by experienced players, but also each average team height has to be between 1.5 of each other.

// To start the process, I created a function that returns a team's average player height.

func getAverageHeight(team: [[String: Any]]) -> Double { // Takes a parameter called team, which is obviously representing one of the teams.
    var totalTeamHeight = 0.0 // This will represent the total sum of all player heights in the team.
    var averageTeamHeight = 0.0 // And this will represent the team's average player height.
    
    // This loop will go through every player and add their height value to totalTeamHeight.
    for player in team {
        totalTeamHeight += player["height"] as! Double
    }
    
    // Here averageTeamHeight is given the value of all the player's heights combined divieded by the team count.
    averageTeamHeight = totalTeamHeight / Double(team.count)
    return averageTeamHeight
}

// We can view the average player heights of each team below.

getAverageHeight(teamDragons)
getAverageHeight(teamSharks)
getAverageHeight(teamRaptors)

// Next I created a function to check if the average heights are in range with one another.

func checkAverageHeight(team1 team1: [[String: Any]], team2: [[String: Any]], team3: [[String:Any]]) -> Bool {
    let range = 1.5
    let result: Bool
    
    // This if statement says if the absolute value of any of the two teams is less than 1.5 (which is the goal)...
    if abs(getAverageHeight(team1) - getAverageHeight(team2)) <= range && abs(getAverageHeight(team2) - getAverageHeight(team3)) <= range && abs(getAverageHeight(team3) - getAverageHeight(team1)) <= range {
        result = true // Set result to true
    } else {
        result = false
    }
    return result
}

// We can check to see if the heights are in range of each other or not.

checkAverageHeight(team1: teamDragons, team2: teamSharks, team3: teamRaptors)

// Our heights are not in range, so now I have to create a function that moves players around to get the heights in range WHILE keeping the same number of experienced players on each team.

func sortIntoNewTeams(team1 team1: [[String: Any]], team2: [[String: Any]], team3: [[String:Any]]) { // The function takes three teams as parameters.
    var index = 0 // I'm using the index stragety from our earlier function.
    let dragonPlayer = teamDragons[index] // And I'm creating three new variables to store the team player[index]
    let sharkPlayer = teamSharks[index]
    let raptorPlayer = teamRaptors[index]
    if checkAverageHeight(team1: team1, team2: team2, team3: team3) == false { // If the average height's of each team aren't in range...
        teamDragons.removeAtIndex(index) // remove the index value on all teams
        teamSharks.removeAtIndex(index)
        teamRaptors.removeAtIndex(index)
        
        teamDragons.append(sharkPlayer) // Assign that value to a different team
        teamSharks.append(raptorPlayer)
        teamRaptors.append(dragonPlayer)
        
        if checkAverageHeight(team1: team1, team2: team2, team3: team3) == false { // If the average height's of each team still aren't in range...
            index += 1 // add one to the index.
            // This will reset the index value and go through the loop again.
        }
    }
}

// We can see our heights before we call our new function. These were the original heights.

getAverageHeight(teamDragons)
getAverageHeight(teamSharks)
getAverageHeight(teamRaptors)

// We can check if the heights are in range, and their not.
checkAverageHeight(team1: teamDragons, team2: teamSharks, team3: teamRaptors)

// Now we call the function, and noticed the different average heights. The players have been rearranged.
sortIntoNewTeams(team1: teamDragons, team2: teamSharks, team3: teamRaptors)

getAverageHeight(teamDragons)
getAverageHeight(teamSharks)
getAverageHeight(teamRaptors)

// Finally check if our heights are in range, which they are.

checkAverageHeight(team1: teamRaptors, team2: teamDragons, team3: teamSharks)

// And one last thing before we start the letters. If you noticed I put no effort into insuring that the number if experienced players on each team is the same, because I didn't have too. The first three origianl players on each team were experienced, like our earlier function assigned, and the other three were inexperienced players. Since every loop we do has the same index, the player experience will still be the same. If you're unsure, re-read some of my code.

// And now the final step: Addressing the welcome letters. I'll do this by creating a for loop to run through each player on each team.

for player in teamDragons {
    print("Dear \(player["Guardian Name(s)"] as! String), this letter is to inform you that your child, \(player["name"] as! String), has been enrolled in the Dragons team. Our next game time will be at 1 PM on March 17th. We hope you'll arrive and enjoy!")
}

for player in teamSharks {
    print("Dear \(player["Guardian Name(s)"] as! String), this letter is to inform you that your child, \(player["name"] as! String), has been enrolled in the Sharks team. Our next game time will be at 3 PM on March 17th. We hope you'll arrive and enjoy!")
}

for player in teamRaptors {
    print("Dear \(player["Guardian Name(s)"] as! String), this letter is to inform you that your child, \(player["name"] as! String), has been enrolled in the Raptors team. Our next game time will be at 1 PM on March 18th. We hope you'll arrive and enjoy!")
}