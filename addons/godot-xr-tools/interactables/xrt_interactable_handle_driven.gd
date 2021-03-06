class_name XRTInteractableHandleDriven
extends Spatial


##
## Interactable Handle Driven script
##
## @desc:
##     This is the base class for interactibles driven by handles. It subscribes
##     to all child handle picked_up and dropped signals, and maintains a list
##     of all grabbed handles.
##
##     When one or more handles are grabbed, the _process function is enabled
##     to process the handle-driven movement.
##  


# Array of handles currently grabbed
var grabbed_handles := Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Hook picked_up and dropped signals from all child handles
	_hook_child_handles(self)

	# Turn off processing until a handle is grabbed
	set_process(false)


# Called when a handle is picked up
func _on_handle_picked_up(var handle: XRTInteractableHandle) -> void:
	# Append to the list of grabbed handles
	grabbed_handles.append(handle)

	# Enable processing
	set_process(true)


# Called when a handle is dropped
func _on_handle_dropped(var handle: XRTInteractableHandle) -> void:
	# Remove from the list of grabbed handles
	grabbed_handles.erase(handle)

	# Disable processing when we drop the last handle
	if grabbed_handles.empty():
		set_process(false)


# Recursive function to hook picked_up and dropped signals in all child handles
func _hook_child_handles(var node: Node) -> void:
	# If this node is a handle then hook its handle signals
	var handle := node as XRTInteractableHandle
	if handle:
		if handle.connect("picked_up", self, "_on_handle_picked_up"):
			push_error("Unable to connect handle signal")
		if handle.connect("dropped", self, "_on_handle_dropped"):
			push_error("Unable to connect handle signal")

	# Recurse into all children
	for child in node.get_children():
		_hook_child_handles(child)
