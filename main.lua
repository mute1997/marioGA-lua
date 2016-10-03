require("GA")

--集団サイズは100 * 10
-- size * number
size = 1000
number = 10

final_generation = 100

gene = generate_gene(size,number)
now_generation = 0

while (now_generation <= final_generation) do
  gene_result = calc(size,number,gene)
  gene = selection(size,number,gene,gene_result)
  now_generation = 1 + now_generation
end
