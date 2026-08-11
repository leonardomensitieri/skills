# Método para Forjar Skills de Alta Performance
### Blueprint da arquitetura — v0.2

> **O que mudou da v0.1 → v0.2** (as quatro decisões que tomamos juntos):
> 1. **Modularidade resolvida como híbrido** — um orquestrador fino (a Forja) detém o estado; os componentes pesados (Grill, Desmonte) permanecem skills standalone. Nova seção "Mapa de modularidade".
> 2. **leonardo-method não é canibalizada** — ela fica intacta como skill de estudo. Construímos uma *irmã* de desconstrução com a polaridade invertida.
> 3. **Movimento I deixa de ser linear e vira uma espiral** — desconstrução e interrogação são co-rotinas que se alimentam, com ordem "barato primeiro". Resolve o problema do *back-and-forth*.
> 4. **Karpathy: build adiado, encaixe reservado** — o Movimento II passa a expor o arnês de avaliação que o Movimento III vai consumir.

> Nome ainda provisório. Metáfora-âncora: **kata** — uma sequência codificada que captura o método de um mestre e o torna reprodutível e transmissível sem se corromper.

---

## Princípio nuclear

Transformar a prática **tácita e vivida** de um especialista em um **artefato explícito** que uma inteligência artificial (IA) executa em nível **igual ou superior** ao do próprio especialista — não uma transcrição do que ele faz, mas uma reconstrução pensada para a IA.

Tese por trás de cada fase: a maioria das skills falha não por falta de informação, mas por falha de **extração** (o expert "despeja" texto) e por falha de **reconstrução** (copia-se o gesto sem entender a função). Cada elemento abaixo existe para **neutralizar uma falha específica**.

---

## A espinha: três movimentos

**I. Desmontar** (extração) → **II. Remontar** (reconstrução + validação) → **III. Transcender** (auto-otimização).

A novidade da v0.2: o **Movimento I não é um pipeline, é uma espiral**. Os artefatos crescem em laço, não em linha reta:

> Material bruto (parcial e crescente) → **[espiral: Mapa do Processo ⇄ Mapa de Etapas/Funções ⇄ Mapa de Conhecimento + Léxico + Registros de Decisão]** → SKILL.md v1 + recursos → Skill validada (+ arnês de avaliação exposto) → Skill otimizada → arquivo `.skill`

---

## Mapa de modularidade
*(a decisão 1, concretizada)*

A pergunta "separar ou unificar" era uma falsa escolha. Separamos dois eixos:

- **Autoria** → modular. Cada componente é escrito como unidade auto-contida, afiada e testável sozinha.
- **Invocação** → ponto de entrada único. O usuário chama *uma* coisa ("ajude-me a forjar uma skill do meu método"); não orquestra as peças à mão.

A liga entre os dois é o **orquestrador que detém o estado compartilhado**. Analogia: uma equipe cirúrgica não é um monólito (anestesia + perfusão + cirurgião fundidos); são especialistas + um protocolo (e um cirurgião-líder) que coordena e detém o estado comum — o paciente, o prontuário. Aqui o "prontuário" é o conjunto de artefatos.

| Componente | Standalone? | Função | Consome | Produz | Origem |
|---|---|---|---|---|---|
| **A Forja** (orquestrador) | Não — é o ponto de entrada único | Detém a sequência, os portões e o **estado compartilhado** | — | Coordena tudo | Nova |
| **O Desmonte** | Sim | Quebra o método em etapas; mapeia função e dependências de cada uma | Material + respostas do Grill | Mapa de Etapas/Funções | Irmã da leonardo-method, **polaridade invertida** |
| **O Grill** | Sim | Interroga lacunas tácitas; afia a linguagem; registra decisões | Mapa de Etapas + material | Mapa de Conhecimento + Léxico + Registros de Decisão | grill-with-docs **readaptado** (código → método) |
| **O Construtor** | Parcial | Sintetiza o SKILL.md para um executor de IA; laço testar→avaliar→iterar | Todos os artefatos do Mov. I | SKILL.md validado + **arnês de avaliação** | Derivado da skill-creator |
| **O Otimizador** | Sim (futuro) | Auto-research que afina a skill ao ápice | SKILL.md validado + arnês | Skill otimizada | Inspirado em Karpathy — **build adiado** |

