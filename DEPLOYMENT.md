# StockLink 部署指南

## 概述

StockLink 采用微前端架构，包含两个独立的应用：
- **热力图应用** (`apps/heatmap`) - 作为主入口
- **个股详情页应用** (`apps/details`) - 显示个股详细信息

## 前置要求

### 环境准备
- Node.js >= 18.0.0
- npm >= 8.0.0
- Git
- Vercel CLI (可选)

### API 密钥准备
- **Polygon.io API Key**: 用于获取股票数据
- **Finnhub API Key**: 用于获取公司信息和新闻
- **Neon Database URL**: PostgreSQL 数据库连接

## 本地开发设置

### 1. 克隆并导入子仓库

```bash
# 克隆主仓库
git clone <your-stocklink-repo>
cd StockLink

# 导入热力图应用
git subtree add --prefix=apps/heatmap \
  https://github.com/simonxinpan/Heatmap-pro.git HM-Pro-V5.6 --squash

# 导入个股详情页应用
git subtree add --prefix=apps/details \
  https://github.com/simonxinpan/Stock-name-pages.git Stock-details-V17.3 --squash
```

### 2. 安装依赖

```bash
# 安装所有应用的依赖
npm run install:all

# 或者分别安装
cd apps/heatmap && npm install
cd ../details && npm install
```

### 3. 环境变量配置

#### 热力图应用 (`apps/heatmap/.env.local`)
```env
POLYGON_API_KEY=your_polygon_api_key
FINNHUB_API_KEY=your_finnhub_api_key
DATABASE_URL=your_neon_database_url
NEXT_PUBLIC_APP_URL=http://localhost:3000
NEXT_PUBLIC_DETAILS_URL=http://localhost:3001
```

#### 个股详情页应用 (`apps/details/.env.local`)
```env
POLYGON_API_KEY=your_polygon_api_key
FINNHUB_API_KEY=your_finnhub_api_key
DATABASE_URL=your_neon_database_url
NEXT_PUBLIC_APP_URL=http://localhost:3001
NEXT_PUBLIC_HEATMAP_URL=http://localhost:3000
```

### 4. 启动开发服务器

```bash
# 启动热力图应用 (端口 3000)
npm run dev:heatmap

# 启动个股详情页应用 (端口 3001)
npm run dev:details
```

## Vercel 部署

### 推荐部署方案：独立部署

由于StockLink采用微前端架构，**强烈推荐**对每个应用进行独立部署，这样可以：
- 避免配置冲突
- 独立版本控制
- 更好的性能和稳定性

#### 1. 部署热力图应用
```bash
# 直接从原始仓库部署
git clone https://github.com/simonxinpan/Heatmap-pro.git
cd Heatmap-pro
vercel --prod
```

**环境变量设置**:
- `POLYGON_API_KEY`
- `FINNHUB_API_KEY`
- `DATABASE_URL`
- `NEXT_PUBLIC_DETAILS_URL` (个股详情页的生产URL)

#### 2. 部署个股详情页应用
```bash
# 直接从原始仓库部署
git clone https://github.com/simonxinpan/Stock-name-pages.git
cd Stock-name-pages
vercel --prod
```

**环境变量设置**:
- `POLYGON_API_KEY`
- `FINNHUB_API_KEY`
- `DATABASE_URL`
- `NEXT_PUBLIC_HEATMAP_URL` (热力图的生产URL)

### 注意事项

⚠️ **避免从StockLink父仓库直接部署**
- StockLink主要用于本地开发和代码管理
- 生产环境应直接从各自的原始仓库部署
- 这样可以避免Vercel配置冲突和构建问题

## 应用间通信

### URL 参数传递
- 热力图点击个股 → 跳转到详情页: `/details?symbol=AAPL`
- 热力图点击行业 → 行业热力图: `/heatmap?sector=Technology`

### LocalStorage 数据共享
```javascript
// 存储选中的股票信息
localStorage.setItem('selectedStock', JSON.stringify({
  symbol: 'AAPL',
  name: 'Apple Inc.',
  sector: 'Technology'
}));

// 读取股票信息
const stockInfo = JSON.parse(localStorage.getItem('selectedStock'));
```

## 监控和维护

### 性能监控
- Vercel Analytics 自动启用
- Core Web Vitals 监控
- API 响应时间追踪

### 错误监控
- Vercel 错误日志
- 自定义错误边界
- API 错误处理

### 更新策略
```bash
# 更新热力图应用
git subtree pull --prefix=apps/heatmap \
  https://github.com/simonxinpan/Heatmap-pro.git HM-Pro-V5.6 --squash

# 更新个股详情页应用
git subtree pull --prefix=apps/details \
  https://github.com/simonxinpan/Stock-name-pages.git Stock-details-V17.3 --squash
```

## 故障排除

### 常见问题

1. **API 限流**
   - 检查 API 密钥配额
   - 实现请求缓存
   - 添加重试机制

2. **跨域问题**
   - 配置 CORS 头
   - 使用代理 API

3. **数据库连接**
   - 检查 Neon 数据库状态
   - 验证连接字符串
   - 检查网络连接

### 日志查看
```bash
# Vercel 日志
vercel logs <deployment-url>

# 本地开发日志
npm run dev:heatmap  # 查看热力图日志
npm run dev:details  # 查看详情页日志
```

## 安全注意事项

1. **API 密钥保护**
   - 仅在服务端使用敏感密钥
   - 使用环境变量存储
   - 定期轮换密钥

2. **数据库安全**
   - 使用连接池
   - 启用 SSL 连接
   - 限制数据库访问权限

3. **HTTPS 强制**
   - Vercel 自动启用 HTTPS
   - 配置安全头
   - 实施 CSP 策略

## 扩展指南

### 添加新应用
1. 在 `apps/` 目录下创建新应用
2. 更新 `package.json` 脚本
3. 配置 `vercel.json` 路由
4. 设置环境变量
5. 实现应用间通信

### 性能优化
- 启用 CDN 缓存
- 实施代码分割
- 优化图片资源
- 使用 Service Worker
- 实施预加载策略