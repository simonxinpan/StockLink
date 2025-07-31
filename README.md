# StockLink - 微前端股票分析平台

## 项目概述

**StockLink** 是一个基于微前端架构的股票分析平台父仓库，专门用于连接和整合多个独立的股票分析应用。平台以全景热力图作为主入口，通过点击交互无缝连接到个股详情页，为用户提供从宏观到微观的完整投资分析体验。

## 核心价值主张

- **全景市场洞察**: 通过热力图直观展示整个标普500市场的实时动态
- **深度个股分析**: 提供专业级的个股数据分析和可视化工具
- **智能信息整合**: 多数据源整合，提供实时报价、历史数据和新闻资讯
- **多语言支持**: 智能翻译功能，降低语言障碍
- **微前端架构**: 模块化设计，支持独立开发和部署

## 目标用户

### 主要用户群体
1. **个人投资者** (25-45岁)
   - 关注美股市场的中国投资者
   - 需要专业分析工具的投资爱好者
   - 希望获得中文信息的海外华人投资者

2. **专业交易员** (30-50岁)
   - 需要快速市场概览的专业人士
   - 寻求高效分析工具的金融从业者
   - 关注标普500成分股的机构投资者

3. **金融学习者** (20-35岁)
   - 金融专业学生和研究人员
   - 希望学习美股投资的新手
   - 需要实时数据进行研究的分析师

## 核心功能模块