**O orquestrador é o dono dos artefatos:** Mapa do Processo, Mapa de Etapas/Funções, Mapa de Conhecimento, **Léxico** e **Registros de Decisão**. Esse é o tecido conjuntivo — não pode ser espalhado por skills independentes sem memória comum.

**Como a delegação funciona, sem prometer demais:** skills não se "chamam" de forma confiável entre si no modelo atual. Então a lógica de cada componente é escrita **uma vez** como um protocolo auto-contido, e *aflora de duas formas*: (a) como skill standalone instalável, e (b) como recurso embutido que a Forja carrega sob demanda (divulgação progressiva). Mantemos as duas em sincronia no empacotamento. Custo honesto e conhecido: **disciplina de sincronização** — uma única fonte de verdade por protocolo, copiada para a Forja no build.

---

## MOVIMENTO I — EXTRAÇÃO (a espiral)
*(a frente do processo, onde quase todas as skills morrem — e a decisão 3, concretizada)*

A extração **não** é "deposite tudo → desconstrua → interrogue". Isso presumia que o expert já externalizou o método — muitas vezes ele não externalizou (está só na cabeça) e escrever dá trabalho. Forçar um dever de casa em bloco é irreal e pesado. Então:

### Entrada — Ingestão do que existir
O especialista deposita **o que tiver** — pode ser muito (arquivos, exemplos de entrada/saída, artefatos antigos) ou quase nada. O sistema lê tudo e forma o primeiro Mapa do Processo (a visão externa do fluxo). Sem portão de "traga tudo antes de começar".

### O laço — Desmonte ⇄ Grill como co-rotinas
A espiral gira assim, fechando para dentro a cada volta:

1. **Desmontar o que temos.** Quebrar o processo em etapas discretas e, para cada uma, analisar sua **função**: o que realiza, por que existe, o que quebraria sem ela, o que consome e o que entrega. É análise destrutiva — a prática linear vira um grafo de dependências, não uma receita. *(Falha evitada: espelhar a sequência de superfície copia gestos sem entender e quebra fora dos exemplos.)*
2. **Achar a maior lacuna** que o material + a desconstrução ainda não preenchem.
3. **Interrogar só aquilo** (o Grill). Uma pergunta de cada vez, com a resposta recomendada já proposta. Três trabalhos simultâneos:
   - **Afiar a linguagem** — todo termo vago ou sobrecarregado vira um termo canônico, capturado ao vivo no **Léxico**.
   - **Testar com cenários** — inventar casos-limite concretos que forçam precisão sobre as fronteiras entre conceitos.
   - **Capturar o porquê** — quando há trade-off real (difícil de reverter, surpreendente, com alternativas genuínas), registra-se um **Registro de Decisão do Método**.
4. **Ingerir a resposta** (ou o novo arquivo que a pergunta levou o expert a escrever/buscar) e **re-desmontar**. Volta ao passo 1.

**Regra "barato primeiro" — é o que torna o laço *não* pesado:** se a pergunta pode ser respondida pelo material, **não pergunte — explore o material**. A cada volta só se pede a *próxima peça faltante mais valiosa*, nunca um bloco de tarefas. O esforço do expert fica mínimo e sob o controle dele. *(Falha evitada: o conhecimento tácito é o jogo todo — o expert sabe fazer mas não sabe dizer como faz; só a interrogação adversarial guiada por cenários o faz emergir.)*

A espiral trata os dois extremos com elegância: muita documentação → começa pesada em ingestão e desmonte; nada escrito → começa pesada em interrogação, e a **própria transcrição vira o material-fonte**.

### Saída — o portão do especialista
O laço continua **até o próprio especialista declarar "é suficiente"**. Esse portão fecha o Movimento I.

> **A conexão que fecha o círculo (decisão 2 + 3):** este laço *é* a Fase 3 da leonardo-method ("reconstrua, descubra as lacunas, preencha, repita") — só que aplicada ao **próprio método do expert como objeto de estudo**. Por isso o Desmonte é a *irmã* da leonardo-method com a polaridade invertida: lá um humano desmonta um conhecimento externo e o remonta na *própria mente* (e o Claude se segura, coaching socrático); aqui o sistema desmonta o conhecimento *do expert* e o remonta num *artefato de IA* (e o Claude propõe e sintetiza). Aproveitamos os **ossos** (a filosofia da esfera: desmontar para entender a função, não copiar a superfície); deixamos a **carne** específica de cognição humana ao longo de dias (caminhadas, "confusão produtiva", notas de Obsidian, a postura de se segurar). **A leonardo-method permanece intacta como skill de estudo.**

