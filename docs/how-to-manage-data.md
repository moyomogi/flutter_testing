# Firestore でのデータの持ち方について

## users

- XY60466176 (USER_INTERNAL_ID)
  - id: XY60466176
  - // internalId: XY60466176
  - userId: hagoromo_lala
  - name: "羽衣 ララ"
  - undergraduate: ["工学部", "電子物理工学科"]
    // undergraduate に応じて、選べる subjectIds が限定できたらいいな。
  - subjectIds: [ssssss, tttttt, uuuuuu]
    // 画像周りは面倒なので後回し
  - iconUrl: "https://"
  - thumbUrl: "https://"

## posts

- 3Eer03R36 (POST_ID)
  - id: 3Eer03R36
  - userId: yatapngn
  - subjectId: ssssss
  - text: "天にあまねくミルキーウェイ！キュアミルキー！"
  - imageUrls: ["https://", "https://"]
  - postTime: "1995-12-17 03:24:00"

## subjects

- ssssss (SUBJECT_ID)
  // 授業コード
  - id: ssssss
  - name: 微積分学 II
  - professors: ["ユニ"]
    // 開講期間 "2022-A" == "2022 前期"
  - duration ["2022-A"]
    // 配当年次
  - grade: 1
    // 授業概要
  - classOutline: "惑星サマーン出身の宇宙人。責任感が強くて真面目だけど、ちょっと抜けているところも。チャームポイントは頭についたセンサー。"
- tttttt
  - id: tttttt
  - name: 応用物理学実験
  - professors: ["星名 ひかる", "安野 希世乃"]
  - dayOfTheWeek: ["Wed3", "Wed4"]
  - grade: 2
- uuuuuu
  - id: uuuuuu
  - name: コンピュータアーキテクチャ
  - professors: ["香久矢 まどか"]
    // 2022 前期
  - duration ["2022-A"]
  - dayOfTheWeek: ["Mon1", "Tue1"]
  - grade: 2
