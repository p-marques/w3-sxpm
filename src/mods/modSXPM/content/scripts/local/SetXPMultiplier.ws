// Set XP Multiplier 2.x by pMarK

class SetXpMultiplierManager {

	private var inGameConfigWrapper : CInGameConfigWrapper;

	public function GetIsModOn() : bool
	{
		if (!inGameConfigWrapper)
		{
			inGameConfigWrapper = theGame.GetInGameConfigWrapper();
		}

		return inGameConfigWrapper.GetVarValue('SetXpMultiplier', 'SetXpMultiplierSwitch');
	}

	public function GetStopAllXp() : bool
	{
		return inGameConfigWrapper.GetVarValue('SetXpMultiplier', 'SetXpMultiplierForceZero');
	}

	public function GetModifiedAmount(amount: int) : int
	{
		return (int)((float)amount * GetXpMultiplier());
	}

	private function GetXpMultiplier() : float
	{
		var value : float;

		value = StringToFloat(inGameConfigWrapper.GetVarValue('SetXpMultiplier', 'SetXpMultiplierValue'));

		if(GetUseDifficultyMultiplier())
			value *= GetDifficultyXpMultiplier();

		return value;
	}

	private function GetUseDifficultyMultiplier() : bool
	{
		return inGameConfigWrapper.GetVarValue('SetXpMultiplier', 'SetXpMultiplierUseDifficulty');
	}

	private function GetDifficultyXpMultiplier() : float
	{
		var value : float;
		var difficultyMode : EDifficultyMode = theGame.GetDifficultyMode();

		if ( difficultyMode == EDM_Hardcore )
		{
			value = 0.8;
		}
		else if ( difficultyMode == EDM_Hard )
		{
			value = 0.9;
		}
		else
		{
			value = 1.0;
		}

		return value;
	}
}