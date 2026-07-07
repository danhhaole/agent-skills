# Data Scientist Skill

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Skill này biến AI của bạn thành một **nhà khoa học dữ liệu (data scientist)** thực thụ — cả tư duy lẫn phương pháp — cho bất kỳ câu hỏi nào bắt đầu từ một bộ dữ liệu và kết thúc bằng một quyết định.

## Data Scientist Skill Là Gì?

Đây không phải là một lớp bọc quanh một thư viện data science nào đó. Agent tự viết code phân tích của riêng mình, hoàn toàn tự do, bằng bất kỳ ngôn ngữ và công cụ nào môi trường cung cấp — skill chỉ đóng góp kỷ luật để đoạn code đó được viết bên trong: cần kiểm tra gì trước khi tin một cột dữ liệu, cần chạy gì trước khi tin một chỉ số, một kết luận cần gì trước khi được công bố. Các tài liệu tham khảo (references) dạy phương pháp và sự phán đoán, hai script đi kèm chuẩn hóa hai bước hay bị làm ẩu nhất, và các checklist chặn mọi kết luận trước khi đến tay người đọc.

**Bạn tư vấn; người dùng quyết định.** Mọi dự án tư vấn đều kết thúc bằng một khuyến nghị kèm đánh đổi được lượng hóa ("hạ ngưỡng xuống 0.4 thì bắt được thêm 15% gian lận nhưng lại chặn nhầm 3% khách hàng tốt") — chứ không bao giờ để agent tự quyết định thay cho việc kinh doanh. Các bài toán tối ưu hóa đầy đủ (công cụ định giá, bộ giải phân bổ nguồn lực) nằm ngoài phạm vi: skill chỉ nêu ra các đòn bẩy và chi phí của chúng, rồi trao lại đòn bẩy đó cho bạn. Phạm vi chỉ giới hạn ở Data Scientist — không bao gồm pipeline Data Engineering hay hạ tầng MLOps/triển khai.

## Vì Sao Nên Dùng?

- **Không con số nào thiếu code đã chạy.** Mọi giá trị trung bình, số đếm, hay hệ số tương quan đều truy ngược được về kết quả in ra từ code đã thực sự chạy. Một con số bịa ra một cách tự tin là lỗi tệ nhất của skill này, và nó được thiết kế để từ chối lối tắt đó.
- **Nhìn dữ liệu trước khi phân tích.** Không tin bất kỳ schema, tên cột, hay mô tả nào của người dùng theo nghĩa đen — `scripts/profile_data.py` luôn chạy trước, kể cả khi được yêu cầu làm model ngay.
- **Baseline trước khi làm phức tạp.** Không gradient boosting, không neural net, không tinh chỉnh cho đến khi đã chạy một baseline dummy và một model tuyến tính — "độ chính xác 92%" vô nghĩa nếu chưa biết lớp đa số đã chiếm 90%.
- **Mọi ước lượng đều đi kèm độ bất định.** Một điểm ước lượng không có khoảng tin cậy, sai số, hay độ trải rộng qua cross-validation được coi là việc chưa xong.
- **Kiểm tra rò rỉ dữ liệu (leakage) trước khi tin bất kỳ chỉ số nào.** `checklists/leakage.md` chạy trước khi báo cáo bất kỳ điểm validation nào — leakage là lỗi âm thầm tốn kém nhất trong data science ứng dụng.
- **Phản biện trước khi công bố.** Mọi kết luận có thể ảnh hưởng đến quyết định đều phải qua một vòng review đối kháng — `checklists/analysis-review.md` — tìm kiếm leakage, biến nhiễu (confounders), và các cách giải thích khác trước khi đưa vào sản phẩm cuối.

## Bốn Cấp Câu Hỏi

Mọi dự án được điều phối theo cấp độ mà câu hỏi của người dùng thực sự thuộc về:

| Cấp độ | Câu hỏi | Flow chính |
|---|---|---|
| Descriptive (Mô tả) | Điều gì đã xảy ra? | Explore |
| Diagnostic (Chẩn đoán) | Tại sao nó xảy ra? | Inquire |
| Predictive (Dự đoán) | Điều gì có khả năng xảy ra? | Predict |
| Prescriptive (Khuyến nghị) | Nên làm gì với việc này? | Phần khuyến nghị của bất kỳ flow nào |

Người dùng thường hỏi ở một cấp nhưng thực ra cần cấp khác — yêu cầu một model trong khi thực sự cần một chẩn đoán. `references/framing.md` được đọc trước khi chấp nhận câu hỏi đúng như nó được đặt ra.

## Sáu Flow

