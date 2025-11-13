# PUBG Verso - Design System (Aplicação)

## 📌 Objetivo do Repositório

Este repositório é uma **evolução do projeto anterior**, que continha
apenas o *sample* dos componentes do Design System.\
Agora, além dos componentes prontos (botões, inputs, cards, tabs,
tabbar, link etc.), este repositório demonstra **como aplicar os
componentes na construção de uma aplicação real**, servindo como estudo
de arquitetura, boas práticas e organização de código.

------------------------------------------------------------------------

## 🎯 Propósito do Projeto

O objetivo do **PUBG Verso** é oferecer uma ferramenta clara e eficiente
para jogadores de PUBG compararem armas, visualizarem efeitos de
acessórios e decidirem melhores configurações de combate.

Nesta nova fase, o objetivo também é **estudar a aplicação prática de um
Design System + MVVM**, transformando o sample de componentes em uma
aplicação funcional.

------------------------------------------------------------------------

## 🏛 Arquitetura Utilizada --- MVVM

A arquitetura escolhida foi **MVVM (Model--View--ViewModel)**, por ser
simples, modular e ideal para projetos Flutter com Design System.

### Como funciona no projeto:

-   **View**
    -   Apenas renderiza UI.\
    -   Não contém lógica de negócio.\
    -   Recebe estado pronto do ViewModel.
-   **ViewModel**
    -   Contém lógica, estados e ações.\
    -   Expõe valores reativos para a View.\
    -   Mantém os dados prontos para renderização.
-   **Model**
    -   Representa dados estruturados, como armas, acessórios e
        estatísticas.

### Exemplo real do projeto:

-   `ActionButtonViewModel` controla estado do botão (tamanho, estilo,
    ação).\
-   `InputTextViewModel` controla texto, validação, tipo (senha, texto
    etc.).\
-   `InfoCardViewModel` popula cards de arma com dados vindos do model.

Essa separação garante:

-   Reutilização dos componentes.\
-   Fácil manutenção.\
-   Mais organização e legibilidade.

------------------------------------------------------------------------

## 📚 Estrutura Geral

    DesignSystem/
      Components/
        Buttons/
        InputField/
        Card/
        Avatar/
        ValueComparisonCard/
      Shared/
        colors.dart
        styles.dart
        constants.dart
    Application/
      Screens/
      ViewModels/
      Models/

------------------------------------------------------------------------

## 🧩 Componentes do Design System (Resumo)

### 🔹 ActionButton

Botão customizável com estilos primário, secundário e destrutivo.

### 🔹 AppCard

Card para exibir dados, imagens e ações.

### 🔹 StyledInputField

Campo de texto estilizado com suporte para temas e validação.

### 🔹 UserAvatar

Avatar circular com imagem ou ícone.

### 🔹 ValueComparisonCard

Comparação de dois valores (ex.: estatísticas de armas).

------------------------------------------------------------------------

## 🧪 Uso dos Componentes na Aplicação

O objetivo principal deste repositório é mostrar **como transformar o
Design System em uma aplicação completa**, por exemplo:

-   Tela de seleção de armas utilizando `AppCard`
-   Filtros utilizando `StyledInputField`
-   Botões de ação usando `ActionButton`
-   Comparação de valores com `ValueComparisonCard`
-   Perfil e usuário com `UserAvatar`

------------------------------------------------------------------------

## 🛠 Como Executar o Projeto

1.  Criar um projeto Flutter:

```{=html}
<!-- -->
```
    flutter create nome_do_projeto

2.  Entrar na pasta **lib** e clonar o repositório:

```{=html}
<!-- -->
```
    cd nome_do_projeto/lib
    git clone https://github.com/keven-rdr/PUBG_VERSO_DESIGN_SYSTEM .

3.  Rodar dependências:

```{=html}
<!-- -->
```
    flutter pub get

4.  Executar:

```{=html}
<!-- -->
```
    flutter run

------------------------------------------------------------------------

## 📦 pubspec.yaml recomendado

``` yaml
name: pubg_verso
description: "Aplicação utilizando o Design System do PUBG Verso."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  lottie: ^3.1.0
  lucide_icons: ^0.311.0
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/animations/
    - assets/images/
    - assets/img/avatar/
```

------------------------------------------------------------------------

## 🧭 Link do Design System no Figma

*(Adicione seu link aqui)*

------------------------------------------------------------------------

## 🧠 Conclusão

Este repositório é um **estudo prático de arquitetura MVVM aplicada em
Flutter**, utilizando um **Design System completo** como base para criar
telas reais e funcionais.

O foco é:

-   Evolução do sample → aplicação real\
-   Uso correto do MVVM\
-   Reutilização e escalabilidade dos componentes\
-   Organização profissional de código

------------------------------------------------------------------------

Desenvolvido por **Keven Lucas** para estudo, aprendizado e evolução
como desenvolvedor.
