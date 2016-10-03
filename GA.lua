require("player_api/move")
require("player_api/machine")

-- 0 1 2の３つの状態を遷移する
function generate_gene(size,number)
  local gene = {}
  for j = 0,number do
    gene[j] = {}
    for i = 0,size do
      -- 0 right
      -- 1 up
      -- 2 down
      gene[j][i] = math.random(0,3)
    end
  end
  return gene
end

function calc(size,number,gene)
  local framerate = 40
  local status = 0
  local judge = 0
  local gene_result = {}

  --gene_resultの初期化
  for i = 0,number do
    gene_result[i] = {1,1}
  end

  --calc
  for j = 0,number do
    poweron()
    for i = 0,size do
      status = gene[j][i]
      if(status == 0) then
        judge = move_right(framerate)
        if(judge == 1) then --dead
          gene_result[j] = {1,emu.framecount()}
        elseif(judge == 0) then --clear
          gene_result[j] = {0,emu.framecount()}
        end

      elseif(status == 1) then
        judge = move_up(framerate)
        if(judge == 1) then
          gene_result[j] = {1,emu.framecount()}
        elseif(judge == 0) then
          gene_result[j] = {0,emu.framecount()}
        end

      elseif(status == 2) then
        judge = move_left(framerate)
        if(judge == 1) then
          gene_result[j] = {1,emu.framecount()}
        elseif(judge == 0) then
          gene_result[j] = {0,emu.framecount()}
        end

      elseif(status == 3) then
        judge = move_wait(framerate)
        if(judge == 1) then
          gene_result[j] = {1,emu.framecount()}
        elseif(judge == 0) then
          gene_result[j] = {0,emu.framecount()}
        end
      end

    end
    emu.print(gene_result[j])
  end
  return gene_result
end

function selection(size,number,gene,gene_result)
  return gene
end

function crossing(gene,gene_) --多点交叉法
end
