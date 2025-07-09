# デジタルカードゲームアプリ

このプロジェクトはFlutterで構築されており、スケーラビリティ、テスト容易性、保守性を確保するために**クリーンアーキテクチャ**の原則に基づいています。

## ディレクトリ構成

`lib`ディレクトリは、主に`presentation`, `domain`, `infrastructure`の3つのレイヤーに分割されています。

```
lib
├── domain
│   ├── entities
│   └── repositories
├── infrastructure
│   ├── models
│   └── repositories
├── presentation
│   ├── components
│   ├── pages
│   └── providers
└── main.dart
```

### 📂 `lib`

プロジェクトの全てのDartソースコードを格納するルートディレクトリです。

#### └── 📂 `domain`

このレイヤーはアプリケーションの**コア**であり、ビジネスロジックやルールを含みます。UI、データベース、ネットワークといった他のどのレイヤーからも**完全に独立**しており、それらの技術的な詳細について一切関知しません。

* **`/entities`**: アプリケーションのビジネスオブジェクト（例: `Card`, `Player`, `Deck`）を格納します。これらのオブジェクトは一意のIDを持ち、最も基本的なビジネスルールをカプセル化します。
* **`/repositories`**: データ操作のための**インターフェース（抽象クラスや仕様書）**を定義します。ドメイン層は、データが実際にどのように保存・取得されるかを知ることなく、このインターフェースに依存してデータにアクセスします。

#### └── 📂 `infrastructure`

`domain`レイヤーで定義されたインターフェースの**具体的な実装**を含むレイヤーです。データベース、ネットワークリクエスト、サードパーティサービスなど、すべての外部との接続に関する責務を担います。

* **`/models`**: データソースに特化したデータモデル（例: APIから取得するJSON、Firestoreのドキュメント）を格納します。これらのモデルはドメインのエンティティとの相互変換（マッピング）を担当します。
* **`/repositories`**: `domain`レイヤーのリポジトリインターフェースの具体的な実装を提供します。例えば、`FirebaseCardRepositoryImpl`が`CardRepository`を実装し、Firebase Firestoreへの実際のクエリコードを含みます。

#### └── 📂 `presentation`

UIとユーザーインタラクションに関するすべてを担うレイヤーです。`domain`レイヤーに依存して、データの取得やビジネスロジックの実行を行います。

* **`/pages` (または `/screens`)**: アプリケーションの主要なスクリーン（画面）を格納します。（例: `HomePage`, `GameBoardPage`, `DeckBuilderPage`）
* **`/components` (または `/widgets`)**: 複数のページで再利用されるUIウィジェットを格納します。（例: `CardWidget`, `PlayerAvatar`, `CustomButton`）
* **`/providers` (または `/state`)**: UIの状態を管理します。RiverpodのProviderなど、UIとドメイン層のビジネスロジックを繋ぐための状態管理ロジックをここに配置します。

#### └── 📜 `main.dart`

Flutterアプリケーションのエントリーポイント（起動点）です。アプリの初期化、DI（依存性注入）の設定（例: Riverpodの`ProviderScope`の配置）、ルートウィジェットの定義やルーティングなどを担当します。