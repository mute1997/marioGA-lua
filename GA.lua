require("player_api/move")
require("player_api/machine")

-- 0 1 2の３つの状態を遷移する
function generate_gene(size,number)
  local gene = {}
  for j = 1,number do
    gene[j] = {}
    for i = 1,size do
      -- 0 right
      -- 1 up
      -- 2 down
      table.insert(gene[j],math.random(0,1))
    end
  end
  return gene
end

function calc(size,number,gene)
  local framerate = 40
  local status = 0
  local judge = 0
  local gene_result = {}

  --calc
  for j = 1,number do
    poweron()
    for i = 1,size do
      status = gene[j][i]
      if(status == 0) then
        move_right(framerate)

      elseif(status == 1) then
        move_up(framerate)
      end

      if(is_dead() == 0) then
        table.insert(gene_result,emu.framecount())
        break
      elseif(is_clear() == 0) then
        table.insert(gene_result,emu.framecount())
        break
      end

    end
  end
  return gene_result
end

function gene_sort(size,number,gene,gene_result)
  while true do
    for i = 2,table.maxn(gene_result) do
      if(gene_result[i-1] < gene_result[i]) then
        flag = false
        local temp = {unpack(gene[i-1])}
        gene[i-1] = {unpack(gene[i])}
        gene[i] = {unpack(temp)}

        local temp = gene_result[i-1]
        gene_result[i-1] = gene_result[i]
        gene_result[i] = temp
      end
    end
    if(flag == true) then
      break
    end
    flag = true
  end

  emu.print(gene_result)

  return gene
end


function crossing(parent,parent_) --1点交叉法
  local child = {}
  local child_ = {}

  point = math.random(1,table.maxn(parent))

  for i = 1,point do
    table.insert(child,parent[i])
    table.insert(child_,parent_[i])
  end

  for i = point,table.maxn(parent) do
    table.insert(child,parent_[i])
    table.insert(child_,parent[i])
  end

  return (child),(child_)
end

--ランキング選択
-- 1位 50%
-- 2位 20%
-- 3位 15%
-- 4位 10%
-- 5位 5%
function generate_nextgen(size,number,gene,gene_result) --ランキング選択
  gene = gene_sort(size,number,gene,gene_result)
  selection_list = {}

  --ランキング方式の割合設定
  first = 50
  second = 20
  third = 15
  fourth = 10
  fifth = 5

  for i = 1,first do
    table.insert(selection_list,gene[i])
  end

  for i = 1,second do
    table.insert(selection_list,gene[i+1])
  end

  for i = 1,third do
    table.insert(selection_list,gene[i+2])
  end

  for i = 1,fourth do
    table.insert(selection_list,gene[i+3])
  end

  for i = 1,fifth do
    table.insert(selection_list,gene[i+4])
  end

  local next_gene = {}
  for i = 0,number/2 do
    parent = selection_list[math.random(1,table.maxn(selection_list))]
    parent_ = selection_list[math.random(1,table.maxn(selection_list))]

    child,child_ = crossing(parent,parent_)
    table.insert(next_gene,child)
    table.insert(next_gene,child_)
  end

  return next_gene
end
