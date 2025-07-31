# Vercel 部署说明

## 为什么删除了 vercel.json？

我们删除了 StockLink 父仓库中的 `vercel.json` 文件，原因如下：

### 1. 避免配置冲突
- Vercel 不允许同时使用 `builds` 和 `functions` 属性
- 微前端架构中，每个应用应该有自己的部署配置
- 统一配置容易导致复杂的路由和构建问题

### 2. 明确架构职责
- **StockLink 父仓库**: 用于本地开发、代码管理和文档
- **子应用仓库**: 用于生产部署和独立维护

### 3. 最佳实践
- 微前端应用应该独立部署
- 每个应用有自己的 CI/CD 流程
- 避免单点故障和部署依赖

## 正确的部署方式

### 生产环境部署

#### 热力图应用 (Heatmap-pro) - 平台唯一入口
```bash
git clone -b HM-Pro-V5.6 https://github.com/simonxinpan/Heatmap-pro.git
cd Heatmap-pro
vercel --prod
```
**当前生产URL**: https://heatmap-pro-jn8bqzuiw-simon-pans-projects.vercel.app/
**说明**: 此为平台唯一入口，无需额外Landing页面，直接展示全景热力图

#### 个股详情页 (Stock-name-pages)
```bash
git clone -b Stock-details-V17.3 https://github.com/simonxinpan/Stock-name-pages.git
cd Stock-name-pages
vercel --prod
```
**当前生产URL**: https://stock-details-final-gmguhh0c4-simon-pans-projects.vercel.app/

### 本地开发

```bash
# 在 StockLink 目录下
npm run dev:heatmap    # 启动热力图应用
npm run dev:details    # 启动个股详情页应用
```

## 环境变量配置

每个应用需要在 Vercel 项目设置中配置以下环境变量：

- `POLYGON_API_KEY`: Polygon.io API 密钥
- `FINNHUB_API_KEY`: Finnhub API 密钥
- `DATABASE_URL`: Neon PostgreSQL 数据库连接字符串
- `NEXT_PUBLIC_HEATMAP_URL`: 热力图应用的生产URL
- `NEXT_PUBLIC_DETAILS_URL`: 个股详情页应用的生产URL

## 应用间通信

通过 URL 参数实现应用间跳转：

```javascript
// 从热力图跳转到个股详情
window.open(`${process.env.NEXT_PUBLIC_DETAILS_URL}?symbol=AAPL`, '_blank');

// 从个股详情返回热力图
window.open(`${process.env.NEXT_PUBLIC_HEATMAP_URL}?sector=Technology`, '_blank');
```

## 总结

这种部署方式的优势：
- ✅ 避免配置冲突
- ✅ 独立版本控制
- ✅ 更好的性能和稳定性
- ✅ 符合微前端最佳实践
- ✅ 简化 CI/CD 流程

如需更多详细信息，请参考 [DEPLOYMENT.md](./DEPLOYMENT.md)。