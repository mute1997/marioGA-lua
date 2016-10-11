function move_up_right(framerate)
  for i = 0,framerate do
    joypad.set(1,{A=true,right=true})
    emu.frameadvance()
  end
  joypad.set(1,{A=false,right=false})
  emu.frameadvance()
end

function move_up_left(framerate)
  for i = 0,framerate do
    joypad.set(1,{A=true,left=true})
    emu.frameadvance()
  end
  joypad.set(1,{A=false,left=false})
  emu.frameadvance()
end

function move_right(framerate)
  for i = 0,framerate do
    joypad.set(1,{right=true})
    emu.frameadvance()
  end
  joypad.set(1,{right=false})
  emu.frameadvance()
end

function move_left(framerate)
  for i = 0,framerate do
    joypad.set(1,{left=true})
    emu.frameadvance()
  end
  joypad.set(1,{left=false})
  emu.frameadvance()
end
