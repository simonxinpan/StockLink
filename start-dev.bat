@echo off
echo ========================================
echo StockLink 微前端开发环境启动脚本
echo ========================================
echo.

echo 检查 Node.js 环境...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未找到 Node.js，请先安装 Node.js
    pause
    exit /b 1
)

echo Node.js 环境正常
echo.

echo 检查项目结构...
if not exist "apps\heatmap" (
    echo 警告: apps\heatmap 目录不存在
    echo 请先运行以下命令导入热力图代码:
    echo git subtree add --prefix=apps/heatmap https://github.com/simonxinpan/Heatmap-pro.git HM-Pro-V5.6 --squash
    echo.
)

if not exist "apps\details" (
    echo 警告: apps\details 目录不存在
    echo 请先运行以下命令导入个股详情页代码:
    echo git subtree add --prefix=apps/details https://github.com/simonxinpan/Stock-name-pages.git Stock-details-V17.3 --squash
    echo.
)

echo 启动开发服务器...
echo.

echo 启动热力图应用 (端口 3000)...
start "Heatmap App" cmd /k "cd /d %~dp0apps\heatmap && npm run dev"

echo 等待 3 秒...
timeout /t 3 /nobreak >nul

echo 启动个股详情页应用 (端口 3001)...
start "Stock Details App" cmd /k "cd /d %~dp0apps\details && npm run dev"

echo.
echo ========================================
echo 开发环境启动完成!
echo ========================================
echo.
echo 热力图应用: http://localhost:3000
echo 个股详情页: http://localhost:3001
echo 开发导航页: 打开 index.html
echo.
echo 按任意键打开开发导航页...
pause >nul

start "" "index.html"

echo 开发环境已就绪，祝您开发愉快!
pause