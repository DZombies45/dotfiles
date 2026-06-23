local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- ─────────────────────────────────────────────────────────────────
  -- MARKDOWN DASAR
  -- ─────────────────────────────────────────────────────────────────

  s("h1", fmt("# {}", { i(1, "Judul") })),
  s("h2", fmt("## {}", { i(1, "Subjudul") })),
  s("h3", fmt("### {}", { i(1, "Sub-subjudul") })),
  s("link", fmt("[{}]({})", { i(1, "teks"), i(2, "url") })),
  s("img", fmt("![{}]({})", { i(1, "alt"), i(2, "gambar.png") })),
  s("code", fmt("```{}\n{}\n```", { i(1, "js"), i(2, "// kode di sini") })),
  s("todo", fmt("- [ ] {}", { i(1, "task") })),
  s("bold", fmt("**{}**", { i(1, "teks") })),
  s("italic", fmt("*{}*", { i(1, "teks") })),
  s("imcbapi", fmt("![{}](https://i.imgur.com/3ufQ6D7.jpeg)", { i(1, "beta api") })),

  -- ─────────────────────────────────────────────────────────────────
  -- HUGO FRONT MATTER
  -- ─────────────────────────────────────────────────────────────────

  -- Front matter lengkap
  s("fm", fmt([[
---
title: "{}"
date: {}
draft: {}
description: "{}"
tags: [{}]
categories: [{}]
---

{}]], {
    i(1, "Judul Post"),
    i(2, "2024-01-01"),
    i(3, "false"),
    i(4, "Deskripsi singkat post ini."),
    i(5, '"tag1", "tag2"'),
    i(6, '"kategori"'),
    i(7),
  })),

  -- Front matter ringkas
  s("fms", fmt([[
---
title: "{}"
date: {}
draft: {}
---

{}]], {
    i(1, "Judul"),
    i(2, "2024-01-01"),
    i(3, "false"),
    i(4),
  })),

  -- ─────────────────────────────────────────────────────────────────
  -- BLOWFISH SHORTCODES
  -- ─────────────────────────────────────────────────────────────────

  -- Alert — basic
  s("bf-alert", fmt([[
{{{{< alert >}}}}
{}
{{{{< /alert >}}}}]], { i(1, "**Warning!** Pesan penting di sini.") })),

  -- Alert — dengan icon & warna kustom
  s("bf-alertc", fmt([[
{{{{< alert icon="{}" cardColor="{}" iconColor="{}" textColor="{}" >}}}}
{}
{{{{< /alert >}}}}]], {
    i(1, "fire"),
    i(2, "#e63946"),
    i(3, "#1d3557"),
    i(4, "#f1faee"),
    i(5, "Ini adalah error!"),
  })),

  -- Admonition (Markdown-native, portable)
  -- Tipe: NOTE | TIP | IMPORTANT | WARNING | CAUTION
  -- Obsidian: note|abstract|info|todo|tip|success|question|warning|failure|danger|bug|example|quote
  s("bf-admon", fmt([[
> [!{}]
> {}]], { i(1, "NOTE"), i(2, "Isi admonition di sini.") })),

  -- Admonition collapsible (+ = expand, - = collapse)
  s("bf-admonc", fmt([[
> [!{}]+ {}
> {}
{{{{icon="{}"}}}}]], {
    i(1, "TIP"),
    i(2, "Judul Kustom"),
    i(3, "Konten admonition."),
    i(4, "star"),
  })),

  -- Accordion — wrapper
  s("bf-accordion", fmt([[
{{{{< accordion mode="{}" separated={} >}}}}
  {{{{< accordionItem title="{}" icon="{}" open={} >}}}}
  {}
  {{{{< /accordionItem >}}}}
  {{{{< accordionItem title="{}" >}}}}
  {}
  {{{{< /accordionItem >}}}}
{{{{< /accordion >}}}}]], {
    i(1, "collapse"),   -- collapse | open
    i(2, "false"),      -- separated card per item
    i(3, "Item 1"),
    i(4, "star"),
    i(5, "true"),
    i(6, "Konten item pertama."),
    i(7, "Item 2"),
    i(8, "Konten item kedua."),
  })),

  -- Article embed
  s("bf-article", fmt([[
{{{{< article link="{}" showSummary={} compactSummary={} >}}}}]], {
    i(1, "/posts/nama-post/"),
    i(2, "true"),
    i(3, "false"),
  })),

  -- Badge
  s("bf-badge", fmt("{{{{< badge >}}}}{}{{{{< /badge >}}}}", { i(1, "New!") })),

  -- Button — href
  s("bf-button", fmt([[
{{{{< button href="{}" target="{}" >}}}}
{}
{{{{< /button >}}}}]], {
    i(1, "https://example.com"),
    i(2, "_self"),
    i(3, "Klik di sini"),
  })),

  -- Button — pageRef (internal, language-aware)
  s("bf-buttonp", fmt([[
{{{{< button pageRef="{}" >}}}}
{}
{{{{< /button >}}}}]], {
    i(1, "docs/getting-started"),
    i(2, "Mulai"),
  })),

  -- Carousel
  s("bf-carousel", fmt([[
{{{{< carousel images="{{{}}}" aspectRatio="{}" interval="{}" >}}}}]], {
    i(1, "gallery/*"),
    i(2, "16-9"),   -- 16-9 | 21-9 | 4-3 | 1-1
    i(3, "2000"),
  })),

  -- Chart (Chart.js)
  s("bf-chart", fmt([[
{{{{< chart >}}}}
type: '{}',
data: {{
  labels: [{}],
  datasets: [{{
    label: '{}',
    data: [{}],
  }}]
}}
{{{{< /chart >}}}}]], {
    i(1, "bar"),   -- bar | line | pie | doughnut | radar | polarArea
    i(2, "'Jan', 'Feb', 'Mar'"),
    i(3, "Jumlah"),
    i(4, "12, 19, 7"),
  })),

  -- Code Importer (dari URL eksternal)
  s("bf-codeimport", fmt([[
{{{{< codeimporter url="{}" type="{}" startLine="{}" endLine="{}" >}}}}]], {
    i(1, "https://raw.githubusercontent.com/user/repo/main/file.js"),
    i(2, "js"),
    i(3, "1"),
    i(4, ""),
  })),

  -- Email (obfuscated)
  s("bf-email", fmt([[
{{{{< email email="{}" text="{}" subject="{}" >}}}}]], {
    i(1, "mailto:hello@example.com"),
    i(2, "Hubungi saya"),
    i(3, "Halo dari blog"),
  })),

  -- Figure (image dengan optimisasi Hugo Pipes)
  s("bf-figure", fmt([[
{{{{< figure
    src="{}"
    alt="{}"
    caption="{}"
    >}}}}]], {
    i(1, "gambar.jpg"),
    i(2, "Deskripsi alt gambar"),
    i(3, "Keterangan foto di bawah gambar"),
  })),

  -- Figure — dengan link & nozoom
  s("bf-figurel", fmt([[
{{{{< figure
    src="{}"
    alt="{}"
    href="{}"
    target="{}"
    nozoom=true
    >}}}}]], {
    i(1, "gambar.jpg"),
    i(2, "Alt text"),
    i(3, "https://example.com"),
    i(4, "_blank"),
  })),

  -- Gallery
  s("bf-gallery", fmt([[
{{{{< gallery >}}}}
  <img src="{}" class="grid-w{}" alt="{}" />
  <img src="{}" class="grid-w{}" alt="{}" />
{{{{< /gallery >}}}}]], {
    i(1, "01.jpg"), i(2, "50"), i(3, "Gambar 1"),
    i(4, "02.jpg"), i(5, "50"), i(6, "Gambar 2"),
  })),

  -- GitHub Card
  s("bf-github", fmt([[
{{{{< github repo="{}" >}}}}]], { i(1, "username/repo") })),

  -- GitLab Card
  s("bf-gitlab", fmt([[
{{{{< gitlab projectID="{}" >}}}}]], { i(1, "12345678") })),

  -- Codeberg Card
  s("bf-codeberg", fmt([[
{{{{< codeberg repo="{}" >}}}}]], { i(1, "username/repo") })),

  -- Gist embed
  s("bf-gist", fmt([[
{{{{< gist username="{}" gistID="{}" >}}}}]], {
    i(1, "username"),
    i(2, "gist-id"),
  })),

  -- Icon
  s("bf-icon", fmt([[{{{{< icon "{}" >}}}}]], { i(1, "github") })),

  -- KaTeX (matematika)
  s("bf-katex", fmt([[
{{{{< katex >}}}}
{}
{{{{< /katex >}}}}]], { i(1, "\\\\int_0^1 x^2 \\\\,dx = \\\\frac{1}{3}") })),

  -- Keyword
  s("bf-keyword", fmt([[{{{{< keyword >}}}}{}{{{{< /keyword >}}}}]], { i(1, "Kata kunci") })),

  -- Lead (teks pembuka menonjol)
  s("bf-lead", fmt([[
{{{{< lead >}}}}
{}
{{{{< /lead >}}}}]], { i(1, "Kalimat pembuka yang kuat dan menarik perhatian pembaca.") })),

  -- Mermaid diagram
  s("bf-mermaid", fmt([[
{{{{< mermaid >}}}}
{}
{{{{< /mermaid >}}}}]], { i(1, "graph LR\n  A[Start] --> B[Proses] --> C[End]") })),

  -- Tabs
  s("bf-tabs", fmt([[
{{{{< tabs tabTotal="{}" >}}}}
{{{{< tab tabID="1" tabName="{}" >}}}}
{}
{{{{< /tab >}}}}
{{{{< tab tabID="2" tabName="{}" >}}}}
{}
{{{{< /tab >}}}}
{{{{< /tabs >}}}}]], {
    i(1, "2"),
    i(2, "Tab Pertama"),
    i(3, "Konten tab pertama."),
    i(4, "Tab Kedua"),
    i(5, "Konten tab kedua."),
  })),

  -- Timeline
  s("bf-timeline", fmt([[
{{{{< timeline >}}}}
{{{{< timelineItem icon="{}" header="{}" badge="{}" subheader="{}" >}}}}
{}
{{{{< /timelineItem >}}}}
{{{{< /timeline >}}}}]], {
    i(1, "star"),
    i(2, "Judul Event"),
    i(3, "2024"),
    i(4, "Sub-header opsional"),
    i(5, "Deskripsi event di sini."),
  })),

  -- TypeIt (animasi mengetik)
  s("bf-typeit", fmt([[
{{{{< typeit >}}}}
{}
{{{{< /typeit >}}}}]], { i(1, "Teks yang akan diketik secara animatis...") })),

  -- TypeIt — dengan kecepatan & tag kustom
  s("bf-typeitx", fmt([[
{{{{< typeit tag="{}" speed="{}" breakOnType={} >}}}}
{}
{{{{< /typeit >}}}}]], {
    i(1, "h2"),       -- tag HTML: h1-h6, p, span, dll
    i(2, "50"),       -- ms per karakter
    i(3, "false"),
    i(4, "Teks animasi di sini."),
  })),

  -- Video lokal
  s("bf-video", fmt([[
{{{{< video src="{}" autoplay="{}" loop="{}" muted="{}" >}}}}]], {
    i(1, "video.mp4"),
    i(2, "false"),
    i(3, "false"),
    i(4, "true"),
  })),

  -- YouTube Lite (privacy-friendly)
  s("bf-youtube", fmt([[
{{{{< youtubeLite id="{}" label="{}" >}}}}]], {
    i(1, "dQw4w9WgXcQ"),
    i(2, "Judul video YouTube"),
  })),

  -- List shortcode (Blowfish content list)
  s("bf-list", fmt([[
{{{{< list title="{}" cardView={} limit={} where="{}" value="{}" >}}}}]], {
    i(1, "Post Terbaru"),
    i(2, "true"),
    i(3, "5"),
    i(4, "Type"),
    i(5, "post"),
  })),
}
