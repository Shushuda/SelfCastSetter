# SelfCastSetter

A simple World of Warcraft addon for setting "auto self cast" option per spec.

It's main purpose is to work around the recent mouseover macro bug that breaks the logic of self casting. It will automatically enable/disable auto self casting when changing specializations. This way healers can disable self casting on healing specs to allow addons such as HealBot to work properly, while leaving self casting enabled on their dps/tank specs.

I've written this for myself, as I use auto self casting on Enh, but need to disable it on Resto, but I'm uploading it in case someone else finds it useful. Enjoy.

## How to

It works purely via slash commands and requires the spec to be active to save settings for it. Workflow is:

1. Change to spec 1.
2. Type in chat `/scs enable` or `/scs disable` to enable / disable auto self casting on the current spec (spec 1).
3. Change to spec 2.
4. Type in chat `/scs enable` or `/scs disable` to enable / disable auto self casting on the current spec (spec 2).
5. Repeat for all specs you have.

Specs without a set setting will keep the setting of the last used spec (default game behaviour). I recommend to set it for all specs you have to prevent unexpected behaviour.

## Slash commands

* `/scs` - Shows a list of available commands
* `/scs help` - Same behaviour as /scs
* `/scs enable` - Enables self casting on the current spec
* `/scs disable` - Disables self casting on the current spec
* `/scs show` - Shows the saved setting for the current spec

## Authors

* [Shushuda](https://github.com/Shushuda) - author of this addon
* [Mundocani](https://github.com/Mundocani) - author of the MC2DebugLib library

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
