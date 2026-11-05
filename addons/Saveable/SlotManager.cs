using Godot;

namespace Saveable;

internal static class SlotManager
{
	/// <summary>
	/// Check if a save file exists.
	/// </summary>
	/// <param name="saveSlot">The save slot to check.</param>
	/// <returns>True if file exists, false otherwise.</returns>
	public static bool IsSavePresent(SaveSlotEnum saveSlot)
	{
		return FileAccess.FileExists(GetSaveFile(saveSlot));
	}

	/// <summary>
	/// Check if a save file exists.
	/// </summary>
	/// <param name="filePath">The file path to check.</param>
	/// <returns>True if file exists, false otherwise.</returns>
	public static bool IsSavePresent(string filePath)
	{
		return FileAccess.FileExists(filePath);
	}

	/// <summary>
	/// Returns the date and time the save was last modified.
	/// </summary>
	/// <param name="saveSlot">The save slot to check.</param>
	public static string GetFileInfo(SaveSlotEnum saveSlot)
	{
		var unixTime = FileAccess.GetModifiedTime(GetSaveFile(saveSlot));
		if (unixTime == 0) return "Error: File could not return info.";

		var localTimeBias = Time.GetTimeZoneFromSystem();
		unixTime += (ulong)localTimeBias["bias"] * 60;

		return Time.GetDatetimeStringFromUnixTime((long)unixTime, true);
	}

	/// <summary>
	/// Returns the date and time the save was last modified.
	/// </summary>
	/// <param name="filePath">The file path to check.</param>
	public static string GetFileInfo(string filePath)
	{
		var unixTime = FileAccess.GetModifiedTime(filePath);
		if (unixTime == 0) return "Error: File could not return info.";

		var localTimeBias = Time.GetTimeZoneFromSystem();
		unixTime += (ulong)localTimeBias["bias"] * 60;

		return Time.GetDatetimeStringFromUnixTime((long)unixTime, true);
	}

	/// <summary>
	/// Returns the file path string for a given slot.
	/// </summary>
	internal static string GetSaveFile(SaveSlotEnum saveSlot)
	{
		return saveSlot switch
		{
			SaveSlotEnum.Autosave => SaveFiles.AutosaveFile,
			SaveSlotEnum.SlotOne => SaveFiles.SlotOneFile,
			SaveSlotEnum.SlotTwo => SaveFiles.SlotTwoFile,
			SaveSlotEnum.SlotThree => SaveFiles.SlotThreeFile,
			_ => ""
		};
	}
}