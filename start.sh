#!/bin/bash

# 智能简历处理器启动脚本

echo "==================================="
echo "    智能简历处理器启动脚本"
echo "==================================="

# 检查Python版本
echo "检查Python版本..."
python3 --version

# 检查虚拟环境
if [ ! -d "venv" ]; then
    echo "错误: 虚拟环境不存在，请先运行安装脚本"
    exit 1
fi

# 激活虚拟环境
echo "激活虚拟环境..."
source venv/bin/activate

# 检查依赖
echo "检查依赖包..."
pip list | grep -E "(Flask|reportlab|python-docx)" > /dev/null
if [ $? -ne 0 ]; then
    echo "警告: 某些依赖包可能未安装，正在安装..."
    pip install -r requirements.txt
fi

# 创建必要目录
echo "创建必要目录..."
mkdir -p src/uploads
mkdir -p src/outputs
mkdir -p logs

# 检查端口
echo "检查端口5000..."
if lsof -Pi :5000 -sTCP:LISTEN -t >/dev/null ; then
    echo "警告: 端口5000已被占用，请先关闭占用该端口的程序"
    echo "可以使用以下命令查看占用进程: lsof -i :5000"
    exit 1
fi

# 启动应用
echo "启动智能简历处理器..."
echo "访问地址: http://localhost:5000"
echo "按 Ctrl+C 停止服务"
echo "==================================="

python src/main.py

