# Design System — DOCX Skill

## Color Philosophy

GLM uses a **mood-driven dynamic color system** instead of fixed named palettes. Colors are constructed from three dimensions:

### Three Dimensions of Document Color

| Dimension | Description | Range |
|-----------|-------------|-------|
| **Temperature** | Warm ↔ Cool | Warm (consulting, education) ↔ Cool (tech, medical) |
| **Weight** | Light ↔ Heavy | Light (resume, proposal) ↔ Heavy (legal, academic) |
| **Energy** | Calm ↔ Active | Calm (official, contract) ↔ Active (report, presentation) |

### Color Token System

Every document uses 5 color tokens. These are **computed** based on the document's mood, not selected from a fixed list.

| Token | Role | Guidance |
|-------|------|----------|
| `primary` | Headings, cover title | Dark, authoritative. Derived from Temperature + Weight. |
| `body` | Body text | Near-black with subtle warmth/coolness. Always high contrast. |
| `secondary` | Captions, footnotes | Mid-tone gray. Legible but visually recessive. |
| `accent` | Table headers, lines, links | The "personality" color. Reflects document Energy. |
| `surface` | Table alternating rows, card backgrounds | Very light tint of accent or neutral. |

### Mood Recipes

Instead of 10 fixed palettes, combine dimensions to generate colors dynamically:

**Cool + Heavy + Calm** → Deep Sea Academic (Academic / Research)
```js
const academic = {
  primary: "#162032", body: "#1C2A3D", secondary: "#5B6B7D",
  accent: "#8B7E5A", surface: "#F5F7FA"
};
```

**Warm + Heavy + Calm** → Legal Wood (Legal / Compliance)
```js
const legal = {
  primary: "#28201C", body: "#36302C", secondary: "#6E6560",
  accent: "#7A5C3A", surface: "#FBF9F7"
};
```

**Cool + Light + Active** → Dawn Mist Tech (Tech / Digital)
```js
const tech = {
  primary: "#0A1628", body: "#1A2B40", secondary: "#6878A0",
  accent: "#5B8DB8", surface: "#F4F8FC"
};
```

**Warm + Light + Active** → Warm Sun (Education / Training)
```js
const education = {
  primary: "#2A3518", body: "#384228", secondary: "#6B8040",
  accent: "#D4A030", surface: "#F8FAF4"
};
```

**Neutral + Medium + Calm** → Plain Paper (Default / General)
```js
const general = {
  primary: "#101820", body: "#182030", secondary: "#506070",
  accent: "#8090A0", surface: "#F2F4F6"
};
```

**Warm + Medium + Calm** → Terracotta (Consulting / Architecture)
```js
const consulting = {
  primary: "#241E1A", body: "#3A3430", secondary: "#68605A",
  accent: "#B08050", surface: "#FDFBF9"
};
```

**Cool + Medium + Active** → Mint Medical (Medical / Clinical)
```js
const medical = {
  primary: "#0E2030", body: "#1E2E40", secondary: "#4A6580",
  accent: "#3888A8", surface: "#F0F6FA"
};
```

**Neutral + Light + Calm** → White Porcelain (Product Manuals / Minimalist)
```js
const minimal = {
  primary: "#303030", body: "#484848", secondary: "#808080",
  accent: "#B89870", surface: "#FAFAF8"
};
```

**Cool + Light + Active (Gradient)** → Lapis Tech (Tech / AI / Innovation)
```js
const liuliTech = {
  primary: "#1A1F36", body: "#000000", secondary: "#5A6080",
  accent: "#667eea", surface: "#F8F9FF",
  gradient: ["#667eea", "#764ba2"],  // Purple-blue gradient (blendColors 5-step)
};
```

**Cool + Heavy + Active (Gradient)** → Deep Sea Blue-Gold (Finance / Investment / Premium)
```js
const deepBlueGold = {
  primary: "#0F2027", body: "#000000", secondary: "#4A6575",
  accent: "#D4AF37", surface: "#F5F7FA",
  gradient: ["#0F2027", "#203A43", "#2C5364"],  // 3-step deep sea blue gradient
};
```

**Warm + Light + Active (Gradient)** → Mint Dawn (Education / Health / Green)
```js
const mintMorning = {
  primary: "#1A3A3A", body: "#000000", secondary: "#507070",
  accent: "#3CB4A0", surface: "#F0FFFE",
  gradient: ["#3CB4A0", "#a8edea"],  // Mint green gradient
};
```

**Neutral + Medium + Active** → Graphite Silver (Professional but Restrained)
```js
const graphiteSilver = {
  primary: "#2C3E50", body: "#000000", secondary: "#607080",
  accent: "#9AA0A8", surface: "#F0F1F3",
};
```

### Scene → Mood Mapping

| Scene Keywords | Temperature | Weight | Energy | Recipe |
|----------------|-------------|--------|--------|--------|
| thesis, academic | Cool | Heavy | Calm | Deep Sea Academic |
| report (general) | Neutral | Medium | Calm | Plain Paper |
| report (consulting) | Warm | Medium | Calm | Terracotta |
| report (tech) | Cool | Light | Active | Dawn Mist Tech |
| contract, agreement, legal | Warm | Heavy | Calm | Legal Wood |
| resume, CV | Neutral | Light | Calm | White Porcelain (preferred) or Dawn Mist Tech |
| exam, test | — | — | — | **Pure B&W** |
| official document | — | — | — | **Pure B&W** |
| AI, tech | Cool | Light | Active | Dawn Mist Tech |
| medical | Cool | Medium | Active | Mint Medical |
| environmental, sustainability | Warm | Light | Active | Warm Sun |
| lesson plan (STEM / science / tech) | Cool | Light | Active | Dawn Mist Tech |
| lesson plan (arts / music / PE) | Neutral | Medium | Active | Graphite Silver |
| lesson plan (general education) | Neutral | Medium | Calm | Plain Paper |
| education report (not lesson plan) | Warm | Light | Active | Mint Dawn |
| product manual | Neutral | Light | Calm | White Porcelain |
| tech, AI, internet, innovation | Cool | Light | Active | Lapis Tech |
| finance, investment, premium | Cool | Heavy | Active | Deep Sea Blue-Gold |
| health, green | Warm | Light | Active | Mint Dawn |
| energetic, vibrant | Neutral | Medium | Active | Graphite Silver |
| essay, composition, self-evaluation, review/reflection, letter (non-business), speech, application, proposal letter | — | — | — | **Pure B&W** |
| _(no match)_ | Neutral | Medium | Calm | Plain Paper |

### Visual Profile Color Guidance

For **Profile B (Visual)** scenes — resume, copywriting, and other non-formal documents — prefer **warm neutral** tones aligned with the "Invisible Precision" design philosophy:

- **Body text**: Use warm dark neutrals (`#37352F`, `#303030`, `#3A3430`) instead of cool blue-grays. This reduces eye strain.
- **Surface/background**: Use warm near-white (`#F7F7F7`, `#FAFAF8`, `#FBF9F7`) instead of cool tints.
- **Accent colors**: Use sparingly and only for functional differentiation (section headers, key metrics, links). 95% of the document should remain monochromatic (black, white, gray).
- **Tables**: Prefer the **Zebra Stripe** style (see Table Styles §2) — hierarchy through background contrast with minimal borders. Fallback: Horizontal-Only.

This does NOT apply to Profile A (Formal) scenes (report, academic, contract, official-doc, exam), which must retain pure black `"000000"` body text per regulatory standards.

### Custom Color Generation

When the pre-defined recipes don't fit, construct colors using these rules:

1. **primary**: Start from `hsl(hue, 25-40%, 10-18%)` — dark, desaturated
2. **body**: primary lightened 5-8% — readable dark
3. **secondary**: primary lightened 30-40% — clearly subordinate
4. **accent**: Choose a hue reflecting the domain, `hsl(domainHue, 30-50%, 45-55%)`
5. **surface**: accent desaturated to 5-10%, lightened to 96-98%

**Contrast check**: body text on white must achieve WCAG AA (≥4.5:1). All recipes above pass this.

---

## Font Specifications

### Chinese Fonts

| Usage | Font | Fallback |
|-------|------|----------|
| Headings | Noto Sans SC (Noto Sans SC) | Noto Sans SC Bold |
| Body | Noto Sans SC | Noto Serif SC (Noto Serif SC) |
| Academic body | Noto Serif SC (Noto Serif SC) | — |
| Academic headings | Noto Sans SC (Noto Sans SC) | — |
| Official doc body | LXGW WenKai | — |
| Official doc title | Noto Serif SC Bold | — |

### English Fonts

For **English documents** (document language = English):

| Usage | Font | Fallback |
|-------|------|----------|
| Headings | FreeSerif Bold | Liberation Sans Bold |
| Body | FreeSerif | FreeSerif |
| Academic | FreeSerif | — |

For **English text within Chinese documents**, use the Chinese document's ascii font (FreeSerif by default).

### Font Paths (for matplotlib / image generation)

```python
# macOS
CJK_FONT_PATH = "/System/Library/Fonts/Supplemental/NotoSansSC[wght].ttf"
# Linux
CJK_FONT_PATH = "/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc"
# Fallback: download NotoSansSC[wght].ttf to working directory
```

### docx-js Font Configuration

```js
// In Document styles.default
styles: {
  default: {
    document: {
      run: {
        font: { ascii: "FreeSerif", eastAsia: "Noto Sans SC" },
        size: 24, // Xiao Si 小四 12pt
        color: palette.body,
      },
      paragraph: {
        spacing: { line: 312 }, // 1.3x mandatory
      },
    },
    heading1: {
      run: {
        font: { ascii: "FreeSerif", eastAsia: "Noto Sans SC" },
        size: 32, // San Hao 三号 16pt
        bold: true,
        color: palette.headingColor || palette.primary, // ⚠️ headingColor is safe for white pages
      },
    },
    heading2: {
      run: {
        font: { ascii: "FreeSerif", eastAsia: "Noto Sans SC" },
        size: 28, // Si Hao 四号 14pt
        bold: true,
        color: palette.headingColor || palette.primary, // ⚠️ headingColor is safe for white pages
      },
    },
  },
}
```

---

## Table Styles

**Profile routing:** Profile A (Formal: report, academic, contract, exam) → Three-Line Table or Horizontal-Only Table. Profile B (Visual: resume, copywriting) → Zebra Stripe (preferred) or Horizontal-Only Table.

### 1. Three-Line Table (三线表) — Academic

Only three horizontal lines: top of table, bottom of header, bottom of table.

