# iamport

아임포트 테스트를 플러터와 Node.js를 사용하여 해보았다.

실제 결제테스트 까지 하려면 에뮬레이터 말고 실제 핸드폰을 사용하여야 한다.

플러터에는 패키지를 iamport_flutter를 사용하였다. 

기본적인 구성은 node.js 상품정보 -> flutter <-> iamport 방식이다

상품정보는 node.js서버(items.js)를 통해 로컬환경에서 불러오도록 하였다.
/items에 요청을 보내면 상품 목록을 반환한다.

플러터에서 106번 줄 usercode 빈 공간에는 아임포트 가맹점 식별코드가 들어가면 된다.
<img width="529" alt="usercode" src="https://user-images.githubusercontent.com/104212460/219850043-4aad0233-56d4-4dde-99fb-176a4ec33055.png">

그리고 147번 줄 url은 에뮬레이터로 할 땐 로컬호스트로 해도 되지만 핸드폰으로 연결해서 테스트 해볼 때는 자신의 네트워크 ip 주소를 로컬호스트 부분에 적어주면 된다.
<img width="374" alt="주소" src="https://user-images.githubusercontent.com/104212460/219850044-74ca4142-fc83-4c39-9691-f1f71c24b4f7.png">
다음은 테스트 화면 순서이다.

1.어플을 시작했을 때
![IMG_7695](https://user-images.githubusercontent.com/104212460/219849964-118acd56-5992-4e82-b780-5e74ba934015.PNG)

![IMG_7696](https://user-images.githubusercontent.com/104212460/219849977-43607f0a-fbee-4b89-9ece-4640eca4905b.PNG)

![IMG_7697](https://user-images.githubusercontent.com/104212460/219849988-ec7c000b-670f-4021-ad4e-2d227c7408b5.PNG)

![IMG_7698](https://user-images.githubusercontent.com/104212460/219849996-3cfc3055-d5b9-4710-8c9a-3ac1dbe0f2a7.PNG)

![IMG_7699](https://user-images.githubusercontent.com/104212460/219850000-f29710bb-563d-44b8-ac29-2b3d4a28f51a.PNG)

![IMG_7700](https://user-images.githubusercontent.com/104212460/219850006-91f9bc7a-82e9-437c-8e0a-ad932bcb0273.PNG)

테스트 결제를 진행하고 나면 아임포트 관리자 페이지에서 내용을 볼 수 있다.
<img width="1380" alt="iamportlist" src="https://user-images.githubusercontent.com/104212460/219850177-cef96293-d702-477c-975a-4afa081a7f2c.png">
