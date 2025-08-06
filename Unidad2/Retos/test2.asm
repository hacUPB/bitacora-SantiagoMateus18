// Declaración de variables
@16    // Dirección de 'var'
D=A
@var
M=D

@17    // Dirección de 'bis'
D=A
@bis
M=D

@18    // Dirección de 'p_var'
D=A
@p_var
M=D

// Inicialización: var = 10
@10
D=A
@16    // Dirección de 'var'
M=D

// Inicialización: bis = 5
@5
D=A
@17    // Dirección de 'bis'
M=D

// p_var = &var
@16
D=A
@18    // Dirección de 'p_var'
M=D

// bis = *p_var
@18    // Dirección de 'p_var'
A=M    // Ahora A = 16 (valor de p_var)
D=M   
@17 