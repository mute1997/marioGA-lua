require("GA")

--集団サイズは100 * 10
-- size * number
size = 100
number = 50 -- number >= 5

final_generation = 100

gene = generate_gene(size,number)
now_generation = 0


while (now_generation <= final_generation) do
  emu.print(now_generation)

  gene_result = calc(size,number,gene)
  gene = generate_nextgen(size,number,gene,gene_result)

  now_generation = 1 + now_generation
end

emu.print("finished")
