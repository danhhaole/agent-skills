# Data Scientist Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

此 Skill 将您的 AI 助手转化为一位真正的**数据科学家**——兼具思维方式与方法论——用于处理任何"始于一份数据、终于一个决策"的问题。

## Data Scientist Skill 是什么？

这不是某个数据科学库的包装器。智能体完全自由地用当前环境提供的任何语言和工具编写自己的分析代码——这个 Skill 提供的是代码应当在其中运行的纪律：信任一列数据之前要检查什么，相信一个指标之前要先跑什么，一个结论要具备什么条件才能发布。references 教授方法与判断力，两个内置脚本把最容易被草率对待的两个步骤标准化，checklists 则在每个结论送达读者之前把关。

**您来决策，智能体只负责建议。** 每次分析都以带有量化取舍的建议收尾（例如"把阈值降到 0.4 能多抓 15% 的欺诈，但也会误拦 3% 的优质客户"）——绝不会让智能体替业务做决定。完整的优化问题（定价引擎、资源分配求解器）不在范围内：Skill 只负责揭示各个杠杆及其代价，然后把杠杆交还给您。范围仅限于数据科学本身——不涉及数据工程流水线，也不涉及 MLOps/部署基础设施。

## 为什么使用它？

- **没有一个数字不经过实际运行的代码。** 每一个均值、计数或相关系数都能追溯到确实运行过的代码打印出的结果。自信地编造一个统计数字是这个 Skill 最糟糕的失败模式——它从设计上就拒绝走这条捷径。
- **先看数据，再做分析。** 不会照单全收任何 schema、列名或用户的描述——即便用户直接要求建模，也会先运行 `scripts/profile_data.py`。
- **先有基线，后有复杂度。** 在跑通一个哑基线（dummy baseline）和一个线性模型之前，不上梯度提升、不上神经网络、不做调参——"92% 的准确率"在不知道多数类本身就占 90% 之前毫无意义。
- **每个估计值都带着不确定性。** 一个没有置信区间、误差范围或交叉验证离散度的点估计，会被视为未完成的工作。
- **相信任何指标之前先查数据泄漏。** `checklists/leakage.md` 会在报告任何验证得分之前运行——数据泄漏是应用数据科学中代价最高的隐性失败。
- **上线前必经红队审查。** 任何可能影响决策的结论，在进入最终交付物之前，都要经过一轮对抗式审查——`checklists/analysis-review.md`——寻找数据泄漏、混杂因素和其他可能的解释。

## 四个层级的问题

每次分析都会按用户的问题真正所处的层级来路由：

| 层级 | 问题 | 主要流程 |
|---|---|---|
| Descriptive（描述性） | 发生了什么？ | Explore |
| Diagnostic（诊断性） | 为什么会发生？ | Inquire |
| Predictive（预测性） | 接下来可能发生什么？ | Predict |
| Prescriptive（指导性） | 该怎么做？ | 任何流程中的建议部分 |

用户常常在一个层级提问，实际需要的却是另一个层级的答案——比如要一个模型，实际需要的是一个诊断。`references/framing.md` 会在原样接受这个问题之前先被读一遍。

## 六种流程

| 用户的诉求听起来像 | 流程 | 交付物 |
|---|---|---|
| "帮我降低流失率"，一个模糊的业务目标 | **Full engagement（全流程）** | `insight-report.md` |
| "探索一下这份数据集"、"这个文件里有什么？" | **Explore（探索）** | `eda-report.md` |
| "A 比 B 好吗？"、"这个有统计显著性吗？"、样本量 | **Inquire（问询）** | 统计结果 + 解读 |
| "建一个模型来预测 X"，预测/预报 | **Predict（预测）** | `model-card.md` + `experiment-log.md` |
| "审查一下这份分析 / notebook / 模型" | **Review（审查）** | 批判性报告 |
| "把这个写给我老板 / 利益相关者看" | **Communicate（沟通）** | `insight-report.md` |

短流程是完整流水线的入口点，而非独立的方法——Explore 是完整分析的第 2-3 阶段，Predict 是第 4-5 阶段，以此类推。

**Review 值得单独强调。** 扮演一位专业审阅者的角色——审阅人类的 notebook 或另一个 AI 的分析——正是数据科学家判断力最有价值的时刻。它以对抗式的方式运行：假设分析是错的，然后试图证明这一点。

## Review 关卡

无论运行哪种流程，任何可能左右决策的结论在离开智能体之手前，它都会切换身份：不再是产出结果的分析师，而是试图推翻结果的审查者。`checklists/analysis-review.md` 会依次检查数据泄漏、混杂因素、其他可能的解释，以及结果在换一种数据切分方式后是否依然成立。这一轮审查的发现会写入交付物的 Limitations（局限性）部分，而不是一份私下笔记——一份未经过自我红队审查的分析，就还没完成。

## 两个内置脚本

两个脚本把最容易被草率对待的两个步骤标准化。两者都需要 `pandas`/`numpy`；基线脚本还需要 `scikit-learn`。两者都会输出一份供工作区使用的 markdown 报告，以及一份供智能体读取的 JSON 文件。

**`scripts/profile_data.py`** —— 接触任何数据集的第一步。形状、类型、缺失模式、基数（cardinality）、分布、重复值、相关性，以及一个警告部分（常量列、类 ID 列、类别不平衡、占位值、疑似泄漏的相关性）：

