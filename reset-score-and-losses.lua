-- Retrieve the scenario object using the correct global function
local scenario = VP_GetScenario()

-- Call the method to clear score and logs
scenario:ResetLossExp()
scenario:ResetScore()

print("Scores and Losses/Expenditures log have been cleared.")