| Yêu cầu của người dùng nghe như | Flow | Sản phẩm đầu ra |
|---|---|---|
| "Giúp tôi giảm churn", một mục tiêu kinh doanh mơ hồ | **Full engagement** | `insight-report.md` |
| "Khám phá bộ dữ liệu này", "file này có gì?" | **Explore** | `eda-report.md` |
| "A có tốt hơn B không?", "cái này có ý nghĩa thống kê không?", cỡ mẫu | **Inquire** | kết quả thống kê + diễn giải |
| "Xây model dự đoán X", dự báo | **Predict** | `model-card.md` + `experiment-log.md` |
| "Review phân tích / notebook / model này" | **Review** | báo cáo phản biện |
| "Viết báo cáo này cho sếp / stakeholder" | **Communicate** | `insight-report.md` |

Các flow ngắn là điểm vào của pipeline đầy đủ, không phải phương pháp riêng biệt — Explore là giai đoạn 2-3 của một dự án đầy đủ, Predict là giai đoạn 4-5, và cứ thế.

**Review xứng đáng được nhấn mạnh riêng.** Đóng vai một chuyên gia thẩm định — cho một notebook của con người hoặc một phân tích của AI khác — là nơi sự phán đoán của một data scientist có giá trị nhất. Nó chạy như một vòng đối kháng: giả định phân tích đó sai và cố gắng chứng minh điều đó.

## Cổng Review

Dù chạy flow nào, trước khi bất kỳ kết luận nào có thể ảnh hưởng đến quyết định rời khỏi tay agent, nó đổi vai: ngừng làm nhà phân tích tạo ra kết quả, trở thành người review cố "hạ gục" kết quả đó. `checklists/analysis-review.md` rà qua leakage, biến nhiễu, các cách giải thích khác, và liệu kết quả có còn đứng vững khi chia dữ liệu theo cách khác. Các phát hiện từ vòng này được đưa vào mục Limitations của sản phẩm đầu ra, không phải một ghi chú riêng tư — một phân tích chưa qua được vòng phản biện của chính nó thì chưa xong.

## Hai Script Đi Kèm

Hai script chuẩn hóa hai bước hay bị làm ẩu nhất. Cả hai cần `pandas`/`numpy`; script baseline cần thêm `scikit-learn`. Cả hai đều ghi ra một báo cáo markdown cho workspace và một file JSON để agent đọc.

**`scripts/profile_data.py`** — tiếp xúc đầu tiên với bất kỳ bộ dữ liệu nào. Kích thước, kiểu dữ liệu, mẫu hình thiếu dữ liệu, cardinality, phân phối, dữ liệu trùng lặp, tương quan, và một mục cảnh báo (cột hằng số, cột giống ID, mất cân bằng lớp, giá trị placeholder, tương quan nghi ngờ rò rỉ):

```bash
python scripts/profile_data.py data.csv --target churn --out ds-workspace/my-project
```

**`scripts/baseline_model.py`** — mức sàn bắt buộc cho bất kỳ flow Predict nào. Chạy một baseline dummy và một model tuyến tính trong các pipeline cross-validated an toàn với rò rỉ (mọi bước tiền xử lý được fit bên trong từng fold), tự động phát hiện loại bài toán, dùng chia theo thời gian khi có `--time-col`, chia theo nhóm với `--group-col`, và quét tìm rò rỉ cơ học (các đặc trưng đơn lẻ dự đoán target tốt đến mức đáng ngờ, các dòng trùng lặp giữa các fold):

```bash
python scripts/baseline_model.py data.csv --target churn --time-col signup_date --out ds-workspace/my-project
```

Bất cứ điều gì vượt ra ngoài baseline — feature engineering, gradient boosting, tinh chỉnh — đều được viết tay, dựa theo `references/modeling.md`, và phải vượt qua baseline mới đủ lý do biện minh cho độ phức tạp tăng thêm.

## Workspace

Mỗi dự án có một thư mục làm việc riêng để các sản phẩm tích lũy thay vì rải rác:

```text
ds-workspace/{project-slug}/
  project-brief.md      # từ templates/ — khung câu hỏi, viết đầu tiên
  data-profile.md        # đầu ra của profile_data.py
  eda-report.md          # phát hiện + giả thuyết
  experiment-log.md      # mọi lần chạy model: cấu hình, dữ liệu, kết quả — chỉ nối thêm
  model-card.md          # model được đưa vào sản xuất
  insight-report.md      # sản phẩm cuối cho người ra quyết định
```

Các khung mẫu được copy từ `templates/` khi mỗi giai đoạn bắt đầu. Experiment log là "MLflow bình dân": nếu một kết quả không được ghi đủ chi tiết để tái tạo lại, xem như nó chưa từng tồn tại.

## Cách Kích Hoạt

Yêu cầu AI thực hiện các tác vụ như:

```text
Phân tích file CSV này và cho tôi biết điều gì đang khiến tỷ lệ giữ chân khách hàng giảm trong quý này.
```

```text
Mức tăng conversion ở variant B có ý nghĩa thống kê không, hay chỉ là nhiễu?
```

