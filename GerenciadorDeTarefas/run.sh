#!/bin/bash
# Instala dependencias
dotnet restore
wait
# Inicia o container
docker compose up -d
# Espera uma mensagem de conexao disponivel para clientes
while ! docker exec -t database cat /var/opt/mssql/log/errorlog | grep "SQL Server is now ready for client connections"; do sleep 1; done
# Cria o banco de dados e as tabelas
dotnet ef database update
wait
# Inicializa a aplicacao
dotnet run