using Godot;
using Saveable;

namespace SaveableExamples;

public partial class Menu : Control, ISaveable
{
	StringName ISaveable.UniqueID => Name;

	private Button SaveButtonSlot1 = null!;
	private Button SaveButtonSlot2 = null!;
	private Button SaveButtonSlot3 = null!;

	private Button LoadButtonSlot1 = null!;
	private Button LoadButtonSlot2 = null!;
	private Button LoadButtonSlot3 = null!;

	[Export] private SpinBox fValueSpin = null!;
	[Export] private SpinBox iValueSpin = null!;
	[Export] private TextEdit textEdit = null!;

	private float fValue = 0.0f;
	private int iValue = 0;
	private string? sValue = null;
	private NodePath? nodePath = null;

	#region Lifecycle

	public override void _EnterTree()
	{
		SaveButtonSlot1 = GetNode<Button>("%SaveButton");
		SaveButtonSlot2 = GetNode<Button>("%SaveButton2");
		SaveButtonSlot3 = GetNode<Button>("%SaveButton3");

		LoadButtonSlot1 = GetNode<Button>("%LoadButton");
		LoadButtonSlot2 = GetNode<Button>("%LoadButton2");
		LoadButtonSlot3 = GetNode<Button>("%LoadButton3");

		SaveButtonSlot1.Pressed += () => OnSavePressed(SaveSlotEnum.SlotOne);
		SaveButtonSlot2.Pressed += () => OnSavePressed(SaveSlotEnum.SlotTwo);
		SaveButtonSlot3.Pressed += () => OnSavePressed(SaveSlotEnum.SlotThree);

		LoadButtonSlot1.Pressed += () => OnLoadPressed(SaveSlotEnum.SlotOne);
		LoadButtonSlot2.Pressed += () => OnLoadPressed(SaveSlotEnum.SlotTwo);
		LoadButtonSlot3.Pressed += () => OnLoadPressed(SaveSlotEnum.SlotThree);

		fValueSpin.ValueChanged += OnFValueChanged;
		iValueSpin.ValueChanged += OnIValueChanged;
		textEdit.TextChanged += OnTextValueChanged;

		nodePath = new("ValuesHBox/LabelsVBox/iValue");
	}

	#endregion

	#region Save/Load

	void ISaveable.Load(NodeSave save)
	{
		fValue = save.GetProperty<float>(nameof(fValue));
		iValue = save.GetProperty<int>(nameof(iValue));
		sValue = save.GetProperty<string>(nameof(sValue));
		nodePath = save.GetProperty<NodePath>(nameof(nodePath));

		fValueSpin.Value = fValue;
		iValueSpin.Value = iValue;
		textEdit.Text = sValue;
	}

	void ISaveable.Save(NodeSave save)
	{
		save.AddProperty(nameof(fValue), fValue);
		save.AddProperty(nameof(iValue), iValue);
		save.AddProperty(nameof(sValue), sValue);
		save.AddProperty(nameof(nodePath), nodePath);
	}

	#endregion

	#region Event Callbacks

	private void OnFValueChanged(double value)
	{
		fValue = (float)value;
	}

	private void OnIValueChanged(double value)
	{
		iValue = (int)value;
	}

	private void OnTextValueChanged()
	{
		sValue = textEdit.Text;
	}

	private void OnSavePressed(SaveSlotEnum saveSlot)
	{
		TreeSave? save = SaveSystem.LoadFile(
			saveSlot,
			GetTree().Root,
			loadTree: false
		);

		SaveSystem.SaveFile(
			saveSlot,
			GetTree().Root,
			save
		);
	}

	private void OnLoadPressed(SaveSlotEnum saveSlot)
	{
		SaveSystem.LoadFile(
			saveSlot,
			GetTree().Root
		);
	}

	#endregion
}
