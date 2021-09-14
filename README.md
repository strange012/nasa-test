# Test Task for NASA (lol)

## Configuration

Planet and operation lists are configured using json files in `./data` folder

## Startup

Required Ruby version 2.7.0 and higher

`ruby main.rb <weight> <planet1> <planet2> <planet3>...`

## Class usage examples

```ruby
missions = [
  [28801, [[:launch, :earth], [:land, :moon], [:launch, :moon], [:land, :earth]]],
  [14606, [:earth, :mars, :earth]],
  [75432, [:earth, :moon, :mars, :earth]]
]

Flights::Base.call(*missions[0])
Flights::Common.call(*missions[1])
Flights::Common.call(*missions[2])
```