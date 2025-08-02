# 第一阶段：构建阶段
FROM node:16.17.0-alpine as build-stage

# 设置工作目录
WORKDIR /app

# 复制包管理文件
COPY package*.json ./
COPY pnpm-lock.yaml ./

# 安装 pnpm
RUN npm install -g pnpm@8.12.0

# 安装依赖
RUN pnpm install

# 复制源代码
COPY . .

# 构建应用
RUN pnpm build

# 第二阶段：生产阶段
FROM nginx:alpine as production-stage

# 复制构建结果到nginx目录
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 复制nginx配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露端口
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]
