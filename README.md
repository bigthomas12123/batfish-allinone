# batfish-allinone

从 [batfish/batfish](https://github.com/batfish/batfish) 官方源码编译出的 **Batfish allinone fat JAR**，附官方 `questions/` 问题模板目录，可在离线 / 内网机器上直接运行 Batfish 服务。

## 构建信息

| 项 | 值 |
| --- | --- |
| 源码仓库 | https://github.com/batfish/batfish |
| 提交 | `bd675b560bb01e0db9260b7d55175ddb7ed2f93b`（master，2026-11-19） |
| 构建目标 | `//projects/allinone:allinone_main_deploy.jar`（官方 CI 同款目标，即发布版 allinone.jar） |
| 构建工具 | Bazel 9.3.2 + JDK 21（官方要求 JDK 21+） |
| JAR 字节码 | Java 21 |
| 版本号 | `0.36.0` |
| 文件大小 | 76,975,307 字节（约 73.4 MiB，未超过 GitHub 100 MB 单文件限制） |
| SHA-256 | `c72669b4f617954df76e9f1af6fd3a7420b1933c274aae234c9555c77ae442a6` |

## 目录结构

```
allinone.jar   # 可执行 fat JAR，包含 Batfish 服务端全部依赖
questions/     # Batfish 内置问题模板（启动服务时必须指定）
start.bat      # Windows 启动脚本
start.sh       # Linux / macOS 启动脚本
README.md
```

## 环境要求

- **JDK 21 或更高版本**（仅运行期；`java -version` 需 >= 21）
- 建议内存 4 GB 以上（默认 `-Xmx4g`，可按机器调整）
- 无需联网，无需 Maven / Bazel / Python；只有使用 Pybatfish 客户端时才需要 Python

## Windows 启动

双击 `start.bat`，或在当前目录打开 PowerShell / cmd：

```bat
java -Xmx4g -jar allinone.jar -runclient false -coordinatorargs "-templatedirs questions -containerslocation containers"
```

## Linux / macOS 启动

```bash
chmod +x start.sh
./start.sh
```

## 验证服务

启动后，本版本 allinone 的工作管理 v2 API 监听 **9996** 端口（新版 Batfish 已不再监听旧的 9997 端口）：

```bash
curl http://127.0.0.1:9996/v2/version
# {"Batfish":"0.36.0","api_version":"0.0.0"}

curl http://127.0.0.1:9996/v2/networks
# []
```

## 客户端连接

Pybatfish（新版默认端口即 9996）：

```python
from pybatfish.client.session import Session

bf = Session(host="localhost")   # 等价于 port=9996
bf.init_snapshot("/path/to/configs", name="snap1", overwrite=True)
```

旧版 Pybatfish 可显式指定：`Session(host="localhost", port=9996)`。

首次运行会在当前目录创建 `containers/`，用于保存网络快照与各次分析结果，可随时删除。
