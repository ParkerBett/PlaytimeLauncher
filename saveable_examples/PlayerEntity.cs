using Godot;
using Saveable;

namespace SaveableExamples;

public partial class PlayerEntity : CharacterBody2D, ISaveable
{
	StringName ISaveable.UniqueID => Name;

	public const float Speed = 300.0f;
	public const float JumpVelocity = -400.0f;

	#region Lifecycle

	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		if (direction != Vector2.Zero)
		{
			velocity = direction * Speed;
		}
		else
		{
			velocity = Vector2.Zero;
		}

		Velocity = velocity;
		MoveAndSlide();
	}

	#endregion

	#region Save/Load

	void ISaveable.Load(NodeSave save)
	{
		GlobalPosition = save.GetProperty<Vector2>(nameof(GlobalPosition));
	}

	void ISaveable.Save(NodeSave save)
	{
		save.AddProperty(nameof(GlobalPosition), GlobalPosition);
	}

	#endregion
}
