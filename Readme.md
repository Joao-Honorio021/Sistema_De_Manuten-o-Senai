# 📊 Relatórios 

Consultas prontas para a gerência extrair métricas do banco de dados.

---

## A. 📈 Produtividade (Bugs vs. Melhorias)

Mede em qual categoria a equipe está gastando mais tempo.

```sql
SELECT 
    tm.categoria AS tipo_manutencao,
    COUNT(c.id_chamado) AS total_chamados,
    ROUND(COUNT(c.id_chamado) * 100.0 / NULLIF((SELECT COUNT(*) FROM chamado), 0), 2) AS percentual_geral
FROM 
    tipo_manutencao tm
LEFT JOIN chamado c ON tm.id_tipo = c.id_tipo
GROUP BY tm.categoria
ORDER BY total_chamados DESC;
```

**Objetivo:** Identificar em qual categoria a equipe está investindo mais esforço (bugs, melhorias, etc.)

---

## B. 🛑 Auditoria de Netiqueta (Clientes Agressivos)

Lista as mensagens abusivas enviadas por clientes para análise da gerência.

```sql
SELECT 
    cli.razao_social AS empresa,
    u.nome AS usuario_ofensor,
    hi.mensagem AS texto_abusivo,
    hi.data_hora
FROM 
    historico_interacao hi
JOIN chamado c ON hi.id_chamado = c.id_chamado
JOIN usuario u ON hi.id_autor = u.id_usuario
JOIN cliente cli ON u.id_cliente = cli.id_cliente
WHERE hi.flag_abuso = TRUE
ORDER BY hi.data_hora DESC;
```

**Objetivo:** Monitorar e auditar comportamentos inadequados de clientes para ação gerencial.

---

## C. ⚠️ Gargalos Abertos (Onde estão os problemas hoje?)

Mapeia todos os chamados abertos, mostrando a tela do erro e o desenvolvedor alocado.

```sql
SELECT 
    cli.razao_social AS cliente,
    s.nome_sistema AS sistema,
    m.nome_modulo AS modulo_com_erro,
    c.titulo AS titulo_chamado,
    dev.nome AS dev_responsavel
FROM 
    chamado c
JOIN modulo m ON c.id_modulo = m.id_modulo
JOIN sistema s ON m.id_sistema = s.id_sistema
JOIN cliente cli ON s.id_cliente = cli.id_cliente
LEFT JOIN usuario dev ON c.id_responsavel = dev.id_usuario
WHERE c.status != 'RESOLVIDO'
ORDER BY c.data_abertura ASC;
```

**Objetivo:** Visualizar rapidamente todos os gargalos em aberto, identificando clientes afetados, sistemas problemáticos e responsáveis.

---