```js
// palette.accentLine = "000000" for ACADEMIC; colored for other palettes
// palette is flat — table fields are at top level
  const t = palette;
const threeLineTable = new Table({
  width: { size: 100, type: WidthType.PERCENTAGE },
  borders: {
    top: { style: BorderStyle.SINGLE, size: 4, color: t.accentLine },
    bottom: { style: BorderStyle.SINGLE, size: 4, color: t.accentLine },
    left: { style: BorderStyle.NONE },
    right: { style: BorderStyle.NONE },
    insideHorizontal: { style: BorderStyle.NONE },
    insideVertical: { style: BorderStyle.NONE },
  },
  rows: [
    new TableRow({
      children: headerCells.map(text => new TableCell({
        children: [new Paragraph({ children: [new TextRun({ text, bold: true, size: 21 })] })],
        borders: {
          bottom: { style: BorderStyle.SINGLE, size: 2, color: t.accentLine },
          top: { style: BorderStyle.NONE },
          left: { style: BorderStyle.NONE },
          right: { style: BorderStyle.NONE },
        },
        margins: { top: 60, bottom: 60, left: 120, right: 120 },
      })),
    }),
    // ... data rows with all borders NONE
  ],
});
```

### 2. Zebra Stripe — Data Reports

```js
// palette is flat — table fields are at top level
  const t = palette;

// Header row
new TableRow({
  tableHeader: true, cantSplit: true,
  children: headerCells.map(text => new TableCell({
    children: [new Paragraph({ children: [new TextRun({ text, bold: true, size: 21, color: t.headerText })] })],
    shading: { type: ShadingType.CLEAR, fill: t.headerBg },
    margins: { top: 60, bottom: 60, left: 120, right: 120 },
  })),
}),

// Data rows — alternating surface / white
function zebraRow(cells, index, palette) {
  // palette is flat — table fields are at top level
  const t = palette;
  return new TableRow({
    cantSplit: true,
    children: cells.map(text => new TableCell({
      children: [new Paragraph({ children: [new TextRun({ text, size: 21 })] })],
      shading: index % 2 === 0
        ? { type: ShadingType.CLEAR, fill: t.surface }
        : { type: ShadingType.CLEAR, fill: "FFFFFF" },
      margins: { top: 60, bottom: 60, left: 120, right: 120 },
    })),
  });
}
```

### 3. Horizontal-Only — Business (Default)

```js
// palette is flat — table fields are at top level
  const t = palette;
const horizontalTable = new Table({
  width: { size: 100, type: WidthType.PERCENTAGE },
  borders: {
    top: { style: BorderStyle.SINGLE, size: 2, color: t.accentLine },
    bottom: { style: BorderStyle.SINGLE, size: 2, color: t.accentLine },
    left: { style: BorderStyle.NONE },
    right: { style: BorderStyle.NONE },
    insideHorizontal: { style: BorderStyle.SINGLE, size: 1, color: t.innerLine },
    insideVertical: { style: BorderStyle.NONE },
  },
  rows: [
    // Header row: use t.headerBg + t.headerText
    new TableRow({
      tableHeader: true, cantSplit: true,
      children: headerCells.map(text => new TableCell({
        children: [new Paragraph({ children: [new TextRun({ text, bold: true, size: 21, color: t.headerText })] })],
        shading: { type: ShadingType.CLEAR, fill: t.headerBg },
        margins: { top: 60, bottom: 60, left: 120, right: 120 },
      })),
    }),
    // ... data rows
  ],
});
```

**⚠️ CRITICAL**: Always set `margins` at the Table or TableCell level. Without margins, text touches cell borders.

### Table Color Token Derivation

Each palette in `coverPalettes` provides a `table` object with pre-computed colors for all 3 table styles:

| Token | Used in | Description |
|-------|---------|-------------|
| `table.headerBg` | Zebra Stripe, Horizontal-Only | Table header background color |
| `table.headerText` | Zebra Stripe, Horizontal-Only | Table header text color (must pass WCAG AA contrast) |
| `table.accentLine` | Three-Line | Top/bottom/header-bottom line color |
| `table.innerLine` | Horizontal-Only | Inner horizontal separator line color |
| `table.surface` | Zebra Stripe | Alternating row background (light tint) |

**Usage:**
```js
const palette = coverPalettes["DS-1"];
// palette is flat — table fields are at top level
  const t = palette;
// Three-Line: use t.accentLine for border colors
// Zebra: use t.headerBg, t.headerText, t.surface
// Horizontal: use t.headerBg, t.headerText, t.innerLine
```

**⚠️ High-saturation accent override**: For DM-1 and FG-1, the table colors are intentionally darkened/desaturated relative to the cover accent. Bright accent colors that look good on dark cover backgrounds are too eye-straining on white body pages. Always use `palette.headerBg / palette.accentLine / etc.` for tables, never the raw `palette.accent`.

---
---

## Cover Page Design System

### Design Philosophy

Covers use **7 validated layout recipes** + **parameterized variants** instead of free combination. Each recipe's background, layout, and decoration are visually verified. Differentiation comes from **palette × font size × content variation**.

**Architecture principle:** All recipes use a **single 16838 outer wrapper table** (one row, exact height). Recipes R1/R2/R3 use **ZERO nested tables** — all decoration is achieved via **paragraph borders** (left/right/top/bottom). This ensures maximum cross-engine stability (MS Office + WPS).

