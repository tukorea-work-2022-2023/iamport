var express = require("express");
var app = express();

app.get("/items", (req, res) => {
  return res.json([
    {
      id: "1",
      title: "item1",
      ea: "1",
      des: "item 1 description",
      price: "10000",
      imgsrc:
        "https://cdn.pixabay.com/photo/2020/04/08/16/32/keyboard-5017973__480.jpg",
    },
    {
      id: "2",
      title: "item2",
      ea: "2",
      des: "item 2 description",
      price: "20000",
      imgsrc:
        "https://cdn.pixabay.com/photo/2020/04/08/16/32/keyboard-5017973__480.jpg",
    },
  ]);
});

app.listen(3000, () => {
  console.log(3000);
});
