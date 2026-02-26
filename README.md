# Sistema de Gestão de Manutenção de Software 

Este repositório contém a modelagem lógica, o script físico e os relatórios (consultas DQL) do  Sistema de Gestão de Manutenção de Software. 

**Tecnologia Utilizada:** PostgreSQL

---

## 🚀 Diferenciais do Modelo



* **Fim do "Erro Genérico":** Um chamado não pode ser aberto de forma vaga. A modelagem exige o apontamento exato do `modulo` (tela) vinculado ao sistema do cliente, agilizando o diagnóstico da equipe técnica.
* **Auditoria de Netiqueta (Prevenção de Assédio):** A comunicação não é um campo de texto livre, mas uma *thread* rastreável por autor e data. Incluímos o campo `flag_abuso`, permitindo que o atendente sinalize no banco de dados quando um cliente passa dos limites (xingamentos/ofensas).
* **Tipagem Obrigatória:** O chamado já nasce classificado entre Corretiva, Preventiva, Adaptativa ou Perfectiva, gerando massa de dados confiável para análise de produtividade.

---

## 📊 KPIs Pensados 

A arquitetura das tabelas foi estruturada propositalmente para alimentar, via SQL simples, os seguintes indicadores para a gerência:

1. **Distribuição de Esforço da Equipe (Bugs vs. Evolução):** Mede a porcentagem de tempo gasto apagando incêndios (Manutenção Corretiva) comparado ao tempo gasto entregando valor real (Manutenções Perfectivas e Adaptativas).

2. **Índice de Clientes Tóxicos/Hostis:** Cruzamento da `flag_abuso` com a tabela de clientes para identificar quais empresas mais causam desgaste emocional no time de suporte, permitindo intervenção gerencial ou jurídica.

3. **Mapa de Calor de Código (Gargalos):** Identifica volume de chamados agrupados por `modulo`. Mostra à gestão exatamente qual tela de qual sistema está quebrando mais e precisa de refatoração urgente.

4. **Visão Operacional em Tempo Real:**
   Mapeamento de todos os chamados abertos, cruzando o módulo do erro com o desenvolvedor responsável alocado, evitando que tarefas fiquem órfãs.
