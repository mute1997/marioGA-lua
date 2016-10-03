function poweron()
  emu.poweron()
  --起動してから操作可能になるまでのフレーム数待機
  for i = 0,32 do
    emu.frameadvance()
  end

  --スタート画面からプレイ開始する処理
  joypad.set(1,{start=true})
  emu.frameadvance()
  joypad.set(1,{start=false})
  emu.frameadvance()

  --実際に操作可能になるまでのフレーム数待機
  for i = 0,160 do
    emu.frameadvance()
  end
end

function is_dead()
  if(memory.readbyte(0x000e) == 11 or memory.readbyte(0x000e) == 0) then
    return 0
  else
    return 1
  end
end

function is_clear()
  if(memory.readbyte(0x000b) == 2) then
    return 0
  else
    return 1
  end
end