```bash
python scripts/profile_data.py data.csv --target churn --out ds-workspace/my-project
```

**`scripts/baseline_model.py`** —— 任何 Predict 流程的强制底线。在防泄漏的交叉验证流水线中（所有预处理都在训练折内拟合）运行一个哑基线和一个线性模型，自动检测任务类型，给出 `--time-col` 时使用基于时间的切分，给出 `--group-col` 时使用分组切分，并扫描机械式数据泄漏（单个特征对目标的预测能力高得可疑、跨折的重复行）：

```bash
python scripts/baseline_model.py data.csv --target churn --time-col signup_date --out ds-workspace/my-project
```

超出基线之外的一切——特征工程、梯度提升、调参——都由智能体手写完成，依据 `references/modeling.md` 的指导，并且必须跑赢基线，才能证明额外复杂度的合理性。

## 工作区

每个项目都有独立的工作目录，让产出物不断积累而不是散落各处：

```text
ds-workspace/{project-slug}/
  project-brief.md      # 来自 templates/ —— 问题界定，最先撰写
  data-profile.md        # profile_data.py 的输出
  eda-report.md          # 发现 + 假设
  experiment-log.md      # 每次模型运行：配置、数据、结果 —— 只增不改
  model-card.md          # 最终上线的模型
  insight-report.md      # 面向决策者的交付物
```

每个阶段开始时，从 `templates/` 复制骨架文件。实验日志是"平民版 MLflow"：如果一个结果没有被记录到足以复现的详细程度，那它就等于不存在。

## 如何触发

让 AI 执行如下任务：

```text
分析这份 CSV，告诉我这个季度留存率下降的原因是什么。
```

```text
Variant B 的转化率提升有统计显著性吗，还是只是噪声？
```

```text
帮我建一个模型，预测下个月哪些客户可能会流失。
```

```text
这是我的 notebook —— 在我把这些数字汇报给管理层之前，先帮我审查一下。
```

**触发短语：** "分析这份数据集"、"探索这份 CSV"、"是什么导致了这个变化？"、"这个差异有统计显著性吗？"、"A/B 测试"、"建一个模型来预测……"、"审查这份分析/notebook"、"给利益相关者写报告"、"phân tích dữ liệu"、"xây model dự đoán"、"kiểm định A/B"

## 文件结构

```text
data-scientist/
  SKILL.md                          # 入口文件：不可动摇的原则、路由、工作区、脚本
  references/
    workflow.md                     # 完整分阶段流水线指引
    framing.md                      # 把业务诉求转化为正确的问题
    eda.md                          # 探索性数据分析
    statistics.md                   # 假设检验、比较、因果结论、样本量
    modeling.md                     # 构建预测模型
    evaluation.md                   # 选择指标；判断模型质量
    interpretation.md               # 解释是什么驱动了一个模型或一个效应
    communication.md                # 面向利益相关者的写作
  checklists/
    data-quality.md                 # 关卡：分析开始之前
    leakage.md                      # 关卡：相信任何模型指标之前
    analysis-review.md              # 关卡：任何结论发布之前；Review 流程本身
  templates/                        # project-brief、eda-report、experiment-log、model-card、
                                     # insight-report
  scripts/
    profile_data.py                 # 数据集画像：结构、质量、警告
    baseline_model.py               # 带交叉验证、防泄漏的哑基线 + 线性基线
```

具体的项目会写入 `ds-workspace/{project-slug}/`，随着每个阶段完成不断积累上述产出物。

## 安装

### 1. 使用 CLI（推荐）

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### 2. 手动安装（适合非技术用户）

1. **下载：** 转到此仓库的 `skills/` 文件夹，下载 `data-scientist.zip` 文件。
2. **解压和复制：** 解压 `data-scientist.zip` 并将 `data-scientist` 文件夹复制到以下目录之一：

**针对特定项目：**
将 `data-scientist` 文件夹复制到项目根目录下的 `.agents/skills/` 或 `.claude/skills/`。

**全局安装（所有项目可用）：**
* **Mac / Linux：** `~/.agents/skills/` 或 `~/.claude/skills/`
* **Windows：** `%USERPROFILE%\.agents\skills\` 或 `%USERPROFILE%\.claude\skills\`（通常为 `C:\Users\<YourUsername>`）

## 使用示例

> **您：** 这是 `orders.csv`。你能告诉我上个月每用户收入为什么下降了吗？
>
> **智能体：** 我先运行 `profile_data.py`——在寻找"为什么"之前，我想先弄清楚这份文件里到底有什么。[对数据进行画像，发现 `discount_code` 有 40% 缺失，`user_id` 并非唯一]
>
> **智能体：** 留存率看起来很平稳，但平均订单金额下降了 18%。这是一个诊断性问题，所以我把它当作 Inquire 流程来处理——用正规的显著性检验比较各时段的订单金额，而不是靠肉眼看趋势线。
>
> *(运行比较分析，检查混杂因素——产品结构是否发生变化、某个折扣活动是否刚刚结束)*
>
> **智能体：** 控制产品结构后，这个下降依然存在；它与 14 号折扣活动结束的时间点吻合。在写报告之前，我先跑一遍审查清单——有没有更简单的解释，换一种日期切分方式结果是否依然成立。[确认后，起草 `insight-report.md`，包含这一发现、置信区间，以及如果您想据此采取行动，接下来该核实什么。]

