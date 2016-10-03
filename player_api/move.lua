function move_up(framerate)
  for i = 0,framerate do
    joypad.set(1,{A=true,right=true})
    emu.frameadvance()
    if(is_dead() == 0) then
      return 1
    elseif(is_clear() == 0) then
      return 0
    end
  end
  joypad.set(1,{A=false,right=false})
  emu.frameadvance()
  if(is_dead() == 0) then
    return 1
  elseif(is_clear() == 0) then
    return 0
  end
end

function move_right(framerate)
  for i = 0,framerate do
    joypad.set(1,{right=true})
    emu.frameadvance()
    if(is_dead() == 0) then
      return 1
    elseif(is_clear() == 0) then
      return 0
    end
  end
  joypad.set(1,{right=false})
  emu.frameadvance()
  if(is_dead() == 0) then
    return 1
  elseif(is_clear() == 0) then
    return 0
  end
end

function move_left(framerate)
  for i = 0,framerate do
    joypad.set(1,{left=true})
    emu.frameadvance()
    if(is_dead() == 0) then
      return 1
    elseif(is_clear() == 0) then
      return 0
    end
  end
  joypad.set(1,{left=false})
  emu.frameadvance()
  if(is_dead() == 0) then
    return 1
  elseif(is_clear() == 0) then
    return 0
  end
end

function move_wait(framerate)
  for i = 0,framerate-1 do
    emu.frameadvance()
    if(is_dead() == 0) then
      return 1
    elseif(is_clear() == 0) then
      return 0
    end
  end
  emu.frameadvance()
  if(is_dead() == 0) then
    return 1
  elseif(is_clear() == 0) then
    return 0
  end
end