---

## MOVIMENTO II — RECONSTRUÇÃO
*(o meio: síntese + validação — e o encaixe do Karpathy, decisão 4)*

### Remontagem em skill (o Construtor)
Reconstruir o método desmontado como um `SKILL.md` montado **para um executor de IA**, não como transcrição do humano. Divulgação progressiva (metadados / corpo / recursos), descrição-gatilho "insistente", Léxico embutido, **explicar o porquê** de cada instrução em vez de regras rígidas, e — onde a desconstrução revelou trabalho determinístico repetido — empacotar scripts para não reinventá-los a cada execução. *(Falha evitada: é aqui que se ganha ou perde a qualidade ≥ expert; reconstruir, em vez de copiar, é o que leva ao ápice de performance.)*

### Testar → avaliar → iterar
Prompts de teste realistas → rodar a IA-com-a-skill → revisar qualitativa **e** quantitativamente → reescrever → repetir. Ler as **transcrições**, não só as saídas, para flagrar a skill fazendo a IA desperdiçar esforço. Casos de teste reservados como defesa contra o sobreajuste. *(Falha evitada: skill afinada para três exemplos em vez de robusta para um milhão de usos.)*

> **Encaixe reservado para o Movimento III:** o produto deste movimento **expõe o arnês de avaliação** (casos de teste + asserções) como interface pública. Adiamos a *construção* do Otimizador, mas **não fechamos a porta** dele.

**Produz:** SKILL.md validado + arnês de avaliação exposto.

---

## MOVIMENTO III — TRANSCENDÊNCIA
*(a retaguarda nova — build adiado, encaixe reservado)*

### Auto-otimização por auto-research (o Otimizador)
Em vez de só o humano refinar, o sistema roda seu próprio laço de pesquisar-e-melhorar: gera avaliações de gatilho, propõe variantes de descrição e de instruções, avalia-as em casos **reservados** (divisão treino/teste para não sobreajustar) e mantém a vencedora — estendendo a ideia além da descrição, para o corpo e os scripts, onde for mensurável. *(Falha evitada: remove o humano como gargalo na última milha da otimização.)*

**Status:** build **adiado** por decisão conjunta. Razões — (1) opera sobre uma skill já pronta e validada, é logicamente a jusante; (2) os Movimentos I e II são os 80% que decidem se a forja funciona, e o III multiplica *zero* se eles não estiverem certos; (3) vou ler o material específico de **Andrej Karpathy** sobre auto-research *quando chegarmos aqui*, para desenhar com a fonte na mão e não de memória vaga.

---

## Empacotar e entregar
Empacotar num arquivo `.skill` instalável. O **Léxico** e os **Registros de Decisão** viajam junto como documentação da razão de ser da skill — viram a sua **memória institucional**: quem for editá-la no futuro entende *por que* ela é como é e não viola a lógica de projeto original. (É a metade "with-docs" do grill-with-docs, reaproveitada.)

---

## A simetria do método

- **Movimento I** desmonta: humano → partes.
- **Movimento II** remonta: partes → artefato de IA.
- **Movimento III** transcende: artefato → ápice.

**Desmontar / Remontar / Transcender.** E note a coerência: as decisões apontam todas para o mesmo lugar — **modular, em espiral, por partes**. O método quer ser construído do mesmo jeito que ele opera.

---

## Pano de fundo

No limite, este método é uma máquina de **democratizar conhecimento tácito de especialista**: codificar o raciocínio de um cirurgião ou cardiologista de forma que um generalista numa unidade do SUS (Sistema Único de Saúde) — ou uma IA assistindo-o — alcance um resultado de nível especializado.

---

## Estado atual e próximo passo
- **Decidido e fixado:** os três movimentos; a espiral do Movimento I; o mapa de modularidade; a polaridade invertida do Desmonte; o encaixe reservado do Karpathy.
- **Próximo passo:** descer para o texto e **adaptar o grill-with-docs como o motor do Grill** — a co-rotina de interrogação do Movimento I — reapontando-o de "código" para "método de especialista", já com os três trabalhos (afiar linguagem, cenários, registrar decisões) e a regra "barato primeiro".
