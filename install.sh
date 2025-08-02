#!/bin/bash

echo "🚀 开始安装 Ruyu 博客项目环境..."

# 安装 Java 17
echo "📦 安装 Java 17..."
sudo apt update
sudo apt install -y openjdk-17-jdk

# 验证 Java 安装
echo "✅ Java 版本："
java --version

# 安装 Node.js 16.17.0
echo "📦 安装 Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 16.17.0
nvm use 16.17.0

# 安装 pnpm
echo "📦 安装 pnpm..."
npm install -g pnpm@8.12.0

# 验证安装
echo "✅ Node.js 版本："
node --version
echo "✅ pnpm 版本："
pnpm --version

echo "🎉 环境安装完成！"
echo ""
echo "接下来请运行以下命令启动服务："
echo "1. 启动后端："
echo "   cd blog-backend && ./mvnw spring-boot:run"
echo ""
echo "2. 启动前台（新终端）："
echo "   cd blog-frontend/kuailemao-blog && pnpm install && pnpm dev"
echo ""
echo "3. 启动后台管理（新终端）："
echo "   cd blog-frontend/kuailemao-admin && pnpm install && pnpm dev"