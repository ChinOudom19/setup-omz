#!/bin/bash

ZSHRC="$HOME/.zshrc"
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "✅ Oh My Zsh is already installed."
else
  echo "🔄 Updating system and installing dependencies..."
  sudo apt update > /dev/null 2>&1
  sudo apt install -y zsh curl git > /dev/null 2>&1

  echo "📦 Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" > /dev/null 2>&1

  echo "🔌 Installing plugins..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions" > /dev/null 2>&1
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" > /dev/null 2>&1

  echo "⚙️  Configuring .zshrc..."
  sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="cloud"/' "$ZSHRC"
  sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
fi

echo "⚡ Starting zsh..."
exec zsh
