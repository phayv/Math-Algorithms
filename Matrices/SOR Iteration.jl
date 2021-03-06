# Successive Over Relaxation Iteration #
function SORIt(A,b, omega; Nmax = 30, ϵ=1e-6, history = false)

(n,m) = size(A);
D = diagm(diag(A),0);
U = triu(A,1);
L = tril(A,-1);
x = zeros(size(A)[1])
hist = x
DLsum = (D + omega*L)
        
(n != m) && error("Upper triangular matrix is not square \n")
(n != size(b)[1]) && error("Dimension mismatch \n")
    
 for i = 1:Nmax
    buffer = x
        x1 = forwardSubstitution(DLsum, [(1-omega)*D - omega*U]*x)
        x2 = forwardSubstitution((1/omega)*DLsum,b)
        
    x = x1 + x2
    history && (hist = [hist x])
        if norm(x-buffer)/norm(x) < ϵ
            println("SOR Iteration Converged after ",i," iterations.")
            history && return (hist[:, 2:end])
            return x
        end
    end
    error("Did not converge in ", Nmax, " iterations.")
end
