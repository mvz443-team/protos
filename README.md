# proto-repo-temp

类型契约仓库，集中维护游戏客户端和服务端共享的 Protocol Buffers 定义。

当前仓库只包含 `.proto` 源文件。Go 仓库和 TypeScript 仓库可以只 clone 本仓库一次，然后通过 `make` 按需生成各自语言的类型代码到指定目录。

## 前置依赖

必须安装：

- `make`
- `protoc`，Protocol Buffers 编译器

生成 Go 代码还需要：

- Go
- `protoc-gen-go`

```sh
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
```

生成 TypeScript 代码还需要：

- Node.js / npm
- `protoc-gen-ts`

```sh
npm install -g @protobuf-ts/plugin
```

安装后确认这些命令在 `PATH` 中可用：

```sh
protoc --version
which protoc-gen-go
which protoc-gen-ts
```

Windows PowerShell 可以使用：

```powershell
where.exe protoc-gen-go
where.exe protoc-gen-ts
```

## 使用方式

生成 TypeScript 类型契约：

```sh
make typescript OUT_DIR=../frontend/src/pb
```

也可以使用短别名：

```sh
make ts OUT_DIR=../frontend/src/pb
```

生成 Go 类型契约：

```sh
make golang OUT_DIR=../backend/tools/server/messages/pb
```

也可以使用短别名：

```sh
make go OUT_DIR=../backend/tools/server/messages/pb
```

默认会读取仓库根目录下的 `.proto` 文件。如果之后 proto 文件移动到 `proto/` 目录，可以通过 `PROTO_DIR` 指定：

```sh
make typescript PROTO_DIR=proto OUT_DIR=../frontend/src/pb
make golang PROTO_DIR=proto OUT_DIR=../backend/tools/server/messages/pb
```

清理某个生成目录：

```sh
make clean OUT_DIR=../frontend/src/pb
```

查看可用命令：

```sh
make help
```

## 推荐接入方式

在业务仓库旁边 clone 本仓库：

```sh
git clone <this-repo-url> contracts
```

TypeScript 仓库中执行：

```sh
cd contracts
make typescript OUT_DIR=../frontend/src/pb
```

Go 仓库中执行：

```sh
cd contracts
make golang OUT_DIR=../backend/tools/server/messages/pb
```
