# 设置清华镜像加速（国内用户）
options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror = "https://mirrors.tuna.tsinghua.edu.cn/bioconductor")

# 检查并安装BiocManager
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager", quiet = TRUE)

# 定义要安装的cran包列表
cran_pkgs <- c(
  "gert",
  "usethis",
  "tidyverse", 
  "data.table", 
  "openxlsx", 
  "PubChemR", 
  "rmarkdown", 
  "knitr"
)
new_cran_pkgs <- cran_pkgs[!cran_pkgs %in% installed.packages()[, "Package"]]
install.packages(
  cran_pkgs, 
  dependencies = TRUE, 
  quiet = TRUE, 
  verbose = FALSE
)

# 生成锁文件
renv::snapshot() # 增加或修改安装包，生成1次锁文件


# 定义要安装的Bioconductor包列表
bioc_pkgs <- c(
  "STRINGdb", 
  "biomaRt",
  "UniprotR"
)

new_bioc_pkgs <- bioc_pkgs[!bioc_pkgs %in% installed.packages()[, "Package"]]
BiocManager::install(
  new_bioc_pkgs,
  dependencies = TRUE,
  ask = FALSE,
  quiet = TRUE
)

# 生成锁文件
renv::snapshot() # 增加或修改安装包，生成1次锁文件


# 初始化 Git 仓库
gert::git_init()

# 添加 .gitignore 文件
writeLines(c(
  "# R 环境",
  ".Rproj.user/",
  ".renv/",
  "renv/library/",
  ".Rhistory",
  ".RData",
  ".Ruserdata",
  "",
  "# 输出文件",
  "raw_data/",
  "database/",
  "",
  "# 日志文件",
  "logs/"
), ".gitignore")

# 创建README.Rmd

# 创建远程仓库, 并首次推送

# 添加所有文件并提交
gert::git_add(".")
gert::git_commit("Initial commit: Project setup with renv")

# 创建主分支
if (!"main" %in% gert::git_branch_list()$name) {
  gert::git_branch_create("main")
}

# 首次推送
usethis::use_github()  # 创建远程仓库，并推送


# # 恢复包环境
# renv::restore()
# 
# # 确认安装完成
# renv::status()

