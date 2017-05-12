###
Santa's sleigh uses a very high-precision clock to guide its movements, and the
clock's oscillator is regulated by stars. Unfortunately, the stars have been
stolen... by the Easter Bunny. To save Christmas, Santa needs you to retrieve
all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each
day in the advent calendar; the second puzzle is unlocked when you complete the
first. Each puzzle grants one star. Good luck!

You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near",
unfortunately, is as close as you can get - the instructions on the Easter
Bunny Recruiting Document the Elves intercepted start here, and nobody had time
to work them out further.

The Document indicates that you should start at the given coordinates (where
you just landed) and face North. Then, follow the provided sequence: either
turn left (L) or right (R) 90 degrees, then walk forward the given number of
blocks, ending at a new intersection.

There's no time to follow such ridiculous instructions on foot, though, so you
take a moment and work out the destination. Given that you can only walk on the
street grid of the city, how far is the shortest path to the destination?

For example:

- Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks
away.
- R2, R2, R2 leaves you 2 blocks due South of your starting position, which is
2 blocks away.
- R5, L5, R5, R3 leaves you 12 blocks away.

How many blocks away is Easter Bunny HQ?
###

input = "R2, L1, R2, R1, R1, L3, R3, L5, L5, L2, L1, R4, R1, R3, L5, L5,
         R3, L4, L4, R5, R4, R3, L1, L2, R5, R4, L2, R1, R4, R4, L2, L1,
         L1, R190, R3, L4, R52, R5, R3, L5, R3, R2, R1, L5, L5, L4, R2,
         L3, R3, L1, L3, R5, L3, L4, R3, R77, R3, L2, R189, R4, R2, L2,
         R2, L1, R5, R4, R4, R2, L2, L2, L5, L1, R1, R2, L3, L4, L5, R1,
         L1, L2, L2, R2, L3, R3, L4, L1, L5, L4, L4, R3, R5, L2, R4, R5,
         R3, L2, L2, L4, L2, R2, L5, L4, R3, R1, L2, R2, R4, L1, L4, L4,
         L2, R2, L4, L1, L1, R4, L1, L3, L2, L2, L5, R5, R2, R5, L1, L5,
         R2, R4, R4, L2, R5, L5, R5, R5, L4, R2, R1, R1, R3, L3, L3, L4,
         L3, L2, L2, L2, R2, L1, L3, R2, R5, R5, L4, R3, L3, L4, R2, L5, R5"

findEasterBunny = (input) ->
  locationAndBearings =
    bearing: 0, # corresponds to North
    x: 0,
    y: 0

  # Do this for each instruction given in the input
  for instruction in input.split ", "
    wayToTurn = instruction.slice 0, 1 # This will be 'R' or 'L'
    distance = Number(instruction.slice 1)

    # Turn either clockwise or counterclockwise, and make sure bearing is positive
    rotation = if wayToTurn == 'R' then 1 else -1
    locationAndBearings.bearing += rotation
    locationAndBearings.bearing += 4 if locationAndBearings.bearing < 0

    # could these be written like `if ...bearing % 4 == 0 then y += ...`
    # or even like `y += ... if ...bearing % 4 == 0`
    if locationAndBearings.bearing % 4 == 0 # we're walking north
      locationAndBearings.y += distance
    else if locationAndBearings.bearing % 4 == 1 # we're walking east
      locationAndBearings.x += distance
    else if locationAndBearings.bearing % 4 == 2 # we're walking south
      locationAndBearings.y -= distance
    else # we're walking west
      locationAndBearings.x -= distance

  cityBlocks = Math.abs(locationAndBearings.x) + Math.abs(locationAndBearings.y)
  console.log "The Easter Bunny is at #{locationAndBearings.x}, #{locationAndBearings.y}"
  console.log "The Easter Bunny is #{cityBlocks} blocks away"

findEasterBunny(input)
