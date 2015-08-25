Elixir Schedule Playground
================

Works with the following JSON structure of the schedule.

Use `ElixirSchedulePlayground.test/1` where you send your JSON formated schedule like this:

```
{
    "tuesday": [
        "2:00-4:00",
        "18:00-20:00"
    ],
    "thursday": [
        "2:20-4:50",
        "18:01-20:59"
    ],
    "sunday": [
        "0:00-24:00"
    ]
}
```

It use only `UTC` timezone to do the comparison and returns `:true` if `now` fits the schedule or `:false` if it's not.

#Installation

```
mix deps.clean
mix deps.get
mix compile
```

#Usage

```
iex -S mix

iex(1)> ElixirSchedulePlayground.test
:true

iex(1)> ElixirSchedulePlayground.test "{\"tuesday\":[\"0:10-4:33\",\"12:10-23:59\"],\"thursday\":[\"2:20-4:50\",\"18:01-20:59\"],\"sunday\":[\"0:00-24:00\"]}"
:false
```

#License 

© 2015 Eugene Hauptmann
MIT