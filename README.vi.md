# Agent Skills

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

Bộ sưu tập skills dành cho các AI coding agent. Tương thích với [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot) và [20+ công cụ AI khác](https://agentskills.io) hỗ trợ chuẩn mở [Agent Skills](https://agentskills.io).

## Các Skill Hiện Có

### cv-scorer

Chấm điểm CV ứng viên trên thang 100 điểm so với Mô tả Công việc (JD).

**Chức năng:**
- Chấm điểm CV theo 5 tiêu chí có trọng số: Khớp JD, Kinh nghiệm làm việc, Dự án & Tác động, Học vấn, Chất lượng CV
- Phát hiện cờ đỏ: nội dung lặp lại, số liệu phóng đại, thông tin mâu thuẫn
- Xuất JSON có cấu trúc với điểm từng tiêu chí, điểm nổi bật, cờ đỏ và khuyến nghị (Đề xuất / Có thể / Loại)
- Hỗ trợ xử lý hàng loạt: chấm điểm nhiều CV độc lập rồi xếp hạng

**Câu kích hoạt:** "xem xét CV", "lọc hồ sơ", "chấm điểm ứng viên", "đánh giá candidates", "shortlist ứng viên", "khớp resume với JD"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill cv-scorer
```

### system-prompt-creator

Tạo system prompt chất lượng cao, tối ưu theo từng mô hình cho bất kỳ LLM nào (Claude, GPT, Gemini, open-source).

**Chức năng:**
- Dẫn dắt qua quy trình 5 bước có cấu trúc: Phỏng vấn, Phân tích, Cấu trúc, Soạn thảo, Đánh giá
- Áp dụng 12 nguyên tắc phổ quát rút ra từ hướng dẫn prompting chính thức của Anthropic, OpenAI và Google
- Tạo tối ưu hóa riêng cho từng mô hình (XML tags cho Claude, tham số verbosity cho GPT-5, cài đặt temperature cho Gemini)
- Bao gồm các mẫu theo lĩnh vực: playbook vận hành, bảo toàn dữ liệu thô, chấm điểm độ tin cậy
- Cung cấp 7 template sẵn sàng tùy chỉnh cho các trường hợp phổ biến

**Câu kích hoạt:** "tạo system prompt", "viết system instructions", "prompt engineering", "xây dựng chatbot prompt", "thiết kế agent prompt"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill system-prompt-creator
```

### socratic-questor

Người bạn đặt câu hỏi Socrates (Gadfly) để học sâu thông qua đối thoại.

**Chức năng:**
- Dạy bất kỳ chủ đề nào bằng cách đặt câu hỏi, không bao giờ giải thích trực tiếp — người học tự khám phá sự hiểu biết qua đối thoại
- Tuân theo khung câu hỏi Socrates 6 loại của Paul & Elder: Làm rõ, Giả định, Bằng chứng, Quan điểm, Hàm ý, Siêu câu hỏi
- Điều chỉnh độ khó dựa trên trình độ người học (mới bắt đầu, trung cấp, nâng cao) được phát hiện qua chất lượng phản hồi
- Hỗ trợ khi người học bị mắc kẹt — câu hỏi phụ đơn giản hơn và ví dụ cụ thể, không bao giờ đưa ra đáp án trực tiếp
- Tự động khớp ngôn ngữ của người học

**Câu kích hoạt:** "dạy tôi về...", "giúp tôi hiểu...", "đặt câu hỏi về...", "kiểm tra tôi", "phương pháp Socrates", "Gadfly"

**Cài đặt:**
```bash
npx skills add tronghieu/agent-skills --skill socratic-questor
```

## Cài Đặt

```bash
# Dùng skills CLI (khuyến nghị)
npx skills add tronghieu/agent-skills

# Hoặc cài thủ công cho Claude Code
cp -r skills/cv-scorer ~/.claude/skills/
cp -r skills/system-prompt-creator ~/.claude/skills/
cp -r skills/socratic-questor ~/.claude/skills/
```

## Cấu Trúc Skill

```
skills/
  cv-scorer/
    SKILL.md                    # Skill chính (quy trình + rubric chấm điểm)
    references/
      scoring-rubric.md         # Rubric 5 tiêu chí chi tiết kèm hướng dẫn chấm
      output-format.md          # Template JSON đầu ra (CV đơn + hàng loạt)
  system-prompt-creator/
    SKILL.md                    # Skill chính (quy trình + 12 nguyên tắc)
    references/
      principles.md             # Nguyên tắc chi tiết kèm ví dụ
      model-specific.md         # Mẹo cho Claude / GPT-5 / Gemini
      templates.md              # 7 template (chatbot, agent, extractor, v.v.)
  socratic-questor/
    SKILL.md                    # Skill chính (nhân vật Gadfly + quy trình)
    references/
      questioning-framework.md  # Khung 6 loại câu hỏi của Paul & Elder + chiến lược thích ứng
```

## Đóng Góp

Chúng tôi hoan nghênh đóng góp từ cộng đồng! Dự án này tuân theo chuẩn mở [Agent Skills](https://agentskills.io) và tương thích với 30+ công cụ AI coding.

### Cách đóng góp

1. **Fork** repository này
2. **Tạo một skill** theo cấu trúc bên dưới
3. **Kiểm thử** skill với ít nhất 2-3 prompt thực tế
4. **Gửi PR** với mô tả rõ ràng về chức năng và thời điểm kích hoạt của skill

### Tạo skill mới

```bash
# Tạo khung cho skill mới
mkdir -p skills/ten-skill-cua-ban/references

# Tạo SKILL.md bắt buộc
cat > skills/ten-skill-cua-ban/SKILL.md << 'EOF'
---
name: ten-skill-cua-ban
description: Chức năng + khi nào kích hoạt + từ khóa liên quan
---

# Tên Skill Của Bạn

Hướng dẫn cho agent khi skill này được kích hoạt.
EOF
```

Xem [AGENTS.md](./AGENTS.md) để có hướng dẫn tạo skill đầy đủ, bao gồm cấu trúc thư mục, quy ước đặt tên, định dạng SKILL.md và hướng dẫn đóng gói.

### Checklist chất lượng skill

Trước khi gửi PR, hãy đảm bảo skill của bạn:

- [ ] Có `SKILL.md` với `name` và `description` trong frontmatter
- [ ] Mô tả rõ ràng về **khi nào** kích hoạt (không chỉ mô tả chức năng)
- [ ] Hướng dẫn rõ ràng, có thể thực hiện được và giải thích *lý do* đằng sau các quy tắc
- [ ] Có ví dụ ở những nơi định dạng/độ chính xác quan trọng
- [ ] Giữ `SKILL.md` dưới 500 dòng (dùng `references/` cho tài liệu chi tiết)
- [ ] Không chứa bí mật, thông tin xác thực hoặc dữ liệu nhạy cảm
- [ ] Đã được kiểm thử với các prompt thực tế

### Ý tưởng đóng góp

- Template skill mới cho các lĩnh vực cụ thể (DevOps, data science, mobile, v.v.)
- Dịch các skill hiện có sang ngôn ngữ khác
- Cải tiến các skill hiện có dựa trên trải nghiệm thực tế
- Sửa lỗi và cập nhật tài liệu

## Chuẩn Mở

Dự án này được xây dựng trên [chuẩn mở Agent Skills](https://agentskills.io), ban đầu phát triển bởi Anthropic và hiện đã được 30+ nền tảng AI áp dụng bao gồm Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI và nhiều hơn nữa.

Các skill bạn tạo ra ở đây hoạt động ở mọi nơi hỗ trợ chuẩn này. Không bị khóa nhà cung cấp.

| Nền tảng | Hỗ trợ |
|----------|---------|
| Claude Code | Native |
| Cursor | Native |
| GitHub Copilot | Native |
| Codex (OpenAI) | Native |
| Gemini CLI | Native |
| Windsurf, Cline, Roo Code, ... | Native |

Danh sách đầy đủ tại [agentskills.io](https://agentskills.io).

## Tài Liệu Tham Khảo

| Tài nguyên | URL |
|----------|-----|
| Chuẩn Agent Skills | https://agentskills.io |
| Tài liệu Claude Code Skills | https://code.claude.com/docs/en/skills |
| Anthropic Skills (chính thức) | https://github.com/anthropics/skills |
| Skills CLI (Vercel) | https://github.com/vercel-labs/skills |
| Skills Marketplace | https://skills.sh |

## Giấy Phép

MIT — tự do sử dụng, chỉnh sửa và phân phối.