```text
Xây cho tôi một model dự đoán khách hàng nào có khả năng rời bỏ trong tháng tới.
```

```text
Đây là notebook của tôi — review giúp trước khi tôi trình bày các con số này cho ban lãnh đạo.
```

**Câu kích hoạt:** "phân tích bộ dữ liệu này", "khám phá file CSV này", "điều gì gây ra thay đổi này?", "sự khác biệt này có ý nghĩa thống kê không?", "kiểm định A/B", "xây model dự đoán...", "review phân tích/notebook này", "viết báo cáo cho stakeholder", "phân tích dữ liệu", "xây model dự đoán", "kiểm định A/B"

## Cấu Trúc File

```text
data-scientist/
  SKILL.md                          # Điểm khởi đầu: nguyên tắc bất di bất dịch, điều phối, workspace, script
  references/
    workflow.md                     # Hướng dẫn chi tiết từng giai đoạn của pipeline
    framing.md                      # Chuyển một yêu cầu kinh doanh thành đúng câu hỏi
    eda.md                          # Phân tích khám phá dữ liệu
    statistics.md                   # Kiểm định giả thuyết, so sánh, kết luận nhân quả, cỡ mẫu
    modeling.md                     # Xây dựng model dự đoán
    evaluation.md                   # Chọn chỉ số; đánh giá chất lượng model
    interpretation.md               # Giải thích điều gì chi phối một model hoặc một hiệu ứng
    communication.md                # Viết cho người ra quyết định
  checklists/
    data-quality.md                 # Cổng: trước khi phân tích bắt đầu
    leakage.md                      # Cổng: trước khi tin bất kỳ chỉ số model nào
    analysis-review.md              # Cổng: trước khi bất kỳ kết luận nào được công bố; flow Review
  templates/                        # project-brief, eda-report, experiment-log, model-card,
                                     # insight-report
  scripts/
    profile_data.py                 # Profiling bộ dữ liệu: cấu trúc, chất lượng, cảnh báo
    baseline_model.py               # Baseline dummy + tuyến tính an toàn rò rỉ với CV
```

Bản thân các dự án được ghi vào `ds-workspace/{project-slug}/`, tích lũy các sản phẩm liệt kê ở trên khi mỗi giai đoạn hoàn tất.

## Cài Đặt

### 1. Dùng CLI (Khuyến nghị)

```bash
npx skills add tronghieu/agent-skills --skill data-scientist
```

### 2. Cài Đặt Thủ Công (Cho người dùng cơ bản)

1. **Tải về:** Truy cập thư mục `skills/` trong kho lưu trữ này và tải file `data-scientist.zip`.
2. **Giải nén & Copy:** Giải nén file `data-scientist.zip` và copy thư mục `data-scientist` vào một trong các vị trí sau:

**Cho một dự án cụ thể:**
Copy thư mục `data-scientist` vào `.agents/skills/` hoặc `.claude/skills/` trong thư mục gốc dự án của bạn.

**Cài đặt toàn cục (Dùng cho mọi dự án):**
* **Mac / Linux:** `~/.agents/skills/` hoặc `~/.claude/skills/`
* **Windows:** `%USERPROFILE%\.agents\skills\` hoặc `%USERPROFILE%\.claude\skills\` (thường là `C:\Users\<Tên_Của_Bạn>`)

## Ví Dụ Sử Dụng

> **Bạn:** Đây là `orders.csv`. Bạn có thể cho tôi biết tại sao doanh thu trên mỗi người dùng giảm trong tháng trước không?
>
> **Agent:** Tôi chạy `profile_data.py` trước — trước khi tìm "tại sao," tôi muốn biết thực sự file này có gì. [profile dữ liệu, phát hiện `discount_code` thiếu 40% và `user_id` không phải là duy nhất]
>
> **Agent:** Tỷ lệ giữ chân trông có vẻ ổn định nhưng giá trị đơn hàng trung bình giảm 18%. Đây là một câu hỏi chẩn đoán, nên tôi xử lý như một flow Inquire — so sánh giá trị đơn hàng giữa các giai đoạn bằng một kiểm định ý nghĩa thống kê đúng cách thay vì nhìn đường xu hướng bằng mắt.
>
> *(chạy so sánh, kiểm tra biến nhiễu — cơ cấu sản phẩm có thay đổi không, một chiến dịch giảm giá có vừa kết thúc không)*
>
> **Agent:** Mức giảm vẫn còn sau khi kiểm soát cơ cấu sản phẩm; nó trùng khớp với thời điểm chiến dịch giảm giá kết thúc vào ngày 14. Trước khi viết báo cáo, tôi chạy qua checklist review — có cách giải thích đơn giản hơn không, kết quả có còn đúng với một cách chia ngày khác không. [xác nhận, rồi soạn `insight-report.md` với phát hiện, khoảng tin cậy, và những gì cần kiểm tra tiếp nếu bạn muốn hành động dựa trên đó.]

