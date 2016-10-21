require("GA")

f = io.open('result.txt','r')
gene_file = f:read("*a")
gene = {}
end_gene = #gene_file
for i=1,#gene_file do
  gene[i] = assert(string.sub(gene_file,i,#gene_file-end_gene+1))
  end_gene = end_gene - 1
end

while(true) do
  local status = 0
  local framerate = 60
  poweron()
  for i = 1,table.maxn(gene) do
    status = gene[i]
    if(status == "1") then
      move_right(10)
    elseif(status == "2") then
      move_up_right(framerate) --斜め飛び
    end

    if(is_clear() == 0) then
      break
    elseif(is_dead() == 0) then
      break
    end
  end
end
