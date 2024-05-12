## ⚙️ CoreData
CoreData는 애플이 제공하는 프레임워크로, 애플리케이션의 모델 계층 객체를 관리합니다. 이를 통해 객체 그래프를 효율적으로 저장, 검색, 관리할 수 있어 iOS 및 macOS 앱에서 데이터 영속성을 다루는 것을 더욱 쉽게 만들어줍니다.

<br/>

## 🛠️ CoreData Workflow

1. **Entity 생성 및 Attribute 설정** <br/>
CoreData에서 데이터 모델을 정의할 때 먼저 Entity를 생성하고, 각 Entity에는 속성(Attribute)을 설정합니다. 이 속성들은 해당 Entity의 데이터 구조를 나타냅니다. 필요에 따라 관계(relationship)도 설정할 수 있습니다.

2. **Persistant Container 생성** <br/>
CoreData를 사용하기 위해 먼저 Persistent Container를 생성해야 합니다. Persistent Container는 CoreData 스택의 핵심이며, 데이터베이스와 상호작용하는데 사용됩니다.

3. **Persistant Container의 `loadPersistentStores` 메소드로 Context 로드**  <br/>
Persistent Container를 생성한 후, `loadPersistentStores` 메소드를 사용하여 데이터를 로드할 수 있는 데이터베이스의 저장소를 설정하고, 데이터를 로드하여 CoreData 스택의 Context를 초기화합니다.

4. **Entity 불러오기**  <br/>
CoreData에서 저장된 데이터를 사용하려면 먼저 해당 데이터 모델의 Entity를 불러와야 합니다. 이를 통해 데이터를 읽고 쓸 수 있습니다.

5. **Object 생성**  <br/>
Entity를 기반으로 객체를 생성하여 데이터를 추가하거나 수정할 수 있습니다. 이렇게 생성된 객체는 CoreData의 관리 아래에 있으며, 변경 사항을 추적하고 데이터베이스에 동기화합니다.

6. **Persistant Container를 사용해서 데이터 저장 및 삭제 가능**  <br/>
데이터를 CoreData에 저장하려면 Persistant Container를 사용하여 Context를 저장하고 변경 사항을 커밋해야 합니다. 또한 데이터를 삭제하려면 Context에서 해당 객체를 삭제하고 변경 사항을 커밋하면 됩니다.
