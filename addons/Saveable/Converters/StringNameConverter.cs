using System;
using Godot;
using Newtonsoft.Json;

namespace Saveable.Converters;

public class StringNameConverter : JsonConverter<StringName>
{
    public override StringName? ReadJson(JsonReader reader, Type objectType, StringName? existingValue, bool hasExistingValue, JsonSerializer serializer)
    {
        if (reader.TokenType != JsonToken.String)
            throw new JsonSerializationException();

        return reader.Value is string str ? new StringName(str) : null;
    }

    public override void WriteJson(JsonWriter writer, StringName? value, JsonSerializer serializer)
    {
        writer.WriteValue(value?.ToString());
    }
}