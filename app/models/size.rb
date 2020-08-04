class Size < ActiveHash::Base
  self.data = [
    {id: 1, name: "XXS以下"},
    {id: 2, name: "XS(SS)"},
    {id: 3, name: "S"},
    {id: 4, name: "M"},
    {id: 5, name: "L"},
    {id: 6, name: "XL"},
    {id: 7, name: "2XL"},
    {id: 8, name: "3XL"},
    {id: 9, name: "4XL以上"},
    {id: 10, name: "FREE SIZE"}
  ]
end