### 1. 全景热力图 (Market Heatmap)
- **在线应用**: [https://heatmap-drljknez4-simon-pans-projects.vercel.app](https://heatmap-drljknez4-simon-pans-projects.vercel.app)
- **GitHub仓库**: [https://github.com/simonxinpan/Heatmap-pro/tree/HM-Pro-V5.6](https://github.com/simonxinpan/Heatmap-pro/tree/HM-Pro-V5.6)
- **功能描述**: 标普500成分股实时热力图展示，支持行业分类和个股点击跳转
- **交互设计**: 
  - 点击行业区域 → 进入行业热力图页面
  - 点击个股方块 → 跳转到个股详情页
- **技术栈**: Next.js, TradingView图表库, Tailwind CSS
- **数据源**: Polygon API, Finnhub API

### 2. 智能个股详情页 (Smart Stock Details)
- **在线应用**: [https://stock-details-final-gmguhh0c4-simon-pans-projects.vercel.app](https://stock-details-final-gmguhh0c4-simon-pans-projects.vercel.app)
- **GitHub仓库**: [https://github.com/simonxinpan/Stock-name-pages/tree/Stock-details-V17.3](https://github.com/simonxinpan/Stock-name-pages/tree/Stock-details-V17.3)
- **功能描述**: 个股深度分析，包含K线图、财务指标、公司信息和中英双语新闻
- **核心特性**:
  - 实时股价和K线图分析
  - 全面财务指标展示
  - 中英双语支持和智能翻译
  - 响应式设计，多端适配
- **技术栈**: Next.js 14, TypeScript, TradingView图表库, Tailwind CSS
- **数据源**: Finnhub API, Neon PostgreSQL数据库

## 项目结构

### 文件夹组织

```
StockLink/
├── apps/
│   ├── heatmap/          # 全景热力图应用
│   │   └── (从 Heatmap-pro 仓库导入)
│   └── details/          # 个股详情页应用
│       └── (从 Stock-name-pages 仓库导入)
├── docs/                 # 产品文档
├── README.md            # 项目说明
└── package.json         # 依赖管理
```

### 代码导入说明

#### 热力图应用导入
```bash
# 从GitHub仓库导入热力图代码
git subtree add --prefix=apps/heatmap \
  https://github.com/simonxinpan/Heatmap-pro.git HM-Pro-V5.6 --squash
```

#### 个股详情页导入
```bash
# 从GitHub仓库导入个股详情页代码
git subtree add --prefix=apps/details \
  https://github.com/simonxinpan/Stock-name-pages.git Stock-details-V17.3 --squash
```

## 快速开始

### 环境要求
- Node.js >= 18.0.0
- npm >= 8.0.0
- Git
- 现代浏览器支持

### 一键启动开发环境 (Windows)
```bash
# 运行开发启动脚本
start-dev.bat
```

### 手动设置开发环境

#### 1. 导入子应用代码
```bash
# 导入热力图应用
git subtree add --prefix=apps/heatmap \
  https://github.com/simonxinpan/Heatmap-pro.git HM-Pro-V5.6 --squash

# 导入个股详情页应用
git subtree add --prefix=apps/details \
  https://github.com/simonxinpan/Stock-name-pages.git Stock-details-V17.3 --squash
```

#### 2. 安装依赖
```bash
# 安装所有应用依赖
npm run install:all
```

#### 3. 配置环境变量
在各应用目录下创建 `.env.local` 文件，配置API密钥和数据库连接。

#### 4. 启动开发服务器
```bash
# 启动热力图应用 (端口 3000)
npm run dev:heatmap

# 启动个股详情页应用 (端口 3001)
npm run dev:details
```

#### 5. 访问应用
- 热力图应用: http://localhost:3000
- 个股详情页: http://localhost:3001
- 开发导航页: 打开 `index.html`

### 部署到Vercel
详细部署说明请参考 [DEPLOYMENT.md](./DEPLOYMENT.md)

## 技术架构

### 微前端架构

#### 架构设计理念

**StockLink** 作为父仓库，采用微前端架构连接两个核心应用：

- **独立仓库管理**: 热力图和个股详情页分别维护在独立的GitHub仓库中
- **父仓库整合**: StockLink仅作为连接器，不包含业务逻辑
- **热力图入口**: 全景热力图作为平台主入口，无需额外的landing页面
- **无缝跳转**: 通过点击交互实现应用间的无缝导航
- **独立部署**: 每个应用独立部署在Vercel上，环境变量独立配置

本项目采用**微前端 (Micro Frontends)** 架构，每个核心功能模块都是一个独立的、可独立部署的应用。

**架构优势**:
- **独立仓库与部署**: 每个模块拥有自己的 GitHub 仓库和 Vercel 部署实例，实现了开发、测试和发布的完全解耦
- **URL 驱动的集成**: 各模块之间通过标准的 URL 链接和查询参数 (`?symbol=AAPL`) 进行通信和导航
- **技术栈灵活性**: 每个模块可以选择最适合的技术栈

### 微前端集成方式
- **入口应用**: 热力图作为主入口，无需额外landing页面
- **应用通信**: 通过URL参数和localStorage实现数据传递
- **部署策略**: 每个应用独立部署在Vercel上
- **环境配置**: 各应用独立配置API密钥和数据库连接

### 技术栈
- **前端**: Alpine.js, Tailwind CSS (via CDN)
- **后端**: Vercel Serverless Functions (Node.js)
- **数据源**: 
  - Finnhub (报价/基本面)
  - Polygon.io (K线图)
  - Volcengine (翻译)
- **部署平台**: Vercel

### 数据源配置
- **Polygon API**: 股票实时数据和历史K线
- **Finnhub API**: 公司信息、财务指标、新闻资讯
- **Neon PostgreSQL**: 标普500数据库存储
- **环境变量**: 已在各Vercel项目中配置完成

## 数据源集成

### 主要API服务
1. **Finnhub API**
   - 实时股价数据
   - 基本面财务指标
   - 公司基本信息
   - 相关新闻资讯

2. **Polygon.io API**
   - 历史K线数据
   - 多时间维度图表
   - 技术分析数据

3. **火山引擎翻译API**
   - 新闻标题中英翻译
   - 高质量机器翻译
   - 实时翻译服务

## 商业模式

### 当前阶段：免费服务
- 基于免费API提供基础功能
- 积累用户基础和使用数据
- 验证产品市场契合度

### 未来发展方向
1. **增值服务**
   - 高级数据分析功能
   - 实时数据推送
   - 个性化投资建议

2. **订阅模式**
   - 专业版功能订阅
   - 去广告服务
   - 高频数据更新

3. **B2B服务**
   - 企业级数据API
   - 白标解决方案
   - 定制化开发服务

## 发展路线图

### 当前阶段 (已完成)
- ✅ 市场热力图模块
- ✅ 个股详情页模块
- ✅ 微前端架构搭建
- ✅ 多数据源集成

### 短期目标 (3-6个月)
- 🔄 用户体验优化
- 🔄 移动端适配
- 🔄 性能优化
- 🔄 更多技术指标

### 中期目标 (6-12个月)
- 📋 用户账户系统
- 📋 自选股功能
- 📋 投资组合管理
- 📋 智能筛选器

### 长期目标 (12个月+)
- 📋 AI投资建议
- 📋 社区功能
- 📋 多市场支持
- 📋 移动应用开发

## 竞争优势

1. **微前端架构**: 灵活的模块化设计，支持快速迭代和扩展
2. **多语言支持**: 智能翻译功能，服务全球华人投资者
3. **免费开放**: 基于免费API，降低用户使用门槛
4. **专业数据**: 整合多个权威数据源，提供准确可靠的信息
5. **用户体验**: 直观的可视化设计，降低学习成本

## 成功指标

### 用户指标
- **日活跃用户数 (DAU)**: 目标1000+
- **月活跃用户数 (MAU)**: 目标10000+
- **用户留存率**: 7日留存>30%，30日留存>15%
- **页面停留时间**: 平均>3分钟

### 产品指标
- **页面加载速度**: <2秒
- **数据更新频率**: 实时数据延迟<15秒
- **功能使用率**: 热力图点击率>50%
- **跨模块导航率**: >40%

### 技术指标
- **系统可用性**: >99.9%
- **API响应时间**: <500ms
- **错误率**: <0.1%

## 风险评估

### 技术风险
- **API限制**: 免费API的调用限制和稳定性
- **数据质量**: 第三方数据源的准确性和及时性
- **性能瓶颈**: 高并发访问时的系统性能

### 市场风险
- **竞争加剧**: 大型金融平台的竞争
- **用户获取**: 新产品的用户认知和接受度
- **监管变化**: 金融数据服务的合规要求

### 应对策略
- 多数据源备份机制
- 性能监控和优化
- 用户反馈收集和快速迭代
- 法律合规咨询

---

*SP500 Insight Platform致力于为投资者提供专业、便捷、智能的美股市场分析工具，通过技术创新降低投资分析的门槛，助力用户做出更明智的投资决策。*