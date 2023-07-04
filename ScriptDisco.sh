#!/bin/bash

# Variáveis
LOG='/var/log/disco'
ARQUIVO='/var/log/disco/disco.log'

# Criando diretório e arquivo de log, caso não existam
mkdir -p "$LOG"
touch "$ARQUIVO"

# Início da verificação
echo "[$(date)] INICIANDO VERIFICACAO DE DISCO" >> "$ARQUIVO"

# Loop para armazenar todos os resultados do comando find
resultado="" >> "$ARQUIVO"
while IFS= read -r linha; do >> "$ARQUIVO"
  resultado+="$linha"$'\n' >> "$ARQUIVO"
done < <(find / -type f -size +100M -name "*.log" -exec du -h {} \; 2>/dev/null) >> "$ARQUIVO"

# Limpar os arquivos encontrados
while IFS= read -r arquivo; do
    truncate -s 0 "$arquivo"
done < <(echo "$resultado")