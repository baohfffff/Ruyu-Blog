# 使用Node.js 16作为构建环境
FROM node:16-alpine as builder

# 设置工作目录
WORKDIR /app

# 安装pnpm
RUN npm install -g pnpm@8.12.0

# 复制package.json和pnpm-lock.yaml
COPY package.json pnpm-lock.yaml* ./

# 安装依赖
RUN pnpm install --frozen-lockfile

# 复制源代码
COPY . .

# 构建应用
RUN pnpm build

# 使用nginx作为生产环境
FROM nginx:alpine

# 复制构建好的文件到nginx目录
COPY --from=builder /app/dist /usr/share/nginx/html

# 复制nginx配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]
