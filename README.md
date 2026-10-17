# OpenWrt RE-SS-01 固件 CI

京东云 RE-SS-01（Qualcomm IPQ6000，内核 6.18）专用固件的全自动构建仓库。

本仓库只包含 CI 配置与构建脚本，**每次构建自动拉取源码仓库的最新提交**编译，自带满血 **NSS 硬件加速**（qca-nss-drv / dp / ecm / ssdk / crypto 及全部功能模块）。

## 源码仓库

构建时自动 clone 上游公开仓库的最新代码（`VIKINGYFY/immortalwrt` main 分支），无需本地维护源码。

如需更换，修改 `.github/workflows/RE-SS-01.yml` 顶部 `env` 段：

```yaml
WRT_REPO: https://github.com/xxx/immortalwrt.git
WRT_BRANCH: main
```

## 触发方式

- **自动**：每周一早上 5 点（北京时间）
- **手动**：Actions → RE-SS-01 → Run workflow
  - `PACKAGE`：临时追加插件包，每行一个，如 `CONFIG_PACKAGE_luci-app-xxx=y`
  - `TEST`：勾选后只输出配置文件，不编译固件

## 构建产物（自动发布到 Release）

- 固件：`openwrt-qualcommax-ipq60xx-jdcloud_re-ss-01-*-分支-wifi-yes-日期.bin`
- 完整编译配置：`Config-RESS01-*` 文本文件

Release 说明里还会带上「本次构建变更」：对比上一次构建，列出**固件源码**、**各软件包源（feeds）**、**本 CI 仓库**的提交标题列表（每节最多 50 条，超出折叠省略）。

对比用的基线版本记录在 Release 说明末尾的隐藏注释里（页面上不显示），不需要额外维护状态文件。

## 默认设置

| 项目 | 默认值 |
| --- | --- |
| 主机名 | Sakura |
| LAN IP | 192.168.1.253 |
| WiFi 名称 | Sakura |
| WiFi 密码 | 12345678 |
| 主题 | Argon（中文） |

以上默认值在 `.github/workflows/RE-SS-01.yml` 顶部 `env` 段修改，由 `Scripts/Settings.sh` 注入固件。

## 软件包构成

固件只含三部分，无冗余：

1. **base**：目标平台默认包
2. **NSS**：22 个 NSS 内核模块
3. **自定义**：bash、curl、ttyd、vlmcsd、upnp、NFS、Argon 主题、时区等

增删软件包：编辑 `Config/RESS01.txt`，格式 `CONFIG_PACKAGE_包名=y/n`。

## 目录结构

```
.github/workflows/RE-SS-01.yml   # 构建流程：环境→拉源码→缓存→feeds→定制→编译→发布
Config/RESS01.txt                # 编译配置：设备 + NSS + 自定义包
Config/uci-defaults/990_custom.sh # 首启默认：LAN静态IP/网关/DNS + 关闭LAN DHCPv4v6 + dnsmasq参数
Scripts/Settings.sh              # 注入默认值：主机名/IP/WIFI/主题 + 追加配置
Scripts/Packages.sh              # 拉取第三方包（easytier）
```
