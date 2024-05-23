# Godot Example Project

A simple example of how you can:

* Create and use custom `Resource` classes for configuration.
* Easily reference those configurations using `preload` and static variables.
* Create multiple instances of a scene and configure them in a another scene.
* Emit signals from child nodes up to a parent node.
* Connect signals emitted from child nodes to handler methods in a parent node.
* Send data emitted by one child node to another child node, via a parent node.

The game itself doesn't do anything visually when you run it, aside from allow
you to make Player 1 attack Player 2 (and vice versa) by hitting the left- and
right arrow keys, respectively. All the action happens in the debugger console.
