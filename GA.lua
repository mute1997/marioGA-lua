require("player_api/move")
require("player_api/machine")

-- 0 1 2の３つの状態を遷移する
function generate_gene(size,number)
  local state = 2--マリオがとりうる状態数
  local gene = {}
  for j = 1,number do
    gene[j] = {}
    for i = 1,size do
      -- 0 right
      -- 1 up
      -- 2 down
      table.insert(gene[j],math.random(1,state))
    end
  end
  return gene
end

function calc(size,number,gene)
  local status = 0
  local gene_result = {}
  local framerate = 60

  --calc
  for j = 1,number do
    poweron()
    for i = 1,size do
      status = gene[j][i]
      if(status == 1) then
        move_right(10)

      elseif(status == 2) then
        move_up_right(framerate) --斜め飛び

      elseif(status == 3) then
        move_left(framerate)

      elseif(status == 4) then
        move_up_left(framerate)

      end

      if(is_clear() == 0) then
        str = ""
        for z=1,table.maxn(gene[1]) do
          str = str..tostring(gene[j][z])
        end
        f = io.open('result.txt','w')
        f:write(str)
        f:close()
        --table.insert(gene_result,emu.framecount())
        break
      elseif(is_dead() == 0) then
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

function crossing(parent,parent_) --一様交叉
  local child = {}
  local child_ = {}
  local probability_list = {1,2}

  for i = 1,table.maxn(parent) do
    probability = probability_list[math.random(1,2)]
    if(probability == 1) then
      table.insert(child,parent_[i])
      table.insert(child_,parent[i])
    else
      table.insert(child,parent[i])
      table.insert(child_,parent_[i])
    end
  end

  return (child),(child_)
end


function crossing_(parent,parent_) --多点交叉法
  local point_interval = 10
  local child = {}
  local child_ = {}

  flag = true
  for i = 1,table.maxn(parent) do
    if(i % point_interval == 0) then
      flag = not(flag)
    end

    if(flag == true) then
    table.insert(child,parent[i])
    table.insert(child_,parent_[i])
    else
    table.insert(child,parent_[i])
    table.insert(child_,parent[i])
    end
  end

  return (child),(child_)
end

function mutation(child,child_)
  local state = 2
  local persentage = 5 --5%の確率で突然変異する
  if(math.random(1,100) < 5) then
    local mutation_point = math.random(1,table.maxn(child))
    child[mutation_point] = math.random(1,state)
  end
  if(math.random(1,100) < 5) then
    local mutation_point = math.random(1,table.maxn(child))
    child_[mutation_point] = math.random(1,state)
  end
  return (child),(child_)
end

--選択方式は上位20体からランダムに選択
function generate_nextgen(size,number,gene,gene_result) --ランキング選択
  gene = gene_sort(size,number,gene,gene_result)
  selection_list = {}

  for i = 1,20 do
    table.insert(selection_list,gene[i])
  end

  local next_gene = {}
  for i = 0,number/2 do
    parent = selection_list[math.random(1,table.maxn(selection_list))]
    --同じ親が選択されないようにする
    while true do
      parent_ = selection_list[math.random(1,table.maxn(selection_list))]
      if(parent ~= parent_) then
        break
      end
    end

    child,child_ = mutation(crossing(parent,parent_))
    table.insert(next_gene,child)
    table.insert(next_gene,child_)
  end

  return next_gene
end
