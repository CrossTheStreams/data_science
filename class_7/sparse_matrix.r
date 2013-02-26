library('Matrix')

# Collect observations for the dense matrix
obs <- c(1,2,1,3)
obs <- cbind(obs,c(2,1,1,3))
obs <- cbind(obs,c(2,4,1,1))
obs <- cbind(obs,c(3,1,1,1))
obs <- cbind(obs,c(2,1,2,1))
obs <- cbind(obs,c(2,3,2,2))
obs <- cbind(obs,c(3,1,2,2))
obs <- cbind(obs,c(2,3,3,8))
obs <- cbind(obs,c(3,2,3,3))
obs <- cbind(obs,c(2,4,4,3))
obs <- cbind(obs,c(2,5,4,2))
obs <- cbind(obs,c(3,4,4,2))


reg.matrix <- matrix(obs,nrow=12,ncol=4,byrow=TRUE,list(c(),c("A","B","C","V")))

# Create the type of sparse matrix requested in the assignment.

sparse.matrix <- as.data.frame(Matrix(0,nrow=length(reg.matrix),ncol=3))

sparse.matrix[,1] <- as.vector(row(reg.matrix))
sparse.matrix[,2] <- as.vector(col(reg.matrix))
sparse.matrix[,3] <- as.vector(reg.matrix)

# Force the matrix to specifically match the format in the assignment.

sparse.matrix.df <- as.data.frame(as.matrix(sparse.matrix))
names(sparse.matrix.df) <- c("C", "R", "M")
sparse.matrix.df[,2] <- as.vector(colnames(reg.matrix)[col(reg.matrix)])  

#

write.csv(sparse.matrix.df,file="sparse_matrix.csv")

