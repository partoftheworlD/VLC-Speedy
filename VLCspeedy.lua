--
-- To install put VLCspeedy.lua in
-- Windows (all users): %ProgramFiles%/VideoLAN/VLC/lua/extensions/
-- Windows (current user): %APPDATA%/vlc/lua/extensions/
-- Linux (all users): /usr/lib/vlc/lua/extensions/
-- Linux (current user): ~/.local/share/vlc/lua/extensions/
-- Mac OS X (all users): /Applications/VLC.app/Contents/MacOS/share/lua/extensions/
-- Mac OS X (current user): /Users/%your_name%/Library/Application Support/org.videolan.vlc/lua/extensions/
--
-- To start the extension click on View -> "Boring TV Show faster".
-- 

function descriptor()
  return {
    title = "Boring TV Show faster",
    version = "0.01",
    author = "partoftheworlD",
    capabilities = {"menu", "input-listener" }
  }
end

function activate()
  BuildDialog()
  click_ChangeSpeed(0)
end

function deactivate()
  vlc.var.set(hInput, "rate", 1)
end

function meta_changed()
  click_ChangeSpeed(0)
end

function close()
  vlc.deactivate()
end

function BuildDialog()
  dialog = vlc.dialog(descriptor().title)
  text_box = dialog:add_text_input("1.00",2,1,1,1)
  dialog:add_label("Speed :",1,1,1,1)
  dialog:add_button("Default (1.00)", function() click_ChangeSpeed(0) end, 2,2,1,1)
  dialog:add_button("New Speed", function() click_ChangeSpeed(1) end, 1,2,1,1)
end

Speed=1
function click_ChangeSpeed(button_id)
  local hInput=vlc.object.input()

  if hInput then
    if button_id==0 then
      Speed=1
    else
      Speed=tonumber(text_box:get_text())
    end

    vlc.var.set(hInput, "rate", Speed)

    if Speed==1 then
      dialog:set_title("Speed = 1.00")
    else
      dialog:set_title("Speed = " .. Speed .. "")
    end
  end
end