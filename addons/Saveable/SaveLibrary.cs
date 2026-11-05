
namespace Saveable;

/// <summary>
/// Available save slots.
/// </summary>
public enum SaveSlotEnum
{
	Autosave,
	SlotOne,
	SlotTwo,
	SlotThree
}

/// <summary>
/// Save file paths.
/// </summary>
internal struct SaveFiles
{
	internal const string AutosaveFile = "user://saves/GameName_Auto.save";
	internal const string SlotOneFile = "user://saves/GameName_01.save";
	internal const string SlotTwoFile = "user://saves/GameName_02.save";
	internal const string SlotThreeFile = "user://saves/GameName_03.save";
}
