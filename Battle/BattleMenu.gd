extends Control

var cursor
var cursor_is_moving
var menu_frame
var menu_prompt

var current_option = 0
var options = []

func _ready():
    menu_frame = get_node("BattleMenuFrame")

    menu_prompt = menu_frame.get_node("BattleMenuPrompt")

    options = menu_frame.get_node("BattleMenuOptions").get_children()

    cursor = menu_frame.get_node("Cursor")
    cursor_update()
    cursor_is_moving = false

    # Make the options and cursor invisible until all the introductory prompts are done
    cursor.set_hidden(true)
    for op in options:
        op.set_hidden(true)
        
    set_fixed_process(true)

func _fixed_process(delta):
    if Input.is_action_pressed("ui_accept") && current_option == 1 && !menu_prompt.must_leave:
            menu_prompt.set_run_text("Got away safely!")
    elif Input.is_action_pressed("ui_left") && !cursor_is_moving:
        cursor_is_moving = true
        update_current_option("left")
        cursor_update()
    elif Input.is_action_pressed("ui_right") && !cursor_is_moving:
        cursor_is_moving = true
        update_current_option("right")
        cursor_update()

# ---------------
# Class Functions
# ---------------

# cursor_update
# Updates the position of the cursor based on the currently selected menu option
func cursor_update():
    cursor.set_global_pos(Vector2(options[current_option].get_global_pos().x - 8, cursor.get_global_pos().y))

# update_current_option
# Updates the currently selected cursor option
func update_current_option(direction):
    if cursor_is_moving == false:
        return false

    # Simplified menu logic until more options are added
    if direction == "left":
        current_option = 0
    elif direction == "right":
        current_option = 1
    cursor_is_moving = false