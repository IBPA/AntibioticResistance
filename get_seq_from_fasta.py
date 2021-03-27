import sys    
file_names = ["ecoli.fa", "U00096.3.fasta"]    
for j, file_name in enumerate(file_names):    
    file = open(file_name, "r").readlines()                                     
    seqs = ["", ""]                                                             
    i =0                                                                        
    for line in file:                                                           
        if i != 0:                                                              
            seqs[j] = seq[j] + line.strip()                                     
n = len(seqs[1])                                                                
print(seqs[0][:n] == seqs[1][:n])                                               
~                                   
