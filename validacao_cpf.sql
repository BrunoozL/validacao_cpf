DELIMITER $
create function validacao_cpf(cpf varchar(11)) returns varchar(25) deterministic
begin

    -- --------------------------------------------------------
    -- Declarando as variáveis
	
    declare situacao varchar(30);
    declare contador int;
	declare soma int;
    declare resultado1 int;
    declare resultado2 int;
    declare dgt1 int;
    declare dgt2 int;
    
	-- --------------------------------------------------------
    -- Removendo os espaços laterais
    
    if (cpf = trim(cpf)) then
		set situacao = "Este CPF é inválido";
	end if;
	
    
    -- --------------------------------------------------------
	-- Verificando se é diferente de 11 digitos
    
    if (length(cpf) <> 11) then
		set situacao = "Este CPF é inválido";
	end if;
    
    -- --------------------------------------------------------
    -- Validação do 1° número
    
    set dgt1 = substring(cpf, 10, 1);
    set soma = 0;
    set contador = 1;
    while (contador <= 9) do
		set soma = soma + cast(substring(cpf, contador, 1) as unsigned) * (11 - contador);
        set contador = contador + 1;
	end while;
    set resultado1 = 11 - (soma % 11);
    if (resultado1 > 9) then
		set resultado1 = 0;
	end if;
    
    -- --------------------------------------------------------
    -- Validação do 2° número
    
	set dgt2 = substring(cpf, 11, 1);
	set soma = 0;
	set contador = 1;
    while (contador <= 10) do
		set soma = soma + cast(substring(cpf, contador, 1) as unsigned) * (12 - contador);
        set contador = contador + 1;
	end while;
	set resultado2 = 11 - (soma % 11);
    if (resultado2 > 9) then
		set resultado2 = 0;
	end if;
    
        -- --------------------------------------------------------
        -- Verificando se é válido ou inválido
    
    if (resultado1 = dgt1) then
		if (resultado2 = dgt2) then
			set situacao = "Este CPF é válido";
	end if;
	else
		set situacao = "Este CPF é inválido";
	end if;
	return (situacao);

end;
$