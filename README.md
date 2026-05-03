# Pong (ECS)

I wrote a Pong remake in LÖVE using an Entity Component System. The LOC is roughly equivalent to a typical OOP implementation, and it could serve as an example.

## Controls
- **W/S** — move paddle
- **Space** — serve
- **Escape** — quit

## Architecture
- **Concord** for ECS
- **Batteries** for the state machine
- **binser** for save/load (inactive)
- Custom components: `ball`, `paddle`, `controllable`, `ai`, `renderable`, `size`
- Systems: control, ai, move, collision (breakout-style angle steering), bounce, score, sound, render
- States: start screen, game (with internal serve/play/victory phases)
- Sound events decoupled from gameplay systems
