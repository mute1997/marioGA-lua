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
      gene[j][i] = math.random(0,1)
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
        move_right(framerate)

      elseif(status == 1) then
        move_up(framerate)

      elseif(status == 2) then
        move_wait(framerate)

      end

      if(is_dead() == 0) then
        gene_result[j] = {1,emu.framecount()}
        break
      elseif(is_clear() == 0) then
        gene_result[j] = {0,emu.framecount()}
        break
      end

    end
  end
  return gene_result
end

function gene_sort(size,number,gene,gene_result)
  before = gene_result[0][1]
  before_ = gene_result[0][2]
  end_flag = 0

  while true do
    for i = 1,number do
      if(before < gene_result[i][1] or before_ > gene_result[i][2]) then
        end_flag = 1
        tmp =  gene[i]
        gene[i] = gene[i-1]
        gene[i-1] = gene[i]
      end
      before = gene_result[i][1]
      before_ = gene_result[i][2]
    end
    if(end_flag == 0) then
      break
    end
    end_flag = 0
  end
  return gene
end

--ランキング選択
-- 1位 50%
-- 2位 20%
-- 3位 15%
-- 4位 10%
-- 5位 5%
function selection(size,number,gene,gene_result) --ランキング選択
  return gene
end

function crossing(gene,gene_) --多点交叉法
end