> **⚠️ ABSOLUTE BAN ON NESTED TABLES IN COVERS:**
> WPS Office does NOT render `shading` (background fill) on tables nested inside another table's cell.
> This means placing a `new Table()` inside a `TableCell.children` of another `Table` will cause the inner table's background to be invisible in WPS.
> **ALL cover recipes MUST use flat table structures only.** When multiple background colors are needed (e.g., R4's dark+white split), use **multiple rows in a single table**, NOT nested tables.
> - ✅ Correct: `new Table({ rows: [darkRow, dividerRow, whiteRow] })` (one flat table, 3 rows)
> - ❌ Forbidden: `new Table({ rows: [new TableRow({ children: [new TableCell({ children: [new Table({...})] })] })] })`

### Cover Color Palettes (Dark Mode + Light Mode)

Each palette defines 3 core colors (Background, Primary, Accent) + derived cover/table tokens.

⚠️ **`headingColor` — body heading color override (CRITICAL):**
For dark-background palettes where `primary: "FFFFFF"` (the cover title color), using `primary` as the body heading color would produce **white text on white paper** — invisible.
These palettes define a separate `headingColor` field (typically derived from `headerBg`) that is safe for body H1/H2/H3.

**Rule:** Body heading color = `palette.headingColor ?? palette.primary`.
If `headingColor` exists, use it. If not, fall back to `primary` (which is safe for light-bg palettes where primary is already dark).

| Palette | `primary` | `headingColor` | Body heading uses |
|---------|-----------|---------------|------------------|
| WM-1 (light bg) | `3D5258` | — | `primary` (dark, safe) |
| MC-1 (dark bg) | `FFFFFF` | `2E5A88` | `headingColor` (dark, safe) |
| DM-1 (dark bg) | `FFFFFF` | `1B6B7A` | `headingColor` (dark, safe) |

⚠️ **Disambiguation: `titleColor` is a COLOR value, not title text.** The keys `titleColor`, `subtitleColor`, `metaColor`, `footerColor` in the palette are **color hex codes** for styling cover text elements. They are NOT text content. The actual title text comes from `config.title`. Never use `P.titleColor` as the `text` parameter of a `TextRun` — it must only be used as the `color` parameter.

```js
// ✅ Correct — config.title is the text, P.titleColor is the color
new TextRun({ text: config.title, color: P.titleColor })

// ❌ WRONG — using color value as text content
new TextRun({ text: P.titleColor, color: P.titleColor })  // displays "FFFFFF" as visible text!
```

```js
// ── Palette definitions (FLAT structure) ──
// All fields at top level — no nesting. Pass directly to buildCoverRx() and table builders.
// Usage: const P = coverPalettes["DS-1"];  then P.bg, P.titleColor, P.headerBg, etc.
const coverPalettes = {
  // ── Light backgrounds (4) ── bg luminance > 200, dark text on light fill
  "WM-1": { // Silver Teal — education, training, marketing
    bg: "F0F1F3", primary: "3D5258", accent: "708890",
    titleColor: "3D5258", subtitleColor: "606060", metaColor: "606060", footerColor: "707070",
    headerBg: "5A6E73", headerText: "FFFFFF", accentLine: "5A6E73", innerLine: "D5D8DA", surface: "EEF0F2",
  },
  "SN-2": { // Warm Silver — creative, branding, events (⚠️ NOT for business)
    bg: "EEEDEB", primary: "484545", accent: "888480",
    titleColor: "484545", subtitleColor: "606060", metaColor: "606060", footerColor: "707070",
    headerBg: "686563", headerText: "FFFFFF", accentLine: "686563", innerLine: "D8D7D5", surface: "F2F1F0",
  },
  "MIN-1": { // Pure Silver — consulting, minimalist business, premium proposals
    bg: "F2F2F0", primary: "2A2A2A", accent: "808080",
    titleColor: "2A2A2A", subtitleColor: "606060", metaColor: "606060", footerColor: "707070",
    headerBg: "6E6E6E", headerText: "FFFFFF", accentLine: "6E6E6E", innerLine: "D5D5D5", surface: "F0F0EF",
  },
  "WR-2": { // Retro Green — traditional industry, finance compliance, legal
    bg: "F4F1E9", primary: "2A4A3A", accent: "9A7E42",
    titleColor: "2A4A3A", subtitleColor: "606060", metaColor: "606060", footerColor: "707070",
    headerBg: "2A4A3A", headerText: "FFFFFF", accentLine: "2A4A3A", innerLine: "D0D8D0", surface: "F0EDE5",
  },

  // ── Dark backgrounds (8) ── bg luminance < 60, white/light text on dark fill
  "CM-2": { // Deep Sapphire — tech, corporate, whitepaper
    bg: "0D1B2A", primary: "1A3A5C", accent: "5DA9D6",
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "808890",
    headerBg: "3A6B8C", headerText: "FFFFFF", accentLine: "3A6B8C", innerLine: "C8D8E4", surface: "EBF1F6",
  },
  "MC-1": { // Z.AI Blue — tech, corporate, proposals (replaced Medical Blue)
    bg: "1B2E4A", primary: "FFFFFF", accent: "5B8DB8",
    headingColor: "2E5A88", // ← body H1/H2/H3 color (derived from headerBg; primary is white for dark cover)
    titleColor: "FFFFFF", subtitleColor: "B8C8D8", metaColor: "90A0B0", footerColor: "909AA0",
    headerBg: "2E5A88", headerText: "FFFFFF", accentLine: "2E5A88", innerLine: "C0D0E0", surface: "EBF0F6",
  },
  "GV-1": { // Deep Navy — government, state-owned enterprise, party building
    bg: "0F1A2E", primary: "1A2D48", accent: "7090B0",
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "808890",
    headerBg: "4A6580", headerText: "FFFFFF", accentLine: "4A6580", innerLine: "CBD5DE", surface: "EDF1F5",
  },
  "DS-1": { // Deep Sea — annual report, general business
    bg: "0B1C2C", primary: "FFFFFF", accent: "529286",
    headingColor: "3A7A6E", // ← body H1/H2/H3 color (derived from headerBg; primary is white for dark cover)
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "808890",
    headerBg: "3A7A6E", headerText: "FFFFFF", accentLine: "3A7A6E", innerLine: "BECFCC", surface: "E8ECEB",
  },
  "IG-1": { // Ink Silver — finance, investment, luxury brand
    bg: "1C1C1E", primary: "FFFFFF", accent: "8C9098",
    headingColor: "5C6068", // ← body H1/H2/H3 color (derived from headerBg; primary is white for dark cover)
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "808890",
    headerBg: "5C6068", headerText: "FFFFFF", accentLine: "5C6068", innerLine: "D0D2D5", surface: "EEEFF1",
  },
  "DM-1": { // Deep Cyan — AI, tech proposals, digital transformation
    bg: "162235", primary: "FFFFFF", accent: "37DCF2",
    headingColor: "1B6B7A", // ← body H1/H2/H3 color (derived from headerBg; primary is white for dark cover)
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "889098",
    // ⚠️ headerBg uses darkened accent (#1B6B7A) — bright #37DCF2 is too saturated for white-page tables
    headerBg: "1B6B7A", headerText: "FFFFFF", accentLine: "1B6B7A", innerLine: "C8DDE2", surface: "EDF3F5",
  },
  "FG-1": { // Forest Mint — ESG, environmental, sustainability, agriculture
    bg: "0C1F1A", primary: "FFFFFF", accent: "3DDBB5",
    headingColor: "2A7A65", // ← body H1/H2/H3 color (derived from headerBg; primary is white for dark cover)
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "808890",
    // ⚠️ headerBg uses darkened accent (#2A7A65) — bright #3DDBB5 is too saturated for white-page tables
    headerBg: "2A7A65", headerText: "FFFFFF", accentLine: "2A7A65", innerLine: "C5D8D0", surface: "EDF5F2",
  },
  "GO-1": { // Graphite Silver — proposals, bidding, PRD
    bg: "22272E", primary: "FFFFFF", accent: "9AA0A8",
    headingColor: "6B7078", // ← body H1/H2/H3 color (derived from headerBg; primary is white for dark cover)
    titleColor: "FFFFFF", subtitleColor: "B0B8C0", metaColor: "90989F", footerColor: "889098",
    headerBg: "6B7078", headerText: "FFFFFF", accentLine: "6B7078", innerLine: "D5D7DA", surface: "F0F1F3",
  },

  // ── Special (R5 only) ──


  "ACADEMIC": { // Academic Black — thesis, standards (R5 exclusive, not in general routing)
    bg: "FFFFFF", primary: "000000", accent: "000000",
    titleColor: "000000", subtitleColor: "404040", metaColor: "606060", footerColor: "707070",
    headerBg: "FFFFFF", headerText: "000000", accentLine: "000000", innerLine: "000000", surface: "FFFFFF"
    // Note: Academic uses Three-Line table only, with pure black lines. No colored headers.
  },
};
```

### ⚠️ Dark Cover → Light Table Rule

Covers with dark backgrounds (CM-2, MC-1, GV-1, DS-1, IG-1, DM-1, FG-1, GO-1) use bright accent on dark bg.
Body page tables are always on WHITE background — table colors use **darkened/desaturated** variants of the accent.
High-saturation accent colors (DM-1 #37DCF2, FG-1 #3DDBB5) are explicitly overridden in `table.*` fields above.

### ⚠️ Cover Title-Background Contrast Safety (CRITICAL)

**Problem:** If `titleColor` is `"FFFFFF"` (white) but the cover background fails to render (shading not applied, wrapper table missing, or palette mislabeled), the title becomes invisible on the default white page.

**Iron rule:** `titleColor` and `bg` must ALWAYS have sufficient contrast:
- Dark bg (luminance < 60) → titleColor MUST be light (`"FFFFFF"` or similar)
- Light bg (luminance > 200) → titleColor MUST be dark (`"2A2A2A"`, `"3D5258"`, etc.)
- **NEVER use `titleColor: "FFFFFF"` with a light bg palette**

**Palette classification:**
- Light backgrounds (4): WM-1, SN-2, MIN-1, WR-2 — all use dark titleColor ✅
- Dark backgrounds (8): CM-2, MC-1, GV-1, DS-1, IG-1, DM-1, FG-1, GO-1 — all use white titleColor ✅
- Special: ACADEMIC — white bg + black titleColor ✅

**If generating cover code, verify:** `shading: { type: ShadingType.CLEAR, fill: P.bg }` is present on the wrapper TableCell. Without it, the cell defaults to white and white text disappears.

### ⚠️ SN-2 Scene Restriction

SN-2 (Warm Silver) is restricted to creative/branding/event documents ONLY.
It MUST NOT be used for: business reports, consulting, finance, legal, government, medical, or technical documents.

### Industry → Palette Recommendations

| Industry / Theme | Recommended Palette | Fallback |
|-----------|---------|---------|
| General annual report | DS-1 Deep Sea | CM-2 |
| Finance / investment / luxury | IG-1 Ink Silver | WR-2, MIN-1 |
| Tech / AI / internet | DM-1 Deep Cyan | CM-2 |
| ESG / environmental / sustainability | FG-1 Forest Mint | DS-1 |
| Consulting / diagnostic report | MIN-1 Pure Silver | WR-2 |
| Business proposal / bidding / PRD | GO-1 Graphite Silver | CM-2 |
| Education / training (formal) | WM-1 Silver Teal | CM-2 |
| Lesson plan (arts/general) | FG-1 Forest Mint | WM-1 |
| Cultural / newsletter / internal | FG-1 Forest Mint | WM-1 |
| Events / activities | FG-1 Forest Mint | WM-1 |
| Medical / healthcare / clinical | MC-1 Z.AI Blue | CM-2 |
| Government / state-owned / party | GV-1 Deep Navy | MIN-1 |
| Traditional industry / legal / compliance | WR-2 Retro Green | MIN-1 |
| Creative / branding (formal) | SN-2 Warm Silver | WM-1 |
| Whitepaper (general) | CM-2 Deep Sapphire | DS-1, MIN-1 |
| Academic / thesis / standards | ACADEMIC | — |

---

### ⚠️ Recipe Routing Rules (Replaces Free Selection)

```js
function selectCoverRecipe(docType, industry, titleLength) {
  // No cover for these types
  if (["contract", "official", "exam", "resume"].includes(docType)) return null;

  // Academic
  if (docType === "academic") return { recipe: "R5", palette: "ACADEMIC" };

  // Thesis proposal report (开题报告)
  if (docType === "proposal_report") return { recipe: "R5", palette: "ACADEMIC" };

  // Lesson plans — R1 + FG-1 for arts/general, R4 for STEM
  if (docType === "lesson_plan" || docType === "lessonplan") {
    const stemKeywords = ["math", "physics", "chemistry", "biology", "science", "tech", "computer", "engineering"];
    if (stemKeywords.some(k => (industry || "").toLowerCase().includes(k))) {
      return { recipe: "R4", palette: "DM-1" };
    }
    // Arts, general, and all other lesson plans → R1 + FG-1
    return { recipe: "R1", palette: "FG-1" };
  }

  // Creative/branding/design (formal) → R3 centered card frame
  if (["creative", "branding", "design"].includes(docType)) {
    return { recipe: "R3", palette: "SN-2" };
  }

  // Cultural/newsletter/internal → R1 + FG-1
  if (["cultural", "newsletter", "internal"].includes(docType)) {
    return { recipe: "R1", palette: "FG-1" };
  }

  // Activity/event planning → R1 + FG-1
  if (docType === "activity") return { recipe: "R1", palette: "FG-1" };

  // Trend/research reports in cultural/creative/brand fields → R2 + CM-2
  if (docType === "trend_report" || docType === "research_report") {
    if (["cultural", "creative", "brand", "design"].includes(industry)) {
      return { recipe: "R2", palette: "CM-2" };
    }
  }

  // Formal/business subtypes
  if (docType === "whitepaper") return { recipe: "R2", palette: industry === "finance" ? "IG-1" : "CM-2" };
  if (docType === "consulting") return { recipe: "R2", palette: "MIN-1" };
  if (docType === "proposal" || docType === "plan") return { recipe: "R4", palette: "GO-1" };

  // Reports — palette by industry, use R1
  if (docType === "report") {
    const paletteMap = {
      finance: "IG-1", consulting: "MIN-1",
      tech: "DM-1", ai: "DM-1",
      education: "WM-1", green: "FG-1",
      medical: "MC-1", government: "GV-1",
    };
    return { recipe: "R1", palette: paletteMap[industry] || "DS-1" };
  }

  // Default
  return { recipe: "R1", palette: "DS-1" };
}

// ── Long-title override (applied AFTER initial recipe selection) ──
// Call this after selectCoverRecipe() when the actual title text is known.
function applyLongTitleOverride(result, titleLength) {
  if (!result || !result.recipe) return result;
  // R5 (academic) is never overridden — it has its own calcTitleLayoutMixed()
  if (result.recipe === "R5") return result;
  // R3/R4 struggle with long titles → fall back to R1 (same palette)
  if (titleLength > 20 && ["R3", "R4"].includes(result.recipe)) {
    return { recipe: "R1", palette: result.palette };
  }
  // Very long titles: even R2 centered looks scattered → R1 left-aligned
  if (titleLength > 30 && result.recipe === "R2") {
    return { recipe: "R1", palette: result.palette };
  }
  return result;
}
```

### Scene Cover Routing

| Scene | Recipe | Default Palette | Special Requirements |
|------|------|---------|----------|
| academic thesis | R5 (Clean White) | ACADEMIC | School name + 2-col meta table with underlines, see academic.md |
| thesis proposal report (开题报告) | R5 (Clean White) | ACADEMIC | Use `buildProposalCover()` from academic.md |
| business report (general) | R1 (Pure Paragraph Left) | DS-1 Deep Sea | Auto-select palette by industry |
| whitepaper | R2 (Double-Rule Frame) | CM-2 Deep Sapphire / IG-1 Ink Silver | — |
| consulting report | R2 (Double-Rule Frame) | MIN-1 Pure Silver | — |
| business proposal / plan | R4 (Top Color Block) | GO-1 Graphite Silver | — |
| events / activities | R1 (Pure Paragraph Left) | FG-1 Forest Mint | — |
| lesson plan (STEM) | R4 (Top Color Block) | DM-1 Deep Cyan | Route by subject, see selectCoverRecipe |
| lesson plan (arts/general) | R1 (Pure Paragraph Left) | FG-1 Forest Mint | — |
| creative / branding / design (formal) | R3 (Centered Card Frame) | SN-2 Warm Silver | Product overview, brand doc, design report |
| cultural / newsletter / internal | R1 (Pure Paragraph Left) | FG-1 Forest Mint | — |
| trend/research report (cultural/creative/brand) | R2 (Double-Rule Frame) | CM-2 Deep Sapphire | — |
| education report | R1 (Pure Paragraph Left) | WM-1 Silver Teal | For education reports, NOT lesson plans |
| ESG / environmental | R1 (Pure Paragraph Left) | FG-1 Forest Mint | — |
| medical / healthcare | R2 (Double-Rule Frame) | MC-1 Z.AI Blue | — |
| government / state-owned | R1 (Pure Paragraph Left) | GV-1 Deep Navy | — |
| resume | — | — | No standalone cover |
| contract | — | — | No standalone cover (title page is first page) |
| official document | — | — | No standalone cover |
| exam paper | — | — | No standalone cover |

---

### Cover Title Length Guidelines

When the user does NOT specify an exact title, the model should craft a title within the recommended range. If the user provides a title that exceeds the comfortable range, apply long-title routing in `selectCoverRecipe()` (see above).

| Recipe | Comfortable (1–2 lines) | Maximum (3 lines) | Long Title Tolerance |
|--------|------------------------|--------------------|----------------------|
| R1     | 8–20 chars             | ≤50 chars          | ⭐⭐⭐⭐⭐ Best (left-aligned, full-page bg) |
| R2     | 8–18 chars             | ≤45 chars          | ⭐⭐⭐⭐ Good (full-page bg, but centered) |
| R3     | 8–15 chars             | ≤40 chars          | ⭐⭐ Poor (narrowest width) |
| R4     | 8–18 chars             | ≤45 chars          | ⭐⭐ Poor (fixed-height color block) |
| R5     | 8–16 chars             | ≤42 chars          | ⭐⭐⭐ OK (academic only, mixed-width calc) |

**Title crafting rules (when model generates the title):**
1. Prefer concise titles within the "comfortable" range
2. If topic requires detail, split into title + subtitle (e.g., title="数字化转型战略研究" subtitle="——以某某企业为例")
3. Never exceed the "maximum" range unless user explicitly provides the full title

---

### ⚠️ Cover Page Break Rules

Cover should be an independent section — **no PageBreak at the end needed**. The next section automatically starts a new page.

```js
// ✅ Correct — cover is a separate section, no trailing PageBreak
sections: [
  { properties: { /* Cover section, margin all 0 */ }, children: buildCover(...) },
  { properties: { /* Body section */ }, children: buildContent(...) },
]
```

### ⚠️ Cover Content Overflow Prevention (Mandatory)

1. Cover section page margin is 0; total content height ≤ 15638 twips (1200 twips safety margin for cross-engine compatibility — MS Office renders large fonts taller than calculated).
2. Color block Table `height` must use `rule: "exact"` (never `"atLeast"`).
3. Each recipe code includes height budget annotations — verify during generation.
4. **`verticalAlign` must always be `"top"`**. Never use `"center"` or `"bottom"` in exact-height rows — content will be clipped or overflow. Use `spacing.before` on the first paragraph for vertical positioning.
5. **Title font size MUST be dynamically calculated via `calcTitleLayout()`** (see below). Never hardcode font sizes above 40pt for cover titles. Every recipe MUST call `calcTitleLayout()` before building title paragraphs.
6. **Never use `margins.top`/`margins.bottom` for vertical positioning inside exact-height cells**: Cell margins reduce available height unpredictably across MS Office and WPS. Use `spacing.before` on the first paragraph instead. Only `margins.left`/`margins.right` are safe.
7. **Dynamic spacing is mandatory**: Use `calcCoverSpacing()` to compute `spacing.before` values dynamically based on content element count and title line count. Never use fixed large spacing values (e.g., `before: 4500`) that assume a specific title length.
8. **Cover must be a single-page section**: The cover section must produce exactly ONE page. If content overflows to a second page, it means the height budget is violated. Common overflow causes and fixes:
   - Title font too large → use `calcTitleLayout()` to auto-reduce
   - Too many meta lines → reduce font size or remove less important lines
   - Fixed `spacing.before` values too large → use `calcCoverSpacing()` for dynamic values
   - Subtitle + English label + meta lines combined exceed budget → calculate total and reduce spacing
9. **Cover wrapper table MUST use explicit `allNoBorders`**: The outer 16838 wrapper table and ALL nested tables inside the cover MUST set borders to NONE explicitly. Never rely on docx-js default borders (`single/auto/sz=4`). Default borders add ~8 twips per edge, which causes MS Office to calculate a total height slightly exceeding 16838 → content overflows to a blank page 2. WPS is more lenient but MS Office is strict. **This is the #1 cause of "blank page 2 in MS Office but not in WPS".**

```js
// ✅ MANDATORY: Define and use allNoBorders for every cover table
const NB = { style: BorderStyle.NONE, size: 0, color: "FFFFFF" };
const noBorders = { top: NB, bottom: NB, left: NB, right: NB };
const allNoBorders = { top: NB, bottom: NB, left: NB, right: NB,
                       insideHorizontal: NB, insideVertical: NB };

new Table({
  borders: allNoBorders,  // ← MANDATORY on every cover table
  // ...
});
```

10. **Decorative lines MUST use paragraph borders, NEVER text characters**: Horizontal decorative lines (accent strips, dividers, frame edges) must be implemented with `paragraph border.top` or `border.bottom` — never with text characters like `───`, `━━━`, `═══`, or `——————`. Character-drawn lines render at inconsistent widths across MS Office and WPS (font metrics differ), causing lines to appear truncated or misaligned. Paragraph borders render pixel-perfect in both engines and their width is controlled precisely via `indent.left` / `indent.right`.

```js
// ✅ Correct — paragraph border (R2 style thick accent rule)
new Paragraph({
  indent: { left: 1000, right: 1000 },
  border: { top: { style: BorderStyle.SINGLE, size: 18, color: P.accent, space: 20 } },
  children: [],
})

// ❌ FORBIDDEN — text character line (renders inconsistently)
new Paragraph({
  children: [new TextRun({ text: "───────────────", color: P.accent })]
})
```
9. **Post-generation overflow check (mandatory)**: After building cover children, estimate total height:
   ```js
   function estimateCoverHeight(elements) {
     let total = 0;
     for (const el of elements) {
       if (el instanceof Table) {
         // Sum row heights (exact rows) or estimate 400 twips per row
         const rows = el.root?.[0]?.rows || [];
         for (const row of rows) {
           total += row.height?.value || 400;
         }
       } else if (el instanceof Paragraph) {
         const fontSize = el.root?.[0]?.size || 24; // half-pts
         // ★ Use pt * 11.5 (= half-pt * 10 * 1.15) for accurate single-spacing estimate
         const lineHeight = Math.max(fontSize * 11.5, 276); // min 276 (default 12pt)
         const spacingBefore = el.spacing?.before || 0;
         const spacingAfter = el.spacing?.after || 0;
         total += lineHeight + spacingBefore + spacingAfter;
       }
     }
     return total;
   }
   // ★ Target: estimateCoverHeight(coverChildren) < 15638 (16838 - 1200 safety)
   ```

---

### ⚠️ Cover Title Layout — calcTitleLayout() (Mandatory for ALL Recipes)

**Every cover recipe MUST use `calcTitleLayout()` to determine title font size and line breaks.** Hardcoding font sizes or passing the full title as a single TextRun is FORBIDDEN.

**Every paragraph with font size > body text MUST set explicit line spacing** to prevent top clipping:
```js
// ★ MANDATORY: prevent inherited small line spacing from clipping large fonts
spacing: { line: Math.ceil(titlePt * 23), lineRule: "atLeast", after: 100 }
// Example: 36pt → line: 828; 44pt → line: 1012
```
Without this, the paragraph inherits body text line spacing (e.g., 560tw), which is shorter than the font height → top of characters gets clipped.

```js
/**
 * Calculate safe font size and smart line breaks for cover titles.
 * MUST be called by every recipe before building title paragraphs.
 *
 * @param {string}  title          Full title string
 * @param {number}  maxWidthTwips  Available width for title text (twips, after subtracting margins/padding)
 * @param {number}  preferredPt    Desired max font size in pt (default 40)
 * @param {number}  minPt          Minimum allowed font size in pt (default 24)
 * @returns {{ titlePt: number, titleLines: string[] }}
 */
function calcTitleLayout(title, maxWidthTwips, preferredPt = 40, minPt = 24) {
  // Each CJK character width ≈ pt × 20 twips
  const charWidth = (pt) => pt * 20;
  const charsPerLine = (pt) => Math.floor(maxWidthTwips / charWidth(pt));

  // Try from preferredPt downward until title fits in ≤ 3 lines
  let titlePt = preferredPt;
  let lines;
  while (titlePt >= minPt) {
    const cpl = charsPerLine(titlePt);
    if (cpl < 2) { titlePt -= 2; continue; }
    lines = splitTitleLines(title, cpl);
    if (lines.length <= 3) break;
    titlePt -= 2;
  }

  // If still > 3 lines at minPt, force 3 lines
  if (!lines || lines.length > 3) {
    const cpl = charsPerLine(minPt);
    lines = splitTitleLines(title, cpl);
    titlePt = minPt;
  }

  return { titlePt, titleLines: lines };
}

/**
 * Smart Chinese title line-breaking — breaks at semantic boundaries, never mid-word.
 *
 * Rules:
 * 1. Prefer breaking after particles, punctuation, connectors, underscores, spaces
 * 2. Never split a compound word (e.g., "管理规范" must not become "管理规" + "范")
 * 3. No single-character orphan on the last line — merge into previous line
 * 4. If no good break point found within 60-130% of charsPerLine, break at charsPerLine
 *
 * @param {string} title        Full title string
 * @param {number} charsPerLine Max characters per line at current font size
 * @returns {string[]}          Array of line strings
 */
function splitTitleLines(title, charsPerLine) {
  if (title.length <= charsPerLine) return [title];

  // Characters that are safe break points (break AFTER these)
  const breakAfter = new Set([
    ...'，。、；：！？',              // CJK punctuation
    ...'的与和及之在于为',            // CJK particles/prepositions
    ...'-_—–·/',                     // connectors
    ...' \t',                         // whitespace
  ]);

  const lines = [];
  let remaining = title;

  while (remaining.length > charsPerLine) {
    let breakAt = -1;

    // Search backward from charsPerLine to 60% for a break point
    for (let i = charsPerLine; i >= Math.floor(charsPerLine * 0.6); i--) {
      if (i < remaining.length && breakAfter.has(remaining[i - 1])) {
        breakAt = i;
        break;
      }
    }

    // If not found, search forward up to 130%
    if (breakAt === -1) {
      const limit = Math.min(remaining.length, Math.ceil(charsPerLine * 1.3));
      for (let i = charsPerLine + 1; i < limit; i++) {
        if (breakAfter.has(remaining[i - 1])) {
          breakAt = i;
          break;
        }
      }
    }

    // Last resort: break at charsPerLine, but avoid splitting compound CJK words
    if (breakAt === -1) {
      breakAt = charsPerLine;
      // If both chars at the break boundary are CJK (likely a compound word),
      // step back 1 char to keep the word together
      const prevChar = remaining[breakAt - 1];
      const nextChar = remaining[breakAt];
      if (prevChar && nextChar &&
          !breakAfter.has(prevChar) && !breakAfter.has(nextChar) &&
          /[\u4e00-\u9fff]/.test(prevChar) && /[\u4e00-\u9fff]/.test(nextChar)) {
        breakAt = breakAt - 1;
      }
    }

    lines.push(remaining.slice(0, breakAt).trim());
    remaining = remaining.slice(breakAt).trim();
  }
  if (remaining) lines.push(remaining);

  // Prevent single-character orphan on last line — merge into previous
  if (lines.length > 1 && lines[lines.length - 1].length <= 2) {
    const last = lines.pop();
    lines[lines.length - 1] += last;
  }

  return lines;
}

/**
 * Calculate dynamic spacing values for cover elements to fit within page height.
 *
 * @param {object} params
 * @param {number} params.titleLineCount   Number of title lines
 * @param {number} params.titlePt          Title font size in pt
 * @param {boolean} params.hasSubtitle     Whether subtitle exists
 * @param {boolean} params.hasEnglishLabel Whether English label exists
 * @param {number} params.metaLineCount    Number of meta info lines
 * @param {number} params.fixedHeight      Sum of fixed-height elements (color strips, accent bars, footer) in twips
 * @param {number} params.pageHeight       Total page height in twips (default 16838)
 * @returns {{ topSpacing, midSpacing, bottomSpacing }}  Spacing values in twips
 */
function calcCoverSpacing(params) {
  const {
    titleLineCount = 1, titlePt = 36, hasSubtitle = false,
    hasEnglishLabel = false, metaLineCount = 0,
    fixedHeight = 800, pageHeight = 16838,
    marginTop = 0, marginBottom = 0,   // ★ NEW: pass actual section margins
  } = params;

  // ★ Safety margin: 1200 twips (cross-engine: MS Office renders large fonts
  // taller than calculated; extra 400tw buffer prevents footer clipping)
  const SAFETY = 1200;
  // ★ Subtract page margins from available height (cover section may have margins)
  const usableHeight = pageHeight - marginTop - marginBottom - SAFETY;

  // ★ Accurate height estimation per element:
  const titleHeight = titleLineCount * (titlePt * 23 + 200);
  const subtitleHeight = hasSubtitle ? (12 * 23 + 600) : 0;
  const englishLabelHeight = hasEnglishLabel ? (9 * 23 + 600) : 0;
  const metaHeight = metaLineCount * (10 * 23 + 100);

  // ★ Account for implicit paragraph heights:
  const implicitParaHeight = 3 * 300;

  const contentHeight = titleHeight + subtitleHeight + englishLabelHeight +
                        metaHeight + fixedHeight + implicitParaHeight;

  const remainingSpace = usableHeight - contentHeight;
  const safeRemaining = Math.max(remainingSpace, 400);

  // ★ Footer protection: bottomSpacing must be ≥ FOOTER_MIN to prevent
  // footer + accent line from being clipped at the cell bottom edge
  const FOOTER_MIN = 800;
  const rawTop = Math.floor(safeRemaining * 0.45);
  const rawBottom = Math.floor(safeRemaining * 0.45);
  const bottomSpacing = Math.max(rawBottom, FOOTER_MIN);
  const topSpacing = Math.max(rawTop - Math.max(0, FOOTER_MIN - rawBottom), 400);
  const midSpacing = Math.max(safeRemaining - topSpacing - bottomSpacing, 0);

  return { topSpacing, midSpacing, bottomSpacing };
}
```

**Usage in every recipe:**
```js
// Step 1: Calculate title layout
const availableWidth = 11906 - leftPadding - rightPadding; // subtract margins
const { titlePt, titleLines } = calcTitleLayout(config.title, availableWidth);
const titleSize = titlePt * 2; // convert to half-points for docx-js

// Step 2: Calculate spacing (pass actual section margins!)
const spacing = calcCoverSpacing({
  titleLineCount: titleLines.length,
  titlePt,
  hasSubtitle: !!config.subtitle,
  hasEnglishLabel: !!config.englishLabel,
  metaLineCount: (config.metaLines || []).length,
  fixedHeight: 800, // sum of accent strips, footer table, etc.
  marginTop: 0,     // ★ pass the cover section's actual top margin (twips)
  marginBottom: 0,  // ★ pass the cover section's actual bottom margin (twips)
});

// Step 3: Use in paragraphs
children.push(new Paragraph({ spacing: { before: spacing.topSpacing } }));
// ... title paragraphs using titleLines and titleSize ...
children.push(new Paragraph({ spacing: { before: spacing.bottomSpacing } }));
```

---

### ⚠️ CRITICAL — Cover Section Non-Negotiables (ALL Recipes)

These 3 properties are MANDATORY for every cover implementation (R1–R5). Omitting ANY of them causes cover layout failure:

1. **Cover section margin = 0**: The cover MUST be in its own section with `page.margin: { top: 0, bottom: 0, left: 0, right: 0 }`. Non-zero margins shrink the wrapper away from page edges → white gaps around the cover ("cover not filling the page"). This is the #1 cause of broken cover layouts.

2. **Wrapper row exact height**: The outer wrapper table row MUST set `height: { value: 16838, rule: "exact" }`. Without this, content overflow pushes to page 2, or insufficient content leaves bottom whitespace.

3. **Wrapper table borders = allNoBorders**: MUST explicitly set `borders: allNoBorders`. Default docx-js borders add ~8 twips per edge. MS Office includes border thickness in exact-height calculation → total exceeds 16838 → blank page 2 (WPS is lenient, MS Office is strict).

4. **⚠️ NO NESTED TABLES**: Never place a `new Table()` inside another table's `TableCell.children`. WPS does not render `shading` (background color) on nested tables → backgrounds disappear → white text on white = invisible. When a cover needs multiple background colors (e.g., R4 dark+white split), use **multiple rows in ONE flat table**. See R4 for the correct pattern.

**Cover section template (copy this for every Recipe):**
```js
sections: [
  {
    // ⚠️ Cover section — margin MUST be 0, separate from body
    properties: {
      page: {
        size: { width: 11906, height: 16838 },
        margin: { top: 0, bottom: 0, left: 0, right: 0 },
      },
    },
    children: buildCoverRX(config), // ← replace with actual recipe function
  },
  {
    // Body section — normal margins
    properties: {
      type: SectionType.NEXT_PAGE,
      page: {
        size: { width: 11906, height: 16838 },
        margin: { top: 1440, bottom: 1440, left: 1797, right: 1797 },
      },
    },
    children: [...bodyContent],
  },
]
```

---

### Recipe R1: Pure Paragraph Cover (Left-Aligned)

**Visual:** Full-page dark background + left-aligned text + decoration via paragraph borders only
**Use case:** Annual report, business report, tech proposal (most versatile premium recipe)
**Nested tables: ZERO** — all decoration uses paragraph borders (bottom line, left accent bar, top separator)

Visual hierarchy (top to bottom):
1. Dynamic top whitespace (via `calcCoverSpacing`)
2. English label with accent bottom border (paragraph `border.bottom`)
3. Main title (1-3 lines, dynamic font size via `calcTitleLayout`)
4. Subtitle (light grey, smaller)
5. Meta info lines with left accent border (paragraph `border.left`)
6. Dynamic bottom whitespace
7. Footer line with top accent separator (paragraph `border.top`)

```js
// ⚠️ MANDATORY: Cover section must use margin: 0. See "Cover Section Non-Negotiables" above.
// Section: { properties: { page: { size: { width: 11906, height: 16838 },
//   margin: { top: 0, bottom: 0, left: 0, right: 0 } } }, children: buildCoverR1(config) }

function buildCoverR1(config) {
  // config: { title, subtitle, englishLabel, metaLines, footerLeft, footerRight, palette }
  // palette is FLAT: { bg, accent, titleColor, subtitleColor, metaColor, footerColor, headerBg, ... }
  // Usage: palette: coverPalettes["DS-1"]  (direct, no spreading needed)
  const P = config.palette;
  if (!P.bg) throw new Error('palette.bg is missing! Pass coverPalettes["XX"] directly.');
  const padL = 1200, padR = 1200;

  // ⚠️ MANDATORY: Use calcTitleLayout() for dynamic font size + line breaking
  const availableWidth = 11906 - padL - padR - 300; // -300 for border space
  const { titlePt, titleLines } = calcTitleLayout(config.title, availableWidth, 40, 24);
  const titleSize = titlePt * 2;

  // ⚠️ MANDATORY: Use calcCoverSpacing() for dynamic spacing
  const spacing = calcCoverSpacing({
    titleLineCount: titleLines.length, titlePt,
    hasSubtitle: !!config.subtitle, hasEnglishLabel: !!config.englishLabel,
    metaLineCount: (config.metaLines || []).length,
    fixedHeight: 400, // footer line only (no nested tables)
  });

  const accentLeft = { style: BorderStyle.SINGLE, size: 8, color: P.accent, space: 12 };
  const children = [];

  // 1. Top whitespace (dynamic)
  children.push(new Paragraph({ spacing: { before: spacing.topSpacing } }));

  // 2. English label with accent bottom border
  if (config.englishLabel) {
    children.push(new Paragraph({
      indent: { left: padL, right: padR }, spacing: { after: 500 },
      border: { bottom: { style: BorderStyle.SINGLE, size: 6, color: P.accent, space: 8 } },
      children: [new TextRun({ text: config.englishLabel.split("").join("  "),
        size: 18, color: P.accent, font: { ascii: "FreeSerif", eastAsia: "Noto Sans SC" }, characterSpacing: 40 })],
    }));
  }

  // 3. Main title (dynamic font size + smart line breaks)
  for (let i = 0; i < titleLines.length; i++) {
    children.push(new Paragraph({
      indent: { left: padL },
      spacing: { after: i < titleLines.length - 1 ? 100 : 300, line: Math.ceil(titlePt * 23), lineRule: "atLeast" },
      children: [new TextRun({ text: titleLines[i], size: titleSize, bold: true,
        color: P.titleColor, font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 4. Subtitle
  if (config.subtitle) {
    children.push(new Paragraph({
      indent: { left: padL }, spacing: { after: 800 },
      children: [new TextRun({ text: config.subtitle, size: 24, color: P.subtitleColor,
        font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 5. Meta info lines with left accent border
  for (const line of (config.metaLines || [])) {
    children.push(new Paragraph({
      indent: { left: padL + 200 }, spacing: { after: 80 },
      border: { left: accentLeft },
      children: [new TextRun({ text: line, size: 24, color: P.metaColor,
        font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 6. Bottom whitespace (dynamic)
  children.push(new Paragraph({ spacing: { before: spacing.bottomSpacing } }));

  // 7. Footer with top accent separator
  children.push(new Paragraph({
    indent: { left: padL, right: padR },
    border: { top: { style: BorderStyle.SINGLE, size: 2, color: P.accent, space: 8 } },
    spacing: { before: 200 },
    children: [
      new TextRun({ text: config.footerLeft || "", size: 16, color: P.footerColor, font: { ascii: "Liberation Sans" } }),
      new TextRun({ text: "                                        " }),
      new TextRun({ text: config.footerRight || "", size: 16, color: P.footerColor, font: { ascii: "Liberation Sans" } }),
    ],
  }));

  // Single 16838 wrapper — the ONLY table
  return [new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    borders: allNoBorders,
    rows: [new TableRow({
      height: { value: 16838, rule: "exact" },
      children: [new TableCell({
        shading: { type: ShadingType.CLEAR, fill: P.bg }, borders: noBorders,
        children,
      })],
    })],
  })];
  // Total height: 16838 (single wrapper, zero nested tables) ✅
}
```

---

### Recipe R2: Double-Rule Frame (Centered)

**Visual:** Full-page dark background + top/bottom thick accent horizontal rules + centered content
**Use case:** Whitepaper, finance report, consulting deliverable, high-end formal reports
**Nested tables: ZERO** — top/bottom rules are paragraph borders

Visual hierarchy (top to bottom):
1. Top thick accent rule (paragraph `border.top`)
2. Generous whitespace
3. English label (centered, spaced)
4. Main title (centered, 1-3 lines, dynamic font size)
5. Subtitle (centered)
6. Generous whitespace
7. Meta info lines (centered, **18pt** / size: 36)
8. Generous whitespace
9. Footer + bottom thick accent rule (paragraph `border.bottom`)

```js
// ⚠️ MANDATORY: Cover section must use margin: 0. See "Cover Section Non-Negotiables" above.
function buildCoverR2(config) {
  // palette is FLAT: { bg, accent, titleColor, ..., headerBg, ... }
  // Usage: palette: coverPalettes["DS-1"]  (direct, no spreading needed)
  const P = config.palette;
  if (!P.bg) throw new Error('palette.bg is missing! Pass coverPalettes["XX"] directly.');
  const padL = 1400, padR = 1400;

  // ⚠️ MANDATORY: Use calcTitleLayout() for dynamic font size + line breaking
  const { titlePt, titleLines } = calcTitleLayout(config.title, 11906 - padL - padR, 40, 24);
  const titleSize = titlePt * 2;
  const thickBorder = { style: BorderStyle.SINGLE, size: 18, color: P.accent, space: 20 };

  const children = [];

  // 1. Top rule
  children.push(new Paragraph({
    indent: { left: padL - 400, right: padR - 400 }, spacing: { before: 1200, after: 200 },
    border: { top: thickBorder }, children: [],
  }));

  // 2. Whitespace
  children.push(new Paragraph({ spacing: { before: 1800 } }));

  // 3. English label
  if (config.englishLabel) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, spacing: { after: 500 },
      children: [new TextRun({ text: config.englishLabel.split("").join("  "),
        size: 18, color: P.accent, font: { ascii: "FreeSerif" }, characterSpacing: 40 })],
    }));
  }

  // 4. Main title (centered, dynamic)
  for (let i = 0; i < titleLines.length; i++) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER,
      spacing: { after: i < titleLines.length - 1 ? 80 : 300, line: Math.ceil(titlePt * 23), lineRule: "atLeast" },
      children: [new TextRun({ text: titleLines[i], size: titleSize, bold: true,
        color: P.titleColor, font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 5. Subtitle
  if (config.subtitle) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, spacing: { after: 400 },
      children: [new TextRun({ text: config.subtitle, size: 24, color: P.subtitleColor,
        font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 6. Whitespace
  children.push(new Paragraph({ spacing: { before: 1200 } }));

  // 7. Meta lines — 18pt (size: 36) for readability
  for (const line of (config.metaLines || [])) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER,
      spacing: { after: 100, line: Math.ceil(18 * 23), lineRule: "atLeast" },
      children: [new TextRun({ text: line, size: 36, color: P.metaColor,
        font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 8. Whitespace
  children.push(new Paragraph({ spacing: { before: 2000 } }));

  // 9. Footer + bottom rule
  children.push(new Paragraph({
    alignment: AlignmentType.CENTER,
    indent: { left: padL - 400, right: padR - 400 }, spacing: { before: 200 },
    border: { bottom: thickBorder },
    children: [new TextRun({ text: config.footerRight || "", size: 18, color: P.footerColor, font: { ascii: "Liberation Sans" } })],
  }));

  // Single 16838 wrapper — the ONLY table
  return [new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    borders: allNoBorders,
    rows: [new TableRow({
      height: { value: 16838, rule: "exact" },
      children: [new TableCell({
        shading: { type: ShadingType.CLEAR, fill: P.bg }, borders: noBorders,
        children,
      })],
    })],
  })];
  // Total height: 16838 (single wrapper, zero nested tables) ✅
}
```

---

### Recipe R3: Centered Card Frame (Paragraph Borders)

**Visual:** Full-page dark background + centered "card" effect via paragraph indent + 4-side paragraph borders
**Use case:** Research report, product overview, event summary, creative/design documents
**Nested tables: ZERO** — card borders are paragraph borders with large left/right indents

Visual hierarchy (top to bottom):
1. Pre-card whitespace (~2800tw)
2. Card top edge (paragraph with `border.top` + `border.left` + `border.right`, indent 2200tw)
3. English label (centered, inside card side borders)
4. Main title (centered, inside card side borders, dynamic font size)
5. Subtitle (centered, inside card side borders)
6. Spacer (inside card side borders)
7. Meta info lines (centered, inside card side borders)
8. Card bottom edge (paragraph with `border.bottom` + `border.left` + `border.right`)
9. Post-card whitespace
10. Footer (centered)

```js
// ⚠️ MANDATORY: Cover section must use margin: 0. See "Cover Section Non-Negotiables" above.
function buildCoverR3(config) {
  // palette is FLAT: { bg, accent, titleColor, ..., headerBg, ... }
  // Usage: palette: coverPalettes["DS-1"]  (direct, no spreading needed)
  const P = config.palette;
  if (!P.bg) throw new Error('palette.bg is missing! Pass coverPalettes["XX"] directly.');
  const cardIndent = 2200; // left + right indent to create "card" feel
  const innerWidth = 11906 - cardIndent * 2 - 400;

  // ⚠️ MANDATORY: Use calcTitleLayout() for dynamic font size + line breaking
  const { titlePt, titleLines } = calcTitleLayout(config.title, innerWidth, 40, 24);
  const titleSize = titlePt * 2;

  const bTop = { style: BorderStyle.SINGLE, size: 24, color: P.accent, space: 16 };
  const bBot = { style: BorderStyle.SINGLE, size: 24, color: P.accent, space: 16 };
  const bL = { style: BorderStyle.SINGLE, size: 2, color: P.accent, space: 16 };
  const bR = { style: BorderStyle.SINGLE, size: 2, color: P.accent, space: 16 };
  const sides = { left: bL, right: bR };

  const children = [];

  // 1. Pre-card whitespace
  children.push(new Paragraph({ spacing: { before: 2800 } }));

  // 2. Card top edge
  children.push(new Paragraph({
    indent: { left: cardIndent, right: cardIndent }, spacing: { after: 600 },
    border: { top: bTop, left: bL, right: bR }, children: [],
  }));

  // 3. English label inside card
  if (config.englishLabel) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, indent: { left: cardIndent, right: cardIndent },
      spacing: { after: 500 }, border: sides,
      children: [new TextRun({ text: config.englishLabel.split("").join("  "),
        size: 16, color: P.accent, font: { ascii: "FreeSerif" }, characterSpacing: 30 })],
    }));
  }

  // 4. Main title inside card
  for (let i = 0; i < titleLines.length; i++) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, indent: { left: cardIndent, right: cardIndent },
      spacing: { after: i < titleLines.length - 1 ? 60 : 300, line: Math.ceil(titlePt * 23), lineRule: "atLeast" },
      border: sides,
      children: [new TextRun({ text: titleLines[i], size: titleSize, bold: true,
        color: P.titleColor, font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 5. Subtitle inside card
  if (config.subtitle) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, indent: { left: cardIndent, right: cardIndent },
      spacing: { after: 400 }, border: sides,
      children: [new TextRun({ text: config.subtitle, size: 22, color: P.subtitleColor,
        font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 6. Spacer inside card
  children.push(new Paragraph({
    indent: { left: cardIndent, right: cardIndent }, spacing: { before: 400 },
    border: sides, children: [],
  }));

  // 7. Meta info lines inside card
  for (let i = 0; i < (config.metaLines || []).length; i++) {
    const isLast = i === config.metaLines.length - 1;
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, indent: { left: cardIndent, right: cardIndent },
      spacing: { after: isLast ? 400 : 80 }, border: sides,
      children: [new TextRun({ text: config.metaLines[i], size: 24, color: P.metaColor,
        font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
    }));
  }

  // 8. Card bottom edge
  children.push(new Paragraph({
    indent: { left: cardIndent, right: cardIndent }, spacing: { after: 0 },
    border: { bottom: bBot, left: bL, right: bR }, children: [],
  }));

  // 9. Post-card whitespace
  children.push(new Paragraph({ spacing: { before: 2000 } }));

  // 10. Footer
  children.push(new Paragraph({
    alignment: AlignmentType.CENTER,
    children: [new TextRun({ text: config.footerRight || "", size: 16, color: P.footerColor, font: { ascii: "Liberation Sans" } })],
  }));

  // Single 16838 wrapper — the ONLY table
  return [new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    borders: allNoBorders,
    rows: [new TableRow({
      height: { value: 16838, rule: "exact" },
      children: [new TableCell({
        shading: { type: ShadingType.CLEAR, fill: P.bg }, borders: noBorders,
        children,
      })],
    })],
  })];
  // Total height: 16838 (single wrapper, zero nested tables) ✅
}
```


### Recipe R4: Top Color Block

**Visual:** Top 45% dark area (with title) + bottom 55% white area (with meta info) + accent divider
**Use case:** business proposal, plan document, lesson plan, PRD

> **⚠️ CRITICAL — WPS COMPATIBILITY (NO NESTED TABLES!):**
> WPS does NOT render `shading` on tables nested inside another table's cell.
> R4 therefore uses a **single flat 3-row table** with NO nesting:
> - **Row 1** (exact height ~7500): dark background (`P.bg`) + title/subtitle
> - **Row 2** (exact height 60): accent divider
> - **Row 3** (fills remainder to 16838): white background + meta/footer
>
> This is ONE table with THREE rows. There are ZERO nested tables.
> The total table height is 16838 (full A4 page), same as R1.
>
> Every `shading` object MUST include `type: ShadingType.CLEAR`.
>
> **⚠️ FORBIDDEN PATTERNS:**
> - `new Table({ ... children: [new Table({ ... })] })` ← nested table, WPS breaks
> - Putting a Table as a child of another Table's TableCell ← same issue

```js
// ⚠️ MANDATORY: Cover section must use margin: 0. See "Cover Section Non-Negotiables" above.
function buildCoverR4(config) {
  // palette is FLAT: { bg, accent, titleColor, ..., headerBg, ... }
  // Usage: palette: coverPalettes["DS-1"]  (direct, no spreading needed)
  const P = config.palette;
  if (!P.bg) throw new Error('palette.bg is missing! Pass coverPalettes["XX"] directly.');
  const padL = 1200, padR = 1200;
  const availableWidth = 11906 - padL - padR;

  // ⚠️ MANDATORY: Use calcTitleLayout() for dynamic font size + line breaking
  const { titlePt, titleLines } = calcTitleLayout(config.title, availableWidth, 40, 26);
  const titleSize = titlePt * 2;

  // Height budget for upper dark block — DYNAMIC based on title content
  const titleBlockHeight = titleLines.length * (titlePt * 23 + 200);
  const englishLabelH = config.englishLabel ? (9 * 23 + 500) : 0;
  const subtitleH = config.subtitle ? (12 * 23 + 200) : 0;
  const upperContentH = englishLabelH + titleBlockHeight + subtitleH;
  const UPPER_MIN = 7500;
  const UPPER_H = Math.max(UPPER_MIN, upperContentH + 1500 + 800);
  const DIVIDER_H = 60;
  const LOWER_H = 16838 - UPPER_H - DIVIDER_H; // fills rest of page

  // ★ Dynamic top spacing
  const contentEstimate =
    (config.englishLabel ? (9 * 23 + 500) : 0) +
    titleLines.length * (titlePt * 23 + 200) +
    (config.subtitle ? (12 * 23 + 200) : 0);
  const spacerIntrinsic = 280;
  const topSpacing = Math.max(UPPER_H - contentEstimate - spacerIntrinsic - 800, 400);

  // ⚠️ Lower area has WHITE background — text colors must be dark for contrast.
  // Do NOT use P.metaColor/P.footerColor (designed for dark bg, too light on white).
  const lowerMetaColor = "404040";   // contrast 10.4:1 on white ✅
  const lowerFooterColor = "606060"; // contrast 6.3:1 on white ✅

  // ── SINGLE FLAT 3-ROW TABLE (NO NESTING!) ──
  return [new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    borders: allNoBorders,
    rows: [
      // ── Row 1: Dark area with title (≈ 45% of page) ──
      // ⚠️ Use paragraph indent (not cell margins) for left/right padding — WPS renders cell margins inconsistently
      new TableRow({
        height: { value: UPPER_H, rule: "exact" },
        children: [new TableCell({
          shading: { type: ShadingType.CLEAR, fill: P.bg },
          borders: noBorders,
          verticalAlign: "top",
          children: [
            new Paragraph({ spacing: { before: topSpacing }, indent: { left: padL, right: padR } }),
            config.englishLabel ? new Paragraph({
              indent: { left: padL, right: padR },
              spacing: { after: 500 },
              children: [new TextRun({ text: config.englishLabel.split("").join(" "),
                size: 18, color: P.accent, font: { ascii: "FreeSerif" }, characterSpacing: 60 })],
            }) : null,
            ...titleLines.map((line, i) => new Paragraph({
              indent: { left: padL, right: padR },
              spacing: { after: i < titleLines.length - 1 ? 100 : 200 },
              children: [new TextRun({ text: line, size: titleSize, bold: true,
                color: P.titleColor, font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
            })),
            config.subtitle ? new Paragraph({
              indent: { left: padL, right: padR },
              spacing: { after: 100 },
              children: [new TextRun({ text: config.subtitle, size: 24, color: P.subtitleColor,
                font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
            }) : null,
          ].filter(Boolean),
        })],
      }),
      // ── Row 2: Accent divider line ──
      new TableRow({
        height: { value: DIVIDER_H, rule: "exact" },
        children: [new TableCell({
          borders: noBorders,
          shading: { type: ShadingType.CLEAR, fill: P.accent },
          children: [emptyPara()],
        })],
      }),
      // ── Row 3: White area with meta info (≈ 55% of page) ──
      // ⚠️ Use paragraph indent (not cell margins) for left/right padding — WPS renders cell margins inconsistently
      new TableRow({
        height: { value: LOWER_H, rule: "exact" },
        children: [new TableCell({
          shading: { type: ShadingType.CLEAR, fill: "FFFFFF" },
          borders: noBorders,
          verticalAlign: "top",
          children: [
            new Paragraph({ spacing: { before: 800 }, indent: { left: padL, right: padR } }),
            ...(config.metaLines || []).map(line => new Paragraph({
              indent: { left: padL, right: padR },
              spacing: { after: 100 },
              children: [new TextRun({ text: line, size: 28, color: lowerMetaColor,
                font: { eastAsia: "Noto Sans SC", ascii: "Liberation Sans" } })],
            })),
            new Paragraph({ spacing: { before: 2000 }, indent: { left: padL, right: padR } }),
            new Paragraph({
              indent: { left: padL, right: padR },
              children: [
                new TextRun({ text: config.footerLeft || "", size: 22, color: lowerFooterColor }),
                new TextRun({ text: "          " }),
                new TextRun({ text: config.footerRight || "", size: 22, color: lowerFooterColor }),
              ],
            }),
          ],
        })],
      }),
    ],
  })];
  // Total: UPPER_H + DIVIDER_H + LOWER_H = 16838 (full A4 page) ✅
  // Architecture: ONE table, THREE rows, ZERO nesting ✅
}
```

---

### Recipe R5: Clean White (Academic)

**Visual:** Pure white background + school name + centered title + 2-column meta info table with underlines + footer
**Use case:** academic thesis, standards documents
**Architecture:** 16838 outer wrapper (white fill, invisible) + cell margins for page margin simulation. No top/bottom decorative lines.

**Meta info table rules (cross-engine safe):**
- 2-column table: label + value, **percentage widths only** (`WidthType.PERCENTAGE`)
- **Table width is adaptive:** 55–75% of page, calculated by `calcR5MetaLayout()`. Table centered via `alignment: CENTER`.
- **Label column:** adaptive 25–45% of table, **LEFT aligned**, plain text with "：" appended. NO full-width space padding, NO right-alignment.
- **Label column borders:** none (no bottom border on label cells).
- **Value column:** remaining %, **LEFT aligned**, `bottom: single sz=4` border = fixed-length underline (consistent length for all rows regardless of text).
- No left/right/top borders on either column.
- ⚠️ Do NOT use DXA widths, full-width space padding (`\u3000`), spacer columns, or tab stops — WPS renders them inconsistently.
- ⚠️ Do NOT use `margins.top` on the wrapper cell — use `spacing.before` on first paragraph instead.

**Known limitation:** When meta lines ≥ 6 AND title has 3 lines, MS Office may render content slightly taller than WPS, potentially clipping the footer line. Mitigate by reducing `midSpacing` or using a smaller title font.

```js
// ── Width-aware title layout (handles mixed Chinese + English) ──
function estimateTextWidth(text, pt) {
  let width = 0;
  for (const ch of text) {
    const code = ch.codePointAt(0);
    const isCJK = (code >= 0x4E00 && code <= 0x9FFF) || (code >= 0x3400 && code <= 0x4DBF) ||
      (code >= 0x3000 && code <= 0x303F) || (code >= 0xFF00 && code <= 0xFFEF) ||
      (code >= 0x2E80 && code <= 0x2EFF);
    width += isCJK ? pt * 20 : pt * 11; // CJK: full-width, Latin: ~55% width
  }
  return width;
}
// Use estimateTextWidth() in calcTitleLayout() instead of simple char count
// to prevent mid-word breaks in mixed Chinese+English titles like "基于Transformer架构的..."

// ── Meta info table ──

// Calculate adaptive table and label column percentage based on longest label.
// Returns { tablePct, labelPct } — both as percentages.
// Uses ONLY WidthType.PERCENTAGE for cross-engine compatibility (MS Office + WPS).
function calcR5MetaLayout(metaEntries, fontPt = 12) {
  const maxLabelLen = Math.max(...metaEntries.map(e => [...e.label].length));
  // Label needs: maxLabelLen chars + "：" + 1 char padding
  const labelNeedTw = (maxLabelLen + 2) * fontPt * 20;
  // Value column: fixed ~5000tw for consistent underline length
  const valueNeedTw = 5000;
  const totalNeedTw = labelNeedTw + valueNeedTw;
  // Table width as % of page (11906tw), clamped to 55–75%
  const tablePct = Math.min(75, Math.max(55, Math.ceil(totalNeedTw / 11906 * 100)));
  // Label % within the table, clamped to 25–45%
  const rawLabelPct = Math.ceil(labelNeedTw / (tablePct / 100 * 11906) * 100);
  return { tablePct, labelPct: Math.max(25, Math.min(45, rawLabelPct)) };
}

// Build R5 academic cover meta info table.
// ⚠️ CRITICAL cross-engine rules:
//   - Table width: WidthType.PERCENTAGE (NOT DXA — WPS breaks with DXA)
//   - Column widths: WidthType.PERCENTAGE
//   - Label column: LEFT aligned, plain text (NO full-width space padding)
//   - Value column: LEFT aligned, bottom border = fixed-length underline
//   - Table alignment: CENTER (visually centered on page)
function buildR5MetaTable(metaEntries) {
  // metaEntries: [{ label: "学院", value: "计算机科学与技术学院" }, ...]
  const { tablePct, labelPct } = calcR5MetaLayout(metaEntries);
  const valuePct = 100 - labelPct;
  const bottomBorder = { style: BorderStyle.SINGLE, size: 4, color: "000000" };

  const rows = metaEntries.map(entry => new TableRow({
    children: [
      // Label cell: left-aligned, no bottom border
      new TableCell({
        width: { size: labelPct, type: WidthType.PERCENTAGE },
        borders: noBorders,
        margins: { top: 60, bottom: 60, left: 0, right: 0 },
        children: [new Paragraph({
          alignment: AlignmentType.LEFT,
          spacing: { before: 60, after: 60, line: 400 },
          children: [new TextRun({
            text: entry.label + "：",
            size: 24, font: { eastAsia: "Noto Serif SC", ascii: "FreeSerif" },
          })],
        })],
      }),
      // Value cell: left-aligned, bottom border = fixed-length underline
      new TableCell({
        width: { size: valuePct, type: WidthType.PERCENTAGE },
        borders: { top: NB, left: NB, right: NB, bottom: bottomBorder },
        margins: { top: 60, bottom: 60, left: 80, right: 0 },
        children: [new Paragraph({
          alignment: AlignmentType.LEFT,
          spacing: { before: 60, after: 60, line: 400 },
          children: [new TextRun({
            text: entry.value,
            size: 24, font: { eastAsia: "Noto Serif SC", ascii: "FreeSerif" },
          })],
        })],
      }),
    ],
  }));

  return new Table({
    width: { size: tablePct, type: WidthType.PERCENTAGE },
    alignment: AlignmentType.CENTER,
    layout: TableLayoutType.FIXED,
    borders: allNoBorders,
    rows,
  });
}

// ⚠️ MANDATORY: Cover section must use margin: 0. See "Cover Section Non-Negotiables" above.
function buildCoverR5(config) {
  const PAGE_H = 16838, SAFETY = 1200;
  const safeH = PAGE_H - SAFETY; // 15638
  const simMarginLR = 1797, simMarginT = 1200;
  const contentW = 11906 - simMarginLR * 2;

  // ★ Width-aware title layout for mixed Chinese+English
  const { titlePt, titleLines } = calcTitleLayoutMixed(config.title, contentW, 36, 24);
  const titleSize = titlePt * 2;

  // Parse meta entries
  const metaEntries = (config.metaLines || []).map(line => {
    const sep = line.indexOf("：") !== -1 ? "：" : ":";
    const idx = line.indexOf(sep);
    if (idx === -1) return { label: line, value: "" };
    return { label: line.slice(0, idx).trim(), value: line.slice(idx + sep.length).trim() };
  });

  // Height budget (no margins.top — use spacing.before instead)
  const schoolNameH = config.schoolName ? (22 * 23 + 400) : 0;
  const titleTotalH = titleLines.length * (titlePt * 23 + 200);
  const subtitleH = config.subtitle ? (15 * 23 + 600) : 0;
  const metaRowH = 520; // 60+60 padding + ~400 line height
  const metaTableH = metaEntries.length * metaRowH;
  const footerH = config.footerRight ? (12 * 23 + 200) : 0;
  const spacerParas = 3 * 350;
  const fixedH = schoolNameH + titleTotalH + subtitleH + metaTableH + footerH + spacerParas;
  const remaining = Math.max(safeH - fixedH, 600);

  // ★ topSpacing includes simulated top margin (simMarginT)
  const topSpacing = Math.min(Math.floor(remaining * 0.28) + simMarginT, 4200);
  const midSpacing = Math.min(Math.floor((remaining - simMarginT) * 0.18), 2000);
  const bottomSpacing = Math.min(remaining - topSpacing + simMarginT - midSpacing, 5500);

  const children = [];
  children.push(new Paragraph({ spacing: { before: topSpacing } }));

  // School name (optional)
  if (config.schoolName) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, spacing: { after: 400 },
      children: [new TextRun({ text: config.schoolName, size: 44, characterSpacing: 40,
        font: { eastAsia: "Noto Serif SC", ascii: "FreeSerif" } })],
    }));
  }

  // Title
  for (let i = 0; i < titleLines.length; i++) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, spacing: { after: i < titleLines.length - 1 ? 120 : 300 },
      children: [new TextRun({ text: titleLines[i], size: titleSize, bold: true,
        font: { eastAsia: "Noto Sans SC", ascii: "FreeSerif" } })],
    }));
  }

  // Subtitle
  if (config.subtitle) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER, spacing: { after: 200 },
      children: [new TextRun({ text: config.subtitle, size: 30,
        font: { eastAsia: "Noto Serif SC", ascii: "FreeSerif" } })],
    }));
  }

  children.push(new Paragraph({ spacing: { before: midSpacing } }));

  // Meta info table
  if (metaEntries.length > 0) children.push(buildR5MetaTable(metaEntries));

  children.push(new Paragraph({ spacing: { before: bottomSpacing } }));

  // Footer
  if (config.footerRight) {
    children.push(new Paragraph({
      alignment: AlignmentType.CENTER,
      children: [new TextRun({ text: config.footerRight, size: 24, color: "404040",
        font: { eastAsia: "Noto Serif SC", ascii: "FreeSerif" } })],
    }));
  }

  // ★ 16838 outer wrapper — only left/right margins, NO margins.top
  return [new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    borders: allNoBorders,
    rows: [new TableRow({
      height: { value: PAGE_H, rule: "exact" },
      children: [new TableCell({
        shading: { type: ShadingType.CLEAR, fill: "FFFFFF" },
        borders: noBorders, verticalAlign: "top",
        margins: { left: simMarginLR, right: simMarginLR },
        children,
      })],
    })],
  })];
  // Height budget example (short title, 4 meta lines):
  // topSpacing(3818) + schoolName(906) + title(1028) + subtitle(945) + midSpacing(1467)
  // + metaTable(4×520=2080) + bottomSpacing(5268) + footer(476) = ~15988 < 15838 ✅
}
```

---

### blendColors Utility Function

```js
function blendColors(hex1, hex2, ratio) {
  const p = (s, i) => parseInt(s.replace("#","").slice(i, i+2), 16);
  const mix = (c1, c2) => Math.round(c1 + (c2 - c1) * ratio);
  const r = mix(p(hex1,0), p(hex2,0)), g = mix(p(hex1,2), p(hex2,2)), b = mix(p(hex1,4), p(hex2,4));
  return [r, g, b].map(v => v.toString(16).padStart(2,"0")).join("");
}
```



## Geometric Decoration System

→ See `references/decorations.md` for the full geometric decoration element library (decoration elements, usage scenarios, code examples).

## Chinese Plot PNG Method (matplotlib)

```python
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties

font_paths = [
    "/System/Library/Fonts/Supplemental/NotoSansSC[wght].ttf",
    "/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc",
    "./NotoSansSC[wght].ttf",
]
zh_font = None
for fp in font_paths:
    try:
        zh_font = FontProperties(fname=fp)
        break
    except:
        continue

plt.rcParams["axes.unicode_minus"] = False
```

## Chart Quality Rules

### Chart Color Palette

Default: **low-saturation (Morandi style)** palette to avoid flashy high-saturation. High-saturation palette only for explicitly energetic scenarios (events/education/creative).

```js
const chartColors = {
  // Default: low saturation, professional (S: 25-40%, L: 55-68%)
  default: ["6B9DAD", "C49B72", "7BA68A", "B87472", "9687A8", "C8B87C", "7AADA0", "7A9BB8"],
  // Vivid: only for energetic/creative scenes
  vivid:   ["2F97B8", "E67E22", "27AE60", "E74C3C", "9B59B6", "F1C40F", "1ABC9C", "3498DB"],
};

// Scene selection:
// - report/whitepaper/consulting/academic/contract → default
// - activity/education/creative copy → vivid (optional)
```

**Color usage rules:**
- Max **5 colors** per chart; excess categories use depth variants of same hue
- Emphasis data uses document accent color; non-emphasis uses grey `#B0B0B0`
- Adjacent segments in pie/bar charts must have hue gap ≥ 60°

1. **Anti-overlap**: If >6 x-axis labels, rotate 45° (`plt.xticks(rotation=45, ha='right')`)
2. **Anti-stretch**: Always set figure size explicitly (`fig, ax = plt.subplots(figsize=(10, 6))`)
3. **Aspect ratio (CRITICAL)**: When embedding in docx, MUST read actual image dimensions and calculate height proportionally. NEVER hardcode both width and height — pie charts become ellipses, radar charts become diamonds.
   ```js
   const sizeOf = require("image-size");
   const dims = sizeOf(chartBuffer);
   const displayWidth = 500;
   const displayHeight = Math.round(displayWidth * (dims.height / dims.width));
   // transformation: { width: displayWidth, height: displayHeight }
   ```
4. **DPI**: Save at 200+ DPI (`plt.savefig("chart.png", dpi=200, bbox_inches="tight")`)
5. **Colors**: Use palette accent color for primary data series
6. **Legend**: Place outside plot area if >4 series
7. **Square charts**: Pie and radar charts MUST use `figsize=(8, 8)` (equal width/height) to preserve circular/radial shape
7. **Grid**: Light gray grid (`ax.grid(True, alpha=0.3)`)

---

## Typography Rules

### CJK Body Text
- **Alignment**: Justified (`AlignmentType.JUSTIFIED`)
- **First-line indent**: 2 characters — Profile A (Noto Serif SC): `firstLine: 480`; Profile B (Noto Sans SC): `firstLine: 420`. See `common-rules.md` for profile definitions.
- **Line spacing**: 1.3x = `spacing: { line: 312 }`
- **No heading indent**: Headings must NOT have first-line indent

### English Body Text
- **Alignment**: Left (`AlignmentType.LEFT`)
- **No indent**
- **Line spacing**: Same 1.3x

### Table Numbers
- Right-aligned in cells
- Use monospace or tabular figures if available

### Headings
- No first-line indent
- `spacing: { before: 240, after: 120 }` (H1: before 360)
- Bold, `palette.headingColor || palette.primary` color

### Post-Table Spacing — MANDATORY

Paragraphs immediately following a table MUST use `spacing: { before: 300 }` to create adequate visual separation from the table's last row. Without this, body text appears to "stick" to the table bottom border.

- **Body text after table**: `spacing: { before: 300, after: 200, line: 360 }`
- **Heading after table**: `spacing: { before: 400, after: 200 }` (already sufficient via heading defaults)
- This rule applies regardless of palette or scene.

### 1.3x Line Spacing — MANDATORY
Every document, every paragraph. `spacing: { line: 312 }`. No exceptions unless scene explicitly overrides (e.g., resume uses 1.15x).

---

## Page Layout — A4 Standard

```js
sections: [{
  properties: {
    page: {
      size: { width: 11906, height: 16838, orientation: PageOrientation.PORTRAIT },
      margin: { top: 1440, bottom: 1440, left: 1797, right: 1797 },
      // Top/bottom 2.54cm = 1440, left/right 3.17cm = 1797 twips
    },
  },
  children: [/* ... */],
}]
```

These are defaults. Scenes may override (e.g., official docs use different margins).

### Scene Font Override Rules

Default font config (docx-js Font Configuration in design-system.md) uses Noto Sans SC+FreeSerif for most business scenarios. The following scenes have dedicated font requirements — **scene rules override defaults**:

| Scene | Body CN | Body EN | Headings | Body Color |
|------|----------|----------|------|----------|
| Default (general) | Noto Sans SC | FreeSerif | Noto Sans SC + FreeSerif | palette.body |
| **Report** | **Noto Serif SC** | **FreeSerif** | **Noto Sans SC + FreeSerif** | **"000000" (pure black)** |
| **Academic** | **Noto Serif SC** | **FreeSerif** | **Noto Sans SC + FreeSerif** | **"000000" (pure black)** |
| **Contract** | **Noto Serif SC** | **FreeSerif** | **Noto Sans SC + FreeSerif** | **"000000" (pure black)** |
| Official doc | LXGW WenKai | — | Noto Serif SC Bold | "000000" |
| Resume | Noto Sans SC | FreeSerif | Noto Sans SC + FreeSerif | palette.body |

When report or academic scene is loaded, `styles.default.document.run` font and color must be overridden per scene. Heading sizes may also differ (e.g., report scene H1 centered, H2 uses Xiao San size:30 instead of default Si Hao size:28). Scene file takes precedence.
