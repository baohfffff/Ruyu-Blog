# 🐳 Ruyu博客 Docker 一键部署指南

## 📋 项目简介

基于 SpringBoot3 + Vue3 开发的前后端分离个人博客系统，支持Docker一键部署。

## 🛠️ 环境要求

- **Docker**: 20.0+
- **Docker Compose**: 2.0+
- **服务器内存**: 建议 4GB+
- **磁盘空间**: 建议 20GB+

## 🚀 快速部署

### 1. 克隆项目
```bash
git clone https://github.com/kuailemao/Ruyu-Blog.git
cd Ruyu-Blog
```

### 2. 选择部署方式

#### 方式一：简化部署（推荐）
```bash
# 使用简化版配置，直接暴露端口
docker compose -f docker-compose-simple.yml up -d
```

#### 方式二：完整部署（包含Nginx）
```bash
# 使用完整版配置，通过Nginx统一代理
docker compose -f docker-compose-full.yml up -d
```

### 3. 等待服务启动

首次启动需要下载镜像和构建，大约需要10-15分钟。

```bash
# 查看启动进度
docker compose logs -f

# 查看服务状态
docker compose ps
```

### 4. 创建MinIO存储桶

```bash
# 进入MinIO容器
docker exec -it blog-minio mc alias set local http://localhost:9000 admin 12345678

# 创建存储桶
docker exec -it blog-minio mc mb local/blog

# 设置公开访问
docker exec -it blog-minio mc anonymous set public local/blog
```

## 🌐 访问地址

### 简化部署版本
- **前台博客**: http://localhost:8080
- **后台管理**: http://localhost:8081  
- **后端API**: http://localhost:8088
- **MinIO控制台**: http://localhost:9001 (admin/12345678)
- **RabbitMQ管理**: http://localhost:15672 (admin/123456)

### 完整部署版本（Nginx代理）
- **前台博客**: http://localhost
- **后台管理**: http://admin.localhost
- **后端API**: http://api.localhost
- **文件服务**: http://files.localhost

## 👤 默认账号

- **管理员账号**: ADMIN
- **密码**: 123456

## 📁 项目结构

```
├── docker-compose-simple.yml    # 简化部署配置
├── docker-compose-full.yml      # 完整部署配置  
├── blog-backend/                 # 后端代码
│   ├── Dockerfile
│   └── src/main/resources/
│       └── application-docker.yml
├── blog-frontend/
│   ├── kuailemao-blog/          # 前台
│   │   ├── Dockerfile
│   │   └── nginx.conf
│   └── kuailemao-admin/         # 后台
│       ├── Dockerfile
│       └── nginx.conf
└── nginx/                       # 主Nginx配置
    └── nginx.conf
```

## 🔧 配置说明

### 数据库配置
- **用户名**: root
- **密码**: 123456
- **数据库**: blog
- **端口**: 3306

### Redis配置
- **端口**: 6379
- **无密码**

### RabbitMQ配置
- **用户名**: admin
- **密码**: 123456
- **端口**: 5672 (AMQP), 15672 (Web管理)

### MinIO配置
- **用户名**: admin
- **密码**: 12345678
- **端口**: 9000 (API), 9001 (控制台)

## 🛠️ 常用命令

```bash
# 启动所有服务
docker compose up -d

# 停止所有服务
docker compose down

# 重启特定服务
docker compose restart blog-backend

# 查看日志
docker compose logs -f blog-backend

# 进入容器
docker exec -it blog-backend bash

# 清理所有数据（谨慎使用）
docker compose down -v
```

## 🔍 故障排查

### 1. 服务启动失败
```bash
# 查看具体错误日志
docker compose logs service-name

# 检查端口占用
netstat -tlnp | grep :8088
```

### 2. 数据库连接问题
```bash
# 检查MySQL是否正常启动
docker exec -it blog-mysql mysql -uroot -p123456 -e "SELECT 1"
```

### 3. 前端无法访问后端API
- 检查后端服务是否正常启动
- 确认防火墙设置
- 检查nginx配置

### 4. 文件上传失败
- 检查MinIO是否正常运行
- 确认存储桶是否创建
- 检查存储桶权限设置

## 📝 生产环境建议

1. **修改默认密码**
   - 数据库密码
   - RabbitMQ密码
   - MinIO密码
   - JWT密钥

2. **配置SSL证书**
   - 使用Let's Encrypt免费证书
   - 修改Nginx配置支持HTTPS

3. **数据备份**
   - 定期备份MySQL数据
   - 备份MinIO文件数据

4. **监控告警**
   - 配置日志收集
   - 设置资源监控

## 🎯 更新部署

```bash
# 拉取最新代码
git pull origin main

# 重新构建并启动
docker compose up -d --build

# 或者指定服务更新
docker compose up -d --build blog-backend
```

## 📞 技术支持

- **项目地址**: https://github.com/kuailemao/Ruyu-Blog
- **问题反馈**: https://github.com/kuailemao/Ruyu-Blog/issues
- **QQ交流群**: 635887836

---

🎉 **部署完成后，你就拥有了一个功能完整的个人博客系统